public class Tag{

    public static final int MAY = 1;
    public static final int MEN = 2;
    public static final int IG = 3;
    public static final int MENIG = 4;
    public static final int MAYIG = 5;
    public static final int NIG = 6;

    private String v;
    private String f;

    public Tag(String v, String f) {
        this.v = v;
        this.f = f;
    }

    public String getV() {
        return this.v;
    }

    public String getF() {
        return this.f;
    }

    public void setV(String v) {
        this.v = v;
    }

    public void setF(String f) {
        this.f = f;
    }
}
