import java_cup.runtime.*;

%%
%cup
%%
	"+"		{ return new Symbol(sym.MAS); }
	"-"		{ return new Symbol(sym.MENOS); }
	"**"    { return new Symbol(sym.POTENCIA); }
	"*"		{ return new Symbol(sym.POR); }
	"//"    { return new Symbol(sym.DIV_ENT); }
	"/"		{ return new Symbol(sym.DIV); }
	"%"     { return new Symbol(sym.MODULO); }
	"("		{ return new Symbol(sym.AP); }
	")"		{ return new Symbol(sym.CP); }
	"{"		{ return new Symbol(sym.AC); }
	"}"		{ return new Symbol(sym.CC); }
	";"		{ return new Symbol(sym.PYC); }
	":"		{ return new Symbol(sym.DOSPUNTOS); }
	">="	{ return new Symbol(sym.GTE); }
	">"		{ return new Symbol(sym.GT); }
	"<="	{ return new Symbol(sym.LTE); }
	"<"		{ return new Symbol(sym.LT); }
	"=="	{ return new Symbol(sym.EQ); }
	"!="	{ return new Symbol(sym.DIST); }
	"&&"	{ return new Symbol(sym.AND); }
	"||"	{ return new Symbol(sym.OR); }
	"!"		{ return new Symbol(sym.NOT); }
	"="		{ return new Symbol(sym.ASIG); }

	"#"     { return new Symbol(sym.COMENT); }
	\'\'\'  { return new Symbol(sym.COMENT_MULT); }

	if		{ return new Symbol(sym.IF, BloqueCondicion.nuevaEtq()); }
	else	{ return new Symbol(sym.ELSE); }
	while	{ return new Symbol(sym.WHILE, BloqueCondicion.nuevaEtq()); }
	do 		{ return new Symbol(sym.DO, BloqueCondicion.nuevaEtq()); }
	for 	{ return new Symbol(sym.FOR, BloqueCondicion.nuevaEtq()); }
	print	{ return new Symbol(sym.PRINT); }

	int     { return new Symbol(sym.INT); }

	0|[1-9][0-9]*   { return new Symbol(sym.ENTERO,	  new Integer(yytext()) ); }
	[a-z_][A-Za-z]*	{ return new Symbol(sym.IDENT, new String (yytext()) ); }

    \t|(\ \ \ \ )   { return new Symbol(sym.TAB); }
	[\ \f\r\n]          {  }
	[^]             { throw new Error("Illegal character <"+yytext()+">"); }

