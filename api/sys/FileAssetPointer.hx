package rflib.common.sys;

extern class FileAssetPointer extends rflib.common.utils.AssetPointer {
	@:pure(inferredPure) function new(local_path : String, ?context_path : String) : Void;
}
