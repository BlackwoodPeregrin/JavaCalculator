package token;

public class TokenFunc implements OwnerToken {
    private final Func fun;

    public TokenFunc(Func fun) { this.fun = fun; }

    @Override public TokenType type() {
        return TokenType.FUNC;
    }

    @Override public Func value() {
        return fun;
    }
}
