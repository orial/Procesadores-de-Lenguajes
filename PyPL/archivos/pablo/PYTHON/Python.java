
import java.util.LinkedList;
import java.util.List;


public class Python {
    public static List<Lista> l = new LinkedList<Lista>();
    private boolean levelDown = false;

    public static void check(String s, int nivel, int current){
        if(current > nivel){
            PLC.out.println("    error");
            PLC.out.println("    halt");
        }
        if(current == nivel){
            PLC.out.println(s);
        }
        if(current < nivel){
            l.add(new Lista(s,current));
        }
        
    }
    
	public static void deleteLevel(int x){
        for(Lista o : l)  { 
            if(o.level == x){
              l.remove(o);
             }
      	 }     
	}

    public static void printLevel(int x){
        for(Lista o : l)  { 
            if(o.level == x){
              PLC.out.println(o.s); 
             }
       }   
    }
}

