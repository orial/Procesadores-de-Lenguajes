public class BloqueCondicion {
    public String labCierto;
    public String labFalso;
	public static int label=0;
	
	public BloqueCondicion(){
	    labCierto = "";
	    labFalso = "";
	}
	public static String nuevaEtq() {
		String var = "L"+label;
		label++;
		return var; 
	}
	
	public static BloqueCondicion generarCondicion(String e1, String op, String e2){
		BloqueCondicion etiq = new BloqueCondicion();
		etiq.labCierto = nuevaEtq();
		etiq.labFalso = nuevaEtq();
		PyPL.out.println("\tif ("+ e1 +" "+op +" "+ e2 +") goto "+ etiq.labCierto +";");
		PyPL.out.println("\tgoto "+ etiq.labFalso +";"); 
		return etiq;
	}
	
	public static BloqueCondicion generarCondicionCompuesta(String e1, String e2){
    	BloqueCondicion etiq1 = new BloqueCondicion();
    	BloqueCondicion etiq2 = new BloqueCondicion();
	    etiq1.labCierto = nuevaEtq();
		etiq2.labCierto = nuevaEtq();
		etiq2.labFalso = nuevaEtq();
		
		String op = "<";
		PyPL.out.println("\tif ("+ e1 +" "+op +" "+ e2 +") goto "+ etiq2.labCierto +";");
  
	    op="==";
	    PyPL.out.println("\tif ("+ e1 +" "+op +" "+ e2 +") goto "+ etiq2.labCierto +";");
		PyPL.out.println("\tgoto "+ etiq2.labFalso +";"); 
		
		BloqueCondicion etiqRes = new BloqueCondicion();

    	return etiq2;
	}
}













