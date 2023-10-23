package app;

import java.util.List;

public class SuccessRequestHistoryCalc implements ResultRequest {
    public SuccessRequestHistoryCalc(List<HistoryCalculation> history) {
        this.history = history;
    }

    private final List<HistoryCalculation> history;
}
