
import java.util.*;

public class TSimb {

    private static Map<String, List<Integer>> variables = new HashMap<String, List<Integer>>(); // Mapa de variables y sus ambitos
    private static int scope = 0;

    public static void addVar(String name, Integer actualScope) {
        if (exists(name)) {
            variables.get(name).add(actualScope); // si ya existe añado nuevo ambito al identificador
        } else { // sino creo una lista de ambitos para ese identificador , le añado el ambito actual actual y el identificador al mapa
            ArrayList<Integer> scopes = new ArrayList<Integer>();
            scopes.add(actualScope);
            variables.put(name, scopes);
        }
    }

    public static void upLevel() { // mayor nivel interno del ambito (de afuera para dentro) (menor a mayor)
        scope++;
    }

    public static String getVar(String name) {
        int n = variables.get(name).size();
        if (n > 1) {
            return name + "_" + variables.get(name).get(n - 1); // x_0
        } else {
            return name; // x
        }
    }

    public static void downLevel() { // subir el ambito
        if (scope > 0) {
            scope--;
        }
    }

    public static int getLevel() {
        return scope;
    }

    public static void clear(Integer level) { // elimina las variables de un ambito dado

        for (Iterator<Map.Entry<String, List<Integer>>> it = variables.entrySet().iterator(); it.hasNext();) {

            Map.Entry<String, List<Integer>> entry = it.next();
            List<Integer> levels = entry.getValue();

            int ult = levels.get(levels.size() - 1);

            if (ult == level) {
                entry.getValue().remove(levels.indexOf(ult));

                if (entry.getValue().isEmpty()) {
                    it.remove();
                }

            }

        }
    }

    public static boolean exists(String name) {
        return variables.containsKey(name);
    }

}
