package rflib.common.sys;

extern enum ExecError {
	error(stderr : rflib.common.Bytes, ?stdout : rflib.common.Bytes);
}
