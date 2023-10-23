package app;

public class FailedRequest implements ResultRequest {
    public FailedRequest(String errorMessage) {
        this.errorMsg = errorMessage;
    }

    private final String errorMsg;
}
