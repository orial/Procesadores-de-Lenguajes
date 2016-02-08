import java_cup.runtime.*;
import java.util.Stack;


%%

%cup


LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = [ \t\f]

 /* Comentarios */
Comment = {ApostrofeComment} | {HashComment}

ApostrofeComment  = "'''" [^*] ~"'''"
HashComment     = "#" {InputCharacter}* {LineTerminator}?


%%

/* Expresiones y reglas */

"print"                 { return new Symbol(sym.PRINT); }
"if"                    { return new Symbol(sym.IF, Generador.getTag()); }
"elif"					{ return new Symbol(sym.ELIF, Generador.getTag()); }
"else"                  { return new Symbol(sym.ELSE); }
"while"                 { return new Symbol(sym.WHILE, Generador.getTag()); }
"for"                   { return new Symbol(sym.FOR, Generador.getTag()); }
"in"					{ return new Symbol(sym.IN, Generador.getTag()); }
"range"					{ return new Symbol(sym.RANGE, Generador.getTag()); }       
"("                     { return new Symbol(sym.AP); }
")"                     { return new Symbol(sym.CP); }
";"                     { return new Symbol(sym.PYC); }
","						{ return new Symbol(sym.COMA); }
":"						{ return new Symbol(sym.DOSPUNTOS); }
"+"                     { return new Symbol(sym.MAS); }
"-"                     { return new Symbol(sym.MENOS); }
"*"                     { return new Symbol(sym.POR); }
"/"                     { return new Symbol(sym.DIV); }
"//"                    { return new Symbol(sym.DIV); }
"**"					{ return symbol(sym.POW); }
"%"						{ return symbol(sym.MOD); }
"="                     { return new Symbol(sym.ASIG); }
">"                     { return new Symbol(sym.MAY);  }
"<"                     { return new Symbol(sym.MEN); }
"=="                    { return new Symbol(sym.IG); }
"<="                    { return new Symbol(sym.MENIG); }
">="                    { return new Symbol(sym.MAYIG); }
"!="                    { return new Symbol(sym.NIG); }
"."						{ return new Symbol(sym.FULLSTOP); }

0|[1-9][0-9]*           { return new Symbol(sym.NUMERO, new Integer(yytext())); }

[_a-zA-Z][_a-zA-Z0-9]*  { return new Symbol(sym.IDENT, yytext()); }

\t|(\ \ \ \ )   		{ return new Symbol(sym.TAB); }

{WhiteSpace}			{	/*Ignore whitespaces*/ }

{Comment}				{	/* ignore comments*/ }

[^]                     { throw new Error("Illegal character <"+yytext()+">"); }