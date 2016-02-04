import java.io.PrintStream;

public class Generador { // hecho con patron Singleton

    private static Generador instance;
    // salida to print (can be System.out or a file)
    private static PrintStream out = PLC.out;   
    private static int contLabel = 0;           // contador para las etiquetas
    private static int contVarTemp = 0;         // contador para las variables temporales

    public Generador() { }

    public static synchronized Generador getInstance() {
        if (instance == null)
            instance = new Generador();
        return instance;
    }

    public PrintStream out() {
        return out;
    }

    public String newLabel() { 
        return "L" + contLabel++; 
    }

    public String newVarTemp() { 
        return "t" + contVarTemp++; 
    }
}
