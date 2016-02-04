import java_cup.runtime.*;

%%

// Codigo (manejo de etiquetas)

%{
	public String newLabel(){
		return Generador.getInstance().newLabel();
	}
%}

//  Declaraciones
   
%cup

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]

/* Comentarios */
Comment = {TraditionalComment} | {EndOfLineComment} | {DocumentationComment} | {HashComment}

TraditionalComment 	= "/*" [^*] ~"*/" | "/*" "*"+ "/"
EndOfLineComment 	= "//" {InputCharacter}* {LineTerminator}?
DocumentationComment    = "/*" "*"+ [^/*] ~"*/"
HashComment		= "#" {InputCharacter}* {LineTerminator}

%%   

// Expresiones y Reglas

// Operadores
    "+"                         { return new Symbol(sym.MAS); }
    "-"                         { return new Symbol(sym.MENOS); }
    "*"                         { return new Symbol(sym.POR); }
    "/"                         { return new Symbol(sym.DIV); }
// Precedencia y Bloques
    "("                         { return new Symbol(sym.AP); }
    ")"                         { return new Symbol(sym.CP); }
    "{"                         { return new Symbol(sym.ALL); }
    "}"                         { return new Symbol(sym.CLL); }
// Delimitador
    ";"                         { return new Symbol(sym.PYC); }
// Asignaciones
    "="                         { return new Symbol(sym.ASIG); }
// Comparaciones
    "=="                        { return new Symbol(sym.EQ); }
    "!="                        { return new Symbol(sym.NEQ); }
    "<"                         { return new Symbol(sym.LOW); }
    "<="                        { return new Symbol(sym.LOE); }
    ">"                         { return new Symbol(sym.GRE); }
    ">="                        { return new Symbol(sym.GOE); }
// Logicos
    "!"                         { return new Symbol(sym.NOT); }
    "&&"                        { return new Symbol(sym.AND); }
    "||"                        { return new Symbol(sym.OR); }
// Codigo
    "if"                        { return new Symbol(sym.IF, newLabel()); }
    "else"                      { return new Symbol(sym.ELSE); }
    "while"                     { return new Symbol(sym.WHILE, newLabel()); }
    "do"                        { return new Symbol(sym.DO, newLabel()); }
    "for"                       { return new Symbol(sym.FOR, newLabel()); }
    "print"                     { return new Symbol(sym.PRINT); }
// Numeros
    0|[1-9][0-9]*               { return new Symbol(sym.ENTERO, new Integer(yytext()) ); }
// Comentarios
    {Comment}                   { }
// Identificadores
    [_a-zA-Z$][_a-zA-Z0-9$]*    { return new Symbol(sym.IDENT, yytext()); }
// Otros
    \ |\t\f                     {  }
    [^]                         { /*throw new Error("Illegal character <"+yytext()+">");*/ }
