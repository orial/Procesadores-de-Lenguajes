import java_cup.runtime.*;
%%

/*  Declaraciones */   
   
%cup 
Comentario1	= "#" [^\r\n]* [\r\n\t\f]?
Comentario2	= ''' [^(''')]* '''
%%   

/* Expresiones y reglas */
    print	       { return new Symbol(sym.PRINT); }
    "+"                { return new Symbol(sym.MAS); }
    "-"                { return new Symbol(sym.MENOS); }
    "**"		{ return new Symbol(sym.POTENCIA);}
    "*"                { return new Symbol(sym.POR); }
    "/"                { return new Symbol(sym.DIV); }
    ":"			{ return new Symbol(sym.DP); }
    ","			{ return new Symbol(sym.COMA);}
    "("                { return new Symbol(sym.AP); }
    ")"                { return new Symbol(sym.CP); }
    \t|(\ \ \ \ )	{ return new Symbol(sym.TAB); }
    ";"                { return new Symbol(sym.PYC); }
    "{"			{ return new Symbol(sym.ALL);}
    "}"			{ return new Symbol(sym.CLL);}
    "&&"		{ return new Symbol(sym.AND);}
    "||"		{ return new Symbol(sym.OR);}
    "="			{ return new Symbol(sym.IGUAL); }
    ==		{ return new Symbol(sym.IGUALQUE);}
    "<"			{ return new Symbol(sym.MENORQUE);}
    "<="		{ return new Symbol(sym.MENOROIGUAL);}
    ">="		{ return new Symbol(sym.MAYOROIGUAL);}
    ">"			{ return new Symbol(sym.MAYORQUE);}
    "!="                { return new Symbol(sym.NOTEQUAL);}
    in			{ return new Symbol(sym.EN);}
    range		{ return new Symbol(sym.COCINA);}
    for			{ return new Symbol(sym.FOR, Etiqueta.call());}
    while		{ return new Symbol(sym.WHILE, Etiqueta.call());}
    elif		{ return new Symbol(sym.ELIF, Etiqueta.call());}
    if			{ return new Symbol(sym.IF, Etiqueta.call());}
    else		{ return new Symbol(sym.ELSE);}
    0|[1-9][0-9]*      { return new Symbol(sym.NUMERO, new String(yytext()) ); }
    [A-Za-z_][0-9A-Za-z_]* { return new Symbol(sym.VAR_NAME, new String(yytext()) ); }
    {Comentario1}	{}
    {Comentario2}	{}
    [\r]		   { return new Symbol(sym.FINAL);}
    [\ \n \f]      {  }  
    [^]                { throw new Error("Illegal character <"+yytext()+">"); }
