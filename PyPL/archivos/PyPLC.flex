import java_cup.runtime.*;
import java.util.Stack;


%%

%cup

%init{
	this.pila.push(0);
	current_indent = 0;
	yybegin(indent_state);
%init}

%{
	private static final int TAB_LENGTH = 4;
	private int current_indent;
	Stack<Integer> pila = new Stack<Integer>();
%}	

%state indent_state 
%state normal_state

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace     = [ \t\f]

 /* Comentarios */
Comment = {ApostrofeComment} | {HashComment}

ApostrofeComment  = "'''" [^*] ~"'''"
HashComment     = "#" {InputCharacter}* {LineTerminator}?


%%

/* Expresiones y reglas */

<normal_state>{
               /* palabras reservadas */

    "print"                 { return new Symbol(sym.PRINT); }
    "if"                    { return new Symbol(sym.IF, Generador.getTag()); }
    "elif"					{ return new Symbol(sym.ELIF, Generador.getTag()); }
    "else"                  { return new Symbol(sym.ELSE); }
    "while"                 { return new Symbol(sym.WHILE, Generador.getTag()); }
    "for"                   { return new Symbol(sym.FOR, Generador.getTag()); }
    "in"					{ return new Symbol(sym.IN, Generador.getTag()); }
    "range"					{ return new Symbol(sym.RANGE, Generador.getTag()); }       
    
               /* Separadores */

    "("                     { return new Symbol(sym.AP); }
    ")"                     { return new Symbol(sym.CP); }
    ";"                     { return new Symbol(sym.PYC); }
    ","						{ return new Symbol(sym.COMA); }
    ":"						{ return new Symbol(sym.DOSPUNTOS); }
       

               /* Operadores */
 
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

               /* numeros enteros*/

    0|[1-9][0-9]*           { return new Symbol(sym.NUMERO, new Integer(yytext())); }

               /* Identificadores */

    [_a-zA-Z][_a-zA-Z0-9]*  { return new Symbol(sym.IDENT, yytext()); }
    "."						{ return symbol(sym.FULLSTOP); }

	{WhiteSpace}			{	/*Ignore whitespaces*/ }

	{LineTerminator}		{	yybegin(indent_state);
								current_indent = 0;
								return new Symbol(sym.NEWLINE);
							}
}

<indent_state>{

	" "			   			{ current_indent++; }
	"\t"			   		{ current_indent = current_indent + TAB_LENGTH; }
	"\f"					{ /*Ignore whitespace*/ }
	.						{	yypushback(1);
								if(current_indent > pila.peek()){
									pila.push(current_indent);
									yybegin(normal_state);
									return new Symbol(sym.INDENT);
								}
								else if(current_indent == pila.peek()){
									yybegin(normal_state);
								}
								else{
									int tmp = pila.pop();
									return new Symbol(sym.DEDENT);
								}
							}
	{LineTerminator}		{	if(current_indent > pila.peek()){
									pila.push(current_indent);
									yybegin(normal_state);
									return new Symbol(sym.INDENT);
								}
								else if(current_indent == pila.peek()){
									yybegin(normal_state);
								}
								else{
									yypushback(1);
									int tmp = pila.pop();
									return new Symbol(sym.DEDENT);
								}
							}
}

    {Comment}				{	/* ignore comments*/ }
    [^]                     { throw new Error("Illegal character <"+yytext()+">"); }