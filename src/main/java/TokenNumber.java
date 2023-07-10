public class TokenNumber implements OwnerToken {
    private final Object obj;

    public TokenNumber(double number) { obj = number; }

    @Override public TokenType type() {
        return TokenType.NUMBER;
    }

    @Override public Object value() {
        return obj;
    }
}
