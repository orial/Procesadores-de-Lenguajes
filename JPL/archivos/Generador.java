
import java.io.PrintStream;
import java.util.regex.Pattern;

public class Generador {

    protected static PrintStream out = System.out;

    private static int tagCont = 0;

    public static String getTag() {
        return "L" + tagCont++;
    }

    public static void funcion(String f) {
        out.println(".method public static " + f + " (I)I");
    }

    public static void sipush(String valor) {
        TSimb.push(valor);
        out.println("	sipush " + valor);
    }

    public static void iload(String n) {
        int pos = new Integer(n);
        TSimb.push(TSimb.getVar(pos).getValor());
        out.println("	iload " + n);
    }

    public static void istore(String n) {
        int pos = new Integer(n);

        TSimb.modificar(pos, new Variable(TSimb.getNombre(pos), TSimb.pop(), 1));
        out.println("	istore " + n);
    }

    public static String iadd() {
        String x = TSimb.pop();
        String y = TSimb.pop();

        int res = new Integer(x) + new Integer(y);

        TSimb.push(Integer.toString(res));
        out.println("	iadd");

        return Integer.toString(res);
    }

    public static String isub() {
        String x = TSimb.pop();
        String y = TSimb.pop();

        int res = new Integer(x) - new Integer(y);

        TSimb.push(Integer.toString(res));
        out.println("	isub");
        return Integer.toString(res);
    }

    public static String imul() {
        String x = TSimb.pop();
        String y = TSimb.pop();

        int res = new Integer(x) * new Integer(y);

        TSimb.push(Integer.toString(res));
        out.println("	imul");
        return Integer.toString(res);
    }

    public static void idiv() {
        String x = TSimb.pop();
        String y = TSimb.pop();

        int res = new Integer(x) / new Integer(y);

        TSimb.push(Integer.toString(res));
        out.println("	idiv");
    }

    public static void pop() {
        TSimb.pop();
        out.println("	pop");
    }

    public static void dup() {
        TSimb.push(TSimb.peek());
        out.println("	dup");
    }

    public static void nop() {
        out.println("	nop");
    }

    public static void label(String label) {
        out.println(label + ":");
    }

    public static void goTo(String label) {
        out.println("	goto " + label);
    }

    public static void ifeq(String l) {
        out.println("	ifeq " + l);
    }

    public static void ifne(String l) {
        out.println("	ifne " + l);
    }

    public static Tag ifge() {
        Tag tag = new Tag(getTag(), getTag());
        TSimb.pop();
        out.println("	ifgt " + tag.getV());
        return tag;
    }

    public static Tag ifle() {
        Tag tag = new Tag(getTag(), getTag());
        TSimb.pop();
        out.println("	iflt " + tag.getV());
        return tag;
    }

    public static void invoke(String f) {
        out.println("	invokestatic JPL/" + f + "(I)I");
    }

    public static void ireturn() {
        out.println("	ireturn");
    }

    public static void limitStack() {
        out.println("	.limit stack " + TSimb.getStackTam());
    }

    public static void limitLocal() {
        out.println("	.limit locals " + TSimb.getVarTam());
    }

    public static void endMethod() {
        out.println(".end method\n");
    }

    public static boolean isInteger(String in) {

        Pattern p = Pattern.compile("[+-]?(0|[1-9][0-9]*)");

        return Pattern.matches(p.pattern(), in);
    }

    public static boolean isIdent(String in) {

        Pattern p = Pattern.compile("[_a-zA-Z][_a-zA-Z0-9]*");

        return Pattern.matches(p.pattern(), in);
    }
}
