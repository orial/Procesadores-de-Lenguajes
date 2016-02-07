import java.io.PrintStream;

public class Generador {

    private static int varTemp = 0;
    private static int tagCont = 0;
    protected static PrintStream out = System.out;

	// Crea las variables temporales
	public static String getTag(){
		return "L" + tagCont++;
	}

    public static String getTemp(){
		return "$t" + varTemp++;
	}

	/**
	 * OPERACIONES ARITMETICAS
	 */

	public static String aritmetica(String op){
		String tmp = getTemp();
		out.println("   " + tmp + " = " + op + ";");
		return tmp;
	}

	/**
	 * CONDICIONES
	 */

	public static Tag condicion(String arg1, int cond, String arg2){
		String tagV = getTag();
		String tagF = getTag();

		switch(cond){
			case Tag.MAY:
				out.println("	if (" + arg2 + " < " + arg1 + ") goto " + tagV + ";");
				out.println("	goto " + tagF + ";");
				break;
			case Tag.MEN:
				out.println("   if (" + arg1 + " < " + arg2 + ") goto " + tagV + ";");
                out.println("   goto " + tagF + ";");
                break;
			case Tag.IG:
				out.println("   if (" + arg1 + " == " + arg2 + ") goto " + tagV + ";");
                out.println("   goto " + tagF + ";");
                break;
			case Tag.MENIG:
				out.println("   if (" + arg2 + " < " + arg1 + ") goto " + tagF + ";");
                out.println("   goto " + tagV + ";");
                break;
			case Tag.MAYIG:
				out.println("   if (" + arg1 + " < " + arg2 + ") goto " + tagF + ";");
                out.println("   goto " + tagV + ";");
                break;
			case Tag.NIG:
				out.println("   if (" + arg1 + " == " + arg2 + ") goto " + tagF + ";");
                out.println("   goto " + tagV + ";");
                break;
		}
		return new Tag(tagV, tagF);
	}

	/**
	 * INSTRUCCIONES DISPONIBLES
	 */

	// left = right;
	public static String asignacion(String ident, String exp){
		out.println("   " + ident + " = " + exp + ";");
		return ident;
	}

	// goto label;
	public static void goTo(String tag){
		out.println("   goto " + tag + ";");
	}

	// label:
	public static void label(String tag){
		out.println(tag + ":");
	}

	// print e;
	public static void print(String exp){
		out.println("   print " + exp + ";");
	}

	// halt;
	public static void halt(){
		out.println("   halt;");
	}
        
        // error
    public static void error(){
		out.println("	error;");
	}
}
