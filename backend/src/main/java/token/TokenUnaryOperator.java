package token;

public class TokenUnaryOperator implements OwnerToken {
    private final UnaryOperator value;

    public TokenUnaryOperator(UnaryOperator value) { this.value = value; }

    @Override
    public TokenType type() { return TokenType.UNARY_OPERATOR; }

    @Override
    public UnaryOperator value() { return value; }
}
