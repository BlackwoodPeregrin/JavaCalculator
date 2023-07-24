package token;

public class TokenOperator implements OwnerToken {
    private final Operator operator;

    public TokenOperator(Operator operator) { this.operator = operator; }

    @Override public TokenType type() {
        return TokenType.OPERATOR;
    }

    @Override public Operator value() { return operator; }
}
