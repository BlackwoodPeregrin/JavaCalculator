public class TokenFunc implements OwnerToken {
    private final Object obj;

    public TokenFunc(Func fun) { obj = fun; }

    @Override public TokenType type() {
        return TokenType.FUNC;
    }

    @Override public Object value() {
        return obj;
    }
}
