import java.util.LinkedList;

public class AuxPyPL{

public static LinkedList<Instruccion> listaExpr = new LinkedList<Instruccion>();

   public static class Instruccion{
        public String expr;
        public int nivel;
        
        public Instruccion(String e, int n){
            expr = e;
            nivel = n;
        }
    }

    public static void nuevaInstruccion(String expr, int tab, int nivelActual){
	    if (tab == nivelActual){
            PyPL.out.println(expr);
	    }else if(tab < nivelActual){
	        listaExpr.add(new Instruccion(expr, tab));
	    }else{
	        PyPL.out.println(expr+";"+tab+";");
	        error();
	    }
    }
    
    public static void borrarNivel(int niv){
        for (Instruccion i: listaExpr){
            if(i.nivel >= niv){
                listaExpr.remove(i);
            }
        }
    }
    
    public static void printNivel(int niv){
        for (Instruccion i: listaExpr){
            if(i.nivel == niv){
                PyPL.out.println(i.expr);
            }
        }
    }
    
	public static void error(){
	    PyPL.out.println("\terror;\n\thalt;");
	}

    public static void printlista(){
        for (Instruccion i: listaExpr){
            PyPL.out.println(i.expr+"    nivel:"+i.nivel);
        }
    }
}
