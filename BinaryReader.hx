package rflib.common.utils.bin;


import haxe.io.Bytes;
import haxe.Int64;
import haxe.ds.IntMap;
import haxe.ds.StringMap;

import rflib.common.Imports;

private typedef FMT = BinaryFormat;

enum BinaryReaderError
{
  enum_not_found(ename:String);
  enum_constructor(ename:String, ec:String, params:Array<Dynamic>);
  enum_params(ename:String, ec:String, params:Array<Dynamic>);
  class_not_found(cname:String);
  invalid_hash;
  magic_id;
  wrong_size;
  input_data_truncated;
}


private typedef ReadError = BinaryReaderError;


class BinaryReader extends BufferValuesReader
{    
  var sizes_pos : Int;
  var total_size : UInt;
  
  var packet_desc : Int;
  var sizes : Array<UInt>;
  var symbols : Array<String>;
  var local_symbols : Array<String>;
  var symbols_hashes : Map<Int, Int>;
  
  var hash_type : BinaryFormatHashType;
  var hash : Bytes;

  var containers_sizes_offsets(get, never):Bool;
  inline function get_containers_sizes_offsets():Bool return packet_desc & FMT.PACKET_CONTAINERS_SIZES_OFFSETS > 0;

  var bits_r : BitsBufferReader;
  
  
  public function new()
  {
    super();
    
    reset();
  }
  
  
  public function reset()
  {
    symbols = [];
    symbols_hashes = new Map<Int, Int>();    
  }
  
  
  public function unserialize(bytes:Bytes):Dynamic
  {
    if (bytes == null) throw new HException(1);
    
    init(bytes);
    
    var head_len : Int;
    var sizes_len : Int = 0;
    var content_len = 0;
    var symbols_len : Int = 0;
    var size_int_len = 0;
    var hash_len = 0;
    
    sizes = [];
    
    
    // head
    { 
      if (readUInt16() != FMT.MAGIC_NUMBER) throw ReadError.magic_id;

      total_size = readVarUInt();      
      
      size_int_len = pos - 2;
      total_size += size_int_len;
      
      
      packet_desc = readByte();
      
      if (containers_sizes_offsets)
      {
        sizes_len = readVarUInt();    
      }
      else {
        content_len = readVarUInt();    
      }
      
      
      if (packet_desc & FMT.PACKET_USE_SYMBOLS > 0) {
        symbols_len = readVarUInt();        
      }
      
      if (packet_desc & FMT.PACKET_USE_HASH > 0) 
      {
        hash_type = cast readByte();
        
        switch (hash_type)
        {
          case sha1:
            hash_len = 20;
            
            var content = BytesHelper.slice(bytes, 0, total_size-hash_len);
            var hash_recorded = BytesHelper.slice(bytes, total_size-hash_len, hash_len);
            
            var hash = 
              #if (hl && c_ext)
                rflib.c.Sha1.ofBytes(content);
              #else
                haxe.crypto.Sha1.make(content);
              #end
            
            if (hash_recorded.compare(hash) != 0) throw ReadError.invalid_hash;
            
        }

      }
      
      
      head_len = pos;
    }


    // sizes
    if (containers_sizes_offsets)
    {
      var sizes_count = readVarUInt();
      if (sizes_count == 0) throw new HException(4);
            
      var prev_val = 0;
            
      for (i in 0...sizes_count)
      {
        prev_val = sizes[i] = prev_val + readVarInt(); 
        
        if (i == 0)
        {
          content_len = sizes[0];
          
          // packet size validation
          var calculated_size:UInt = (head_len + sizes_len + content_len + symbols_len + hash_len);
          
          if (calculated_size != total_size) throw ReadError.wrong_size;
          if (total_size > bytes.length) throw ReadError.input_data_truncated;
        }
      }
      
      if (pos != (head_len + sizes_len)) throw new HException(6);
      
      sizes_pos = sizes.length - 1;
    }
    else
    {
      // packet size validation
      var calculated_size:UInt = (head_len + symbols_len + content_len + hash_len);
      
      if (calculated_size != total_size) throw ReadError.wrong_size;
      if (total_size > bytes.length) throw ReadError.input_data_truncated;
      
    }
    
    
    var content_pos = pos;
    pos += content_len;
    
    
    if (packet_desc & FMT.PACKET_USE_SYMBOLS > 0)
    {
      var packet_symbols_start_at = readVarUInt();
      
      if (packet_symbols_start_at > 0)
      {
        if (packet_symbols_start_at > symbols.length) throw new HException(7);
/*        
        var hash_low = readUInt16();
        var hash_high = readUInt16();
        var shash = symbolsHashAt( packet_symbols_start_at );
        
        if (shash._low != hash_low || shash._high != hash_high) throw new HException();        
        */
        
        //var hash = readInt32();        
        //if (hash != symbolsHashAt( packet_symbols_start_at )) throw new HException(8);        
        
      }
      
      
      symbols = readStringArray();      
      
      /*
      if (packet_symbols_start_at == 0 && symbols.length > 0 && local_symbols.length > 0) throw new HException(9);
      
      symbols = symbols.concat(local_symbols);
      */
      
      /*
      if (symbols == null) symbols = local_symbols;
      else 
      {
        
      }*/
      
    }
    
    pos = content_pos;
    return readVal();
  }
  
    
  
  function readVal(?eltype:Null<Int>):Dynamic
  {
    var pos0 = pos;    
    var vt : Null<Int> = eltype;
    
    if (eltype == null || eltype == FMT.VAR_DYNAMIC || eltype == FMT.VAR_BOOL || eltype == FMT.VAR_NULL)
    {
      var val = readByte();
      
      vt = val & FMT.VAR_TYPE_MASK;
      
      if (vt == FMT.VAR_BOOL) {
        return (val & FMT.VAR_BOOL_TRUE > 0);
      }
      else if (vt == FMT.VAR_NULL) {
        return null;
      }
    }
    
    switch (vt)
    {
      case FMT.VAR_INT: return readVarInt();
      case FMT.VAR_INT64: return readVarInt64();
      case FMT.VAR_FLOAT: return readDouble();
      case FMT.VAR_STRING: return readString();     
      case FMT.VAR_BYTES: return readBytes(); 
          
      case FMT.VAR_ENUM: return readEnum();    
       
      case FMT.VAR_DATE, FMT.VAR_DATE_NSEC: 
        if (bits_r == null) bits_r = new BitsBufferReader();
        
        bits_r.reset(readBytes());
        
        var lengths = [16,4,5, 5,6,6];
        if (vt == FMT.VAR_DATE_NSEC) {
          lengths.push(30);
        }
        
        var v = bits_r.readValues(lengths);
        var d = new Date(v[0], v[1], v[2]+1, v[3], v[4], v[5]);
        
        return (vt == FMT.VAR_DATE_NSEC) ? new DatePlus(d, v[6]) : d;
      
      case FMT.VAR_ARRAY:      
        var len = readVarUInt();
        var elt:Null<Int> = (len > 0) ? readByte() : null;
        var a:Array<Dynamic> = [];
        
        for (i in 0...len)
        {
          a.push(readVal(elt));
        }

        if (containers_sizes_offsets)
        {
          var size = sizes[sizes_pos--];                  
          if (pos - pos0 != size) throw new HException(10);
        }
        
        return a;
        
        
      case FMT.VAR_STRINGMAP:        
        var len = readVarUInt();
        var elt:Null<Int> = (len > 0) ? readByte() : null;
        var map = new Map<String, Dynamic>();
        var keys:Array<Int> = [];
        
        for (i in 0...len)
        {
          keys.push(readVarUInt());
        }
        
        for (i in 0...len)
        {
          map.set(symbols[keys[i]], readVal(elt));
        }
        
        if (containers_sizes_offsets)
        {
          var size = sizes[sizes_pos--];                  
          if (pos - pos0 != size) throw new HException(10);
        }
        
        return map;


      case FMT.VAR_INTMAP:
        var len = readVarUInt();
        var elt:Null<Int> = (len > 0) ? readByte() : null;
        var map = new Map<Int, Dynamic>();
        var keys:Array<Int> = [];
        
        for (i in 0...len)
        {
          keys.push(readVarInt());
        }
        
        for (i in 0...len)
        {
          map.set(keys[i], readVal(elt));
        }
        
        if (containers_sizes_offsets)
        {        
          var size = sizes[sizes_pos--];                          
          if (pos - pos0 != size) throw new HException(10);
        }
        
        return map;
      
      
      case FMT.VAR_OBJECT:
        var len = readVarUInt();
        var elt:Null<Int> = (len > 0) ? readByte() : null;
        var object:Dynamic = {};
        var keys:Array<Int> = [];
        
        for (i in 0...len)
        {
          keys.push(readVarUInt());
        }
        
        for (i in 0...len)
        {
          Reflect.setField(object, symbols[keys[i]], readVal(elt));
        }
        
        if (containers_sizes_offsets)
        {        
          var size = sizes[sizes_pos--];                          
          if (pos - pos0 != size) throw new HException(10);
        }
        
        return object;


      case FMT.VAR_CLASS_INSTANCE: return readClassInstance();      
    }    
    
    throw new HException();
  }


  function readEnum():EnumValue
  {
    var ename = symbols[readVarUInt()];
    var e = Type.resolveEnum(ename);
    if (e == null) throw new HException(ReadError.enum_not_found(ename));
    
    var ec = symbols[readVarUInt()];
    var ep = readVal();
    if (!Std.is(ep, Array)) throw new HException(ReadError.enum_params(ename, ec, ep));
    
    var eval = Type.createEnum(e, ec, ep);
    if (eval == null) throw new HException(ReadError.enum_constructor(ename, ec, ep));
    
    return eval;
  }
  
  
  function readClassInstance()
  {
    var pos0 = pos;
    
    var cname = symbols[readVarUInt()];
    var c = Type.resolveClass(cname);
    if (c == null) throw new HException(ReadError.class_not_found(cname));
    
    var len = readVarUInt();
    var elt:Null<Int> = (len > 0) ? readByte() : null;
    
    var object:Dynamic = Type.createEmptyInstance(c);
    var init_new = Ref.field(object, 'init_new');

    
    var keys:Array<Int> = [];
    
    for (i in 0...len)
    {
      keys.push(readVarUInt());
    }
    
    for (i in 0...len)
    {
      Reflect.setField(object, symbols[keys[i]], readVal(elt));
    }
    
    if (Ref.isFunction(init_new)) {
      Ref.callMethod(object, init_new, []);
    }

    
    if (containers_sizes_offsets)
    {        
      var size = sizes[sizes_pos--];                          
      if (pos - pos0 != size) throw new HException(10);
    }
    
    return object;
  }
  
  

  function symbolsHashAt(index:Int):Int
  {    
    return 0;
    
    if (symbols_hashes.exists(index)) {
      return symbols_hashes.get(index); 
    }
    
    var seed = FMT.HASH_SYMBOLS_SEED;
    var start = 0;
    var max_less_index = 0;
    
    for (i in symbols_hashes.keys())
    {
      if (i < index && i > max_less_index) {
        max_less_index = i;
      }
    }
    
    if (max_less_index > 0) 
    {
      seed = symbols_hashes.get(max_less_index);
      start = max_less_index;
    }    
    
    /*
    var symbols_hash:Dynamic = XXH(seed);    
    var last_digest:Dynamic = null;
    
    for (i in start...index)
    {
      var sb = Bytes.ofString(symbols[i]);
      symbols_hash.update(getBufferOfBytes(sb));     
           
      last_digest = symbols_hash.digest();
    }
    
    var dhash = (last_digest._high << 16) | last_digest._low;        
    symbols_hashes[index] = dhash;
    
    return dhash;*/
  }


  inline function log(a:Dynamic) return Sys.println(''+a);


  static inline var DEFAULT_BUFSIZE:Int = 1 << 15;
  
  public function readFromStream(recv:UInt -> Bytes, ?bufsize:Int=DEFAULT_BUFSIZE ):Dynamic
  {
    var b = readPacketFromStream(recv, bufsize);
    return (b != null) ? unserialize(b) : null;
  }
  
  
  public function readPacketFromStream(recv:UInt -> Bytes, ?bufsize:Int=DEFAULT_BUFSIZE ):Bytes
  {
    var b = recv(6);
    if (b == null || b.length == 0) return null;

    init(b);
    
    if (readUInt16() != BinaryFormat.MAGIC_NUMBER) throw new HException('Invalid stream data.');
    
    var size = readVarUInt();
    size += pos - 2;
    
    var bytes_left = size - b.length;

    //println('size: ' + size);
    //println('bytes_left: ' + bytes_left);
    
    if (bytes_left > 0)
    {
      var b2 = Bytes.alloc(size);
      var pos = b.length;
      
      b2.blit(0, b, 0, b.length);
      
      while (bytes_left > 0)
      {      
        var sz = (bytes_left > bufsize) ? bufsize : bytes_left;
        var rb = recv(sz);
        if (rb == null || rb.length == 0) return null;
    
        b2.blit(pos, rb, 0, rb.length);
        pos += rb.length;
        bytes_left -= rb.length;
        
        //println('b: ' + rb.length);
      }
      
      b = b2;
    }
    
    //log('readPacketFromStream() result bytes: ' + b.length);
    
    return b;
  }
  
}
