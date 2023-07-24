package token;

public class TokenBracketOperator implements OwnerToken {

    private final BracketOperator value;

    public TokenBracketOperator(BracketOperator value) { this.value = value; }

    @Override
    public TokenType type() {
        return TokenType.BRACKET_OPERATOR;
    }

    @Override
    public BracketOperator value() {
        return value;
    }
}
