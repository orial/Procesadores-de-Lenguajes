public class Etiqueta{

public static int contador = 0;



public static String call(){
String var = "L"+contador;
contador++;
return var;
}


public static Label generar(String c1, String c2, String op) {
Label aux = new Label();
aux.setEv(call());
aux.setEf(call());
if(op.equals(">=")){
PLC.out.println("   if("+c2+" < "+c1+") goto "+aux.getEv()+";");
PLC.out.println("   if("+c1+" == "+c2+") goto "+aux.getEv()+";");
}
else if(op.equals("<=")){
PLC.out.println("   if("+c1+" < "+c2+") goto "+aux.getEv()+";");
PLC.out.println("   if("+c1+" == "+c2+") goto "+aux.getEv()+";");
}
else if(!op.equals("!=")){
PLC.out.println("   if("+c1+" "+op+" "+c2+") goto "+aux.getEv()+";");
}
if(!op.equals("!=")){
PLC.out.println("   goto "+aux.getEf()+";");
}
else{
PLC.out.println("   if("+c1+"=="+c2+") goto "+aux.getEf()+";");
PLC.out.println("   goto "+aux.getEv()+";");
}
return aux;
}

}
