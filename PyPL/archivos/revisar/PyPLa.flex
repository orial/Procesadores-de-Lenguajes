import java_cup.runtime.*;
import java.io.IOException;
import java.util.Stack;

import parser.sym;
import static parser.sym.*;

%%

%class LekserLex

%unicode
%line
%column
%public
%cup

%init{
	this.stack.push(0);
	current_indent = 0;
	yybegin(indent_state);
%init}

%{
  	private Symbol symbol(int type) {
    	return new Symbol(type, yyline, yycolumn);
  	}
  
 	private Symbol symbol(int type, Object value) {
    	return new Symbol(type, yyline, yycolumn, value);
  	}
	
	private static final int TAB_LENGTH = 4;
	
	Stack<Integer> stack = new Stack<Integer>();
	private int current_indent;
%}

%state indent_state 
%state normal_state


LineTerminator 	= \r|\n|\r\n
WhiteSpace    	= [ \t\f]
digit			= [0-9]
integer			= {digit}+
float			= {pointfloat} | {exponentfloat}
pointfloat      = {intpart}? {fraction} | {intpart} "."
exponentfloat   = ( {intpart} | {pointfloat} ) {exponent}
intpart 		= {integer}
fraction 		= "." {integer}
exponent 		= ( "e" | "E" ) [ "+" | "-" ] {integer}
letter 			= {lowercase} | {uppercase}
lowercase 		= [a-z]
uppercase 		= [A-Z]
identifier 		= ({letter}|"_") ({letter} | {digit} | "_")*
comment			= #[^\n]*



%%


<normal_state>{
"print"				{	return symbol(sym.PRINT);}
"+"					{	return symbol(sym.PLUS);}
"-"					{	return symbol(sym.MINUS);}
"**"				{	return symbol(sym.POW);}
"*"					{	return symbol(sym.MULT);}
"/"					{	return symbol(sym.DIV);}
"%"					{	return symbol(sym.MOD);}
"("					{	return symbol(sym.LEFTPARENTHESE);}
")"					{	return symbol(sym.RIGHTPARENTHESE);}
"input"				{	return symbol(sym.INPUT);}
","					{	return symbol(sym.COMMA);}
"not"				{	return symbol(sym.NOT);}
"<"					{	return symbol(sym.LESS);}
">"					{	return symbol(sym.GREATER);}
"=="				{	return symbol(sym.EQUAL);}
">="				{	return symbol(sym.GREATEROREQUAL);}
"<="				{	return symbol(sym.LESSOREQUAL);}
"!="				{	return symbol(sym.NOTEQUAL);}
"or"				{	return symbol(sym.OR);}
"and"				{	return symbol(sym.AND);}
"True"				{	return symbol(sym.TRUE);}
"False"				{	return symbol(sym.FALSE);}
"if"				{	return symbol(sym.IF);}
"else"				{	return symbol(sym.ELSE);}
":"					{	return symbol(sym.COLON);}
";"					{	return symbol(sym.SEMICOLON);}
"pass"				{	return symbol(sym.PASS);}
"="					{	return symbol(sym.ASSIGN);}
"while"				{	return symbol(sym.WHILE);}
"["					{	return symbol(sym.LEFTSQUAREBRACKET);}
"]"					{	return symbol(sym.RIGHTSQUAREBRACKET);}
"{"					{	return symbol(sym.LEFTCURLYBRACKET);}
"}"					{	return symbol(sym.RIGHTCURLYBRACKET);}
"is"				{	return symbol(sym.IS);}
"def"				{	return symbol(sym.DEF);}
"lambda"			{	return symbol(sym.LAMBDA);}
"return"			{	return symbol(sym.RETURN);}
"class"				{	return symbol(sym.CLASS);}

{float}				{	return symbol(sym.FLOAT, yytext());}
{integer}			{	return symbol(sym.INTEGER, yytext());}
{identifier}		{	return symbol(sym.IDENTIFIER, yytext().toUpperCase());}
"."					{	return symbol(sym.FULLSTOP);}

{WhiteSpace}		{	/*Ignore whitespaces*/}

{LineTerminator}	{	yybegin(indent_state);
						current_indent = 0;
						return symbol(sym.NEWLINE);
					}
}



<indent_state>{
" "			   		{	current_indent++; }
"\t"			   	{	current_indent = current_indent + TAB_LENGTH; }
"\f"				{	/*Ignore whitespace*/}
.					{	yypushback(1);
						if(current_indent > stack.peek()){
							stack.push(current_indent);
							yybegin(normal_state);
							return symbol(sym.INDENT);
						}
						else if(current_indent == stack.peek()){
							yybegin(normal_state);
						}
						else{
							int tmp = stack.pop();
							return symbol(sym.DEDENT);
						}
					}
{LineTerminator}	{if(current_indent > stack.peek()){
							stack.push(current_indent);
							yybegin(normal_state);
							return symbol(sym.INDENT);
						}
						else if(current_indent == stack.peek()){
							yybegin(normal_state);
						}
						else{
							yypushback(1);
							int tmp = stack.pop();
							return symbol(sym.DEDENT);
						}
					}
}


{comment}			{	/* ignore comments*/}
.           		{System.out.println("Illegal char, '" + yytext() + "' line: " + yyline + ", column: " + yychar);}