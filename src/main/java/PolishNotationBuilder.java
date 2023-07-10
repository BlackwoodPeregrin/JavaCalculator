import java.util.ArrayDeque;

public class PolishNotationBuilder {
    private final ArrayDeque<OwnerToken> input = new ArrayDeque<>();
    private final ArrayDeque<OwnerToken> output = new ArrayDeque<>();

    public ArrayDeque<OwnerToken> getPolishNotation() {
        while (!input.isEmpty()) {
            output.addLast(input.removeLast());
        }
        return output;
    }

    public void addOperator(Operator operator) {
        if (operator == Operator.LEFT_BRACKET) {
            addOperatorLeftBracket();
            return;
        }

        if (operator == Operator.RIGHT_BRACKET) {
            addOperatorRightBracket();
            return;
        }

        var token = input.peekLast();

        if (token == null) {
            input.addLast(new TokenOperator(operator));
            return;
        }

        while (token != null
                && token.type() == TokenType.OPERATOR
                && Operator.priority(operator) <= Operator.priority((Operator)token.value())) {
            output.addLast(token);
            input.removeLast();
            token = input.peekLast();
        }

        input.addLast(new TokenOperator(operator));
    }

    public void addNumber(double number) {
        output.addLast(new TokenNumber(number));
    }

    public void addFunc(Func fun) {
        input.addLast(new TokenFunc(fun));
    }

    private void addOperatorLeftBracket() {
        input.addLast(new TokenOperator(Operator.LEFT_BRACKET));
    }

    private void addOperatorRightBracket() {
        while (true) {
            var token = input.removeLast();
            if (token.value() == Operator.LEFT_BRACKET) {
                var isFun = input.peekLast();
                if (isFun != null && isFun.type() == TokenType.FUNC) {
                    output.addLast(input.removeLast());
                }
                break;
            }
            output.addLast(token);
        }
    }
}
