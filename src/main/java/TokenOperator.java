public class TokenOperator implements OwnerToken {
    private final Object obj;

    public TokenOperator(Operator number) { obj = number; }

    @Override public TokenType type() {
        return TokenType.OPERATOR;
    }

    @Override public Object value() { return obj; }
}
