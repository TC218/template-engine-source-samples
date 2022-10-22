package rflib.common.hscript._Interp;

extern enum rflib.common.hscript.priv_Interp.Stop {
	SBreak;
	SContinue;
	SReturn(v : Dynamic);
}
