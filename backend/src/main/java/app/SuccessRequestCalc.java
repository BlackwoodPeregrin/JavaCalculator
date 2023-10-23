package app;

public class SuccessRequestCalc implements ResultRequest {
    public SuccessRequestCalc(String resultCalc) {
        this.resultCalc = resultCalc;
    }

    private final String resultCalc;
}
