import java_cup.runtime.*;

%%
%xstate IDENTACION
%xstate CERRARLLAVE

%cup

LineTerminator = \r|\n|\r\n
InputCharacter = [^\r\n]
WhiteSpace = {LineTerminator} | [ \t\f]
Caracter = [^\r\n ]

/* comments */
Comment = {TraditionalComment} | {DocumentationComment}
ComentarioPython = {ComentarioPythonFinLinea} | {ComentarioPythonLineas}

TraditionalComment = "/*" [^*] ~"*/" | "/*" "*"+ "/"
// Comment can be the last line of the file, without line terminator.
DocumentationComment = "/**" {CommentContent} "*"+ "/"
CommentContent = ( [^*] | \*+ [^/*] )*
ComentarioPythonFinLinea = "#" {InputCharacter}* {LineTerminator}?
ComentarioPythonLineas = "'''" [^'] ~"'''" | "'''" "'"+ "''"

/* float */        
numeroFloat = ({floatTipo1}|{floatTipo2}|{floatTipo3}) {exponente}?

floatTipo1    = [0-9]+ \. [0-9]* 
floatTipo2    = \. [0-9]+ 
floatTipo3    = [0-9]+ 	
			// Para que este tipo se considere float, 
			// debe tener exponente, por ello la regla 
			// que devuelva este tipo de float debe 
			// estar por debajo de int
exponente = [eE] [+-]? [0-9]+

castingFloat = "("{WhiteSpace}*"float"{WhiteSpace}*")"{WhiteSpace}*
entero = 0|[1-9][0-9]*

%%

/* Expresiones y reglas */

	\n/{Caracter}			{ yypushback(1); yybegin(CERRARLLAVE);}
	
	\n/([\t\f] | (\ \ \ \ ))+	{ yybegin(IDENTACION);}		

<IDENTACION>		{
				[\t\f]+ 	{ int aumentar = Identacion.identacionTab(yylength());
						  if (aumentar==1){
							yybegin(YYINITIAL);
							Identacion.flag = true;
							return new Symbol(sym.AL);
						  } else if (aumentar==-1) {
							yypushback(yylength());
							yybegin(CERRARLLAVE);
						  } else {
							yybegin(YYINITIAL);
						  }
						}	
				(\ \ \ \ )+	{ int aumentar = Identacion.identacionEsp(yylength());
						  if (aumentar==1){
							yybegin(YYINITIAL);
							Identacion.flag = true;
							return new Symbol(sym.AL);
						  } else if (aumentar==-1) {
							yypushback(yylength());
							yybegin(CERRARLLAVE);
						  } else {
							yybegin(YYINITIAL);
						  }
						}	
			}
<CERRARLLAVE>		{
				[\t\f]+ 	{  int seguir = Identacion.subIdentacionTab(yylength());
						  if (seguir==1){
							yypushback(yylength());
							Identacion.flag = false;
							return new Symbol(sym.CL);
						  } else {
							yybegin(YYINITIAL);
						  } 
						}	
				(\ \ \ \ )+	{  int seguir = Identacion.subIdentacionEsp(yylength());
						  if (seguir==1){
							yypushback(yylength());
							Identacion.flag = false;
							return new Symbol(sym.CL);
						  } else {
							yybegin(YYINITIAL);
						  }
						}
				\n		{ int seguir = Identacion.subIdentacionCero();
							if (seguir == 1) {
								yypushback(yylength());
								Identacion.flag = false;
								return new Symbol(sym.CL);						
							} else {
								yybegin(YYINITIAL);
							}
						}
			}				
		
	{castingFloat}/{entero} {return new Symbol(sym.CASTINGFLOATAENTERO);}
	{castingFloat}/"(" {return new Symbol(sym.CASTINGFLOATAEXPRESION);}
	"print"		{ return new Symbol(sym.PRINT); }
	"int"		{ return new Symbol(sym.INT); }
	"float"		{ return new Symbol(sym.FLOAT); }
	"elif"		{ return new Symbol(sym.ELIF);				}
	"if"		{ return new Symbol(sym.IF);				}
	"else"		{ return new Symbol(sym.ELSE);				}
	"do"		{ return new Symbol(sym.DO);				}
	"in"		{ return new Symbol(sym.IN, new BloqueCond());		}
	"for"		{ return new Symbol(sym.FOR, new EtiquetaFor());	}
	"while"		{ return new Symbol(sym.WHILE);				}
	"range"		{ return new Symbol(sym.RANGE);				}
											

	"("			{ return new Symbol(sym.AP); }
	")"			{ return new Symbol(sym.CP); }
	"["			{ return new Symbol(sym.AC); }
	"]"			{ return new Symbol(sym.CC); }
	"{"			{ return new Symbol(sym.AL); }
	"}"			{ return new Symbol(sym.CL); }
	";"			{ return new Symbol(sym.PYC); }
	","			{ return new Symbol(sym.COMA); }
	":"			{ return new Symbol(sym.DP); }

	"**"			{ return new Symbol(sym.EXP); }											
	"++"			{ return new Symbol(sym.MASMAS); }
	"="			{ return new Symbol(sym.ASIG); }
	">"			{ return new Symbol(sym.MAYOR);  }
	"<"			{ return new Symbol(sym.MENOR); }
	"!"			{ return new Symbol(sym.NOT); }
	"=="		{ return new Symbol(sym.IGUAL); }
	"<="		{ return new Symbol(sym.MENORIGUAL); }
	">="		{ return new Symbol(sym.MAYORIGUAL); }
	"!="		{ return new Symbol(sym.DIF); }
	"&&"		{ return new Symbol(sym.AND); }
	"||"		{ return new Symbol(sym.OR); }
	"+"			{ return new Symbol(sym.MAS); }
	"-"			{ return new Symbol(sym.MENOS); }
	"*"			{ return new Symbol(sym.POR); }
	"//"			{ return new Symbol(sym.DIVINT); }
	"/"			{ return new Symbol(sym.DIV); }
	"%"			{ return new Symbol(sym.MOD); }
											

{entero}	{ return new Symbol(sym.ENTERO, yytext()); }

											

{numeroFloat}	{ return new Symbol(sym.REAL, yytext()); }

											

{Comment}		{ }

{ComentarioPython} {}											

{WhiteSpace}	{ }

											

[_a-zA-Z][_a-zA-Z0-9]*	{ return new Symbol(sym.IDENT, yytext()); }

											

[^]			{ throw new Error("Illegal character <"+yytext()+">"); }


