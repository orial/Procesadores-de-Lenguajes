import java_cup.runtime.*;

%%

%cup

/* literales punto flotante */        
DoubleLiteral = ({FLit1}|{FLit2}|{FLit3}) {Exponent}?

FLit1    = [0-9]+ \. [0-9]* 
FLit2    = \. [0-9]+ 
FLit3    = [0-9]+ 
Exponent = [eE] [+-]? [0-9]+

%%

/* Expresiones y reglas */

               /* palabras reservadas */

    "print"                 { return new Symbol(sym.PRINT); }
    "if"                    { return new Symbol(sym.IF, Generador.getTag()); }
    "else"                  { return new Symbol(sym.ELSE); }
    "while"                 { return new Symbol(sym.WHILE, Generador.getTag()); }
    "do"                    { return new Symbol(sym.DO, Generador.getTag()); }
    "for"                   { return new Symbol(sym.FOR, Generador.getTag()); }
        
    
               /* Separadores */

    "("                     { return new Symbol(sym.AP); }
    ")"                     { return new Symbol(sym.CP); }
    "{"                     { return new Symbol(sym.AK); }
    "}"                     { return new Symbol(sym.CK); }
    ";"                     { return new Symbol(sym.PYC); }
       

               /* Operadores */

     
    "+"                     { return new Symbol(sym.MAS); }
    "-"                     { return new Symbol(sym.MENOS); }
    "*"                     { return new Symbol(sym.POR); }
    "/"                     { return new Symbol(sym.DIV); }
    "="                     { return new Symbol(sym.ASIG); }
    ">"                     { return new Symbol(sym.MAY);  }
    "<"                     { return new Symbol(sym.MEN); }
    "=="                    { return new Symbol(sym.IG); }
    "<="                    { return new Symbol(sym.MENIG); }
    ">="                    { return new Symbol(sym.MAYIG); }
    "!="                    { return new Symbol(sym.NIG); }
    "!"                     { return new Symbol(sym.NOT); }
    "&&"                    { return new Symbol(sym.AND); }
    "||"                    { return new Symbol(sym.OR); }

               /* numeros enteros*/

    0|[1-9][0-9]*           { return new Symbol(sym.NUMERO, new Integer(yytext())); }
                
               /* numeros punto flotante y exponentes */

    {DoubleLiteral}         { return new Symbol(sym.NUMEROF, new Double(yytext())); }   

               /* Identificadores */

    [_a-zA-Z][_a-zA-Z0-9]*  { return new Symbol(sym.IDENT, yytext()); }

               /* Error */

    [^]                     {  }
