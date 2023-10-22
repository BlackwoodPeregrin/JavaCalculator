package app;

public class RequestResult {
    public RequestResult(Boolean valid, String value) {
        this.valid = valid;
        this.value = value;
    }

    private Boolean valid;
    private String value;
}
