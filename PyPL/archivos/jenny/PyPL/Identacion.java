import java.util.Stack;
public class Identacion {
	public static int identacion = 0;
	public static int contador = 0;
	public static Stack<Integer> pila = new Stack<Integer>();
	public static boolean flag = false;

	public static int identacionEsp (int tam) {
		int identaciones = tam/4;
		if (identacion < identaciones) {
			identacion = identaciones;
			return 1;
		} else if (identacion > identaciones){
			return -1;
		} else {
			return 0;
		}
	}
	public static int identacionTab (int tam) {
		int identaciones = tam;
		if (identacion < identaciones) {
			identacion = identaciones;
			return 1;
		} else if (identacion > identaciones){
			return -1;
		} else {
			return 0;
		}
	}
	public static int subIdentacionEsp(int tam) {
		int identaciones = tam/4;
		if (identacion > identaciones) {
			identacion--;
			return 1;
		} else if (identacion < identaciones){
			System.out.println("ERROR");
			System.exit(0);
			return -2;
		} else {
			return 0;
		}
	}

	public static int subIdentacionTab (int tam) {
		int identaciones = tam;
		if (identacion > identaciones) {
			identacion--;
			return 1;
		} else if (identacion < identaciones){
			System.out.println("ERROR");
			System.exit(0);
			return -2;
		} else {
			return 0;
		}
	}

	public static int subIdentacionCero () {
		if (identacion > 0) {
			identacion--;
			return 1;
		} else if (identacion < 0){
			System.out.println("ERROR");
			System.exit(0);
			return -2;
		} else {
			return 0;
		}
	}

}
