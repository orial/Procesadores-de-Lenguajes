public class Util {

	public static BloqueCond generarCondicion(String r1, String cond, String r2){
		BloqueCond etqs = new BloqueCond();
		etqs.etqV = generarEtiq();
		etqs.etqF = generarEtiq();
		if(cond.equals(">")){
			PYPLC.out.println("   if (" + r2 + " < " +  r1 + ") goto " + etqs.etqV + ";\n   goto " + etqs.etqF + ";");
		}else{
			PYPLC.out.println("   if (" + r1 + " " +  cond + " " +  r2 + ") goto " + etqs.etqV + ";\n   goto " + etqs.etqF + ";");	
		}
		return etqs;
	}

	public static BloqueCond generarCondicion2(String r1, String cond, String r2){
		BloqueCond etqs = new BloqueCond();
		etqs.etqV = generarEtiq();
		etqs.etqF = generarEtiq();
		if(cond.equals("<=")){
			PYPLC.out.println("   if (" + r2 + " < " +  r1 + ") goto " + etqs.etqF + ";\n   goto " + etqs.etqV + ";");
		} else if (cond.equals(">=")){
			PYPLC.out.println("   if (" + r1 + " < " +  r2 + ") goto " + etqs.etqF + ";\n   goto " + etqs.etqV + ";");
		} else if (cond.equals("!=")){
			PYPLC.out.println("   if (" + r1 + " == " +  r2 + ") goto " + etqs.etqF + ";\n   goto " + etqs.etqV + ";");
		}
		return etqs;
	}

	private static Integer contEtiq = 0;
	public static String generarEtiq(){
		String res = "L" + contEtiq.toString();
		contEtiq++;
		return res;
	}

	private static Integer contTemp = 0;
	public static String nuevoTemporal() {
		String res = "$t" + contTemp.toString();
		contTemp++;
		return res;
	}

	public static String elevar (String e1, String e2) {
		String tmp = Util.nuevoTemporal();
		String tmp1 = Util.nuevoTemporal();
		String l0 = Util.generarEtiq();
		String l1 = Util.generarEtiq();
		String l2 = Util.generarEtiq();
		String l3 = Util.generarEtiq();
		PYPLC.out.println("   aux = 1;\n   i = 0;\n" + l0 + ":\n   if( i < " + e2 + " ) goto " + l1 + ";\n   goto " + l2 + ";\n" +
					l3 + ":\n   " + tmp + " = i + 1;\n   i = " + tmp + ";\n   goto " + l0 + ";\n" +
					l1 + ":\n   " + tmp1 + " = aux * " + e1 + ";\n   aux = " + tmp1 + ";\n   goto " + l3 + ";\n" + l2 + ":");
		return tmp1;
	}

	public static String modulo (String e1, String e2) {
		String tmp0 = Util.nuevoTemporal();
		String tmp1 = Util.nuevoTemporal();
		String tmp2 = Util.nuevoTemporal();
		PYPLC.out.println("   " + tmp0 + " = " + e1 + " / " + e2 + ";\n   " + tmp1 + " = " + tmp0 + " * " + e2 + ";\n   " + 
					tmp2 + " = " + e1 + " - " + tmp1 + ";");

		return tmp2;
	}





}
