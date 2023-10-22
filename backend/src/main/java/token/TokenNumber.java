package token;

public class TokenNumber implements OwnerToken {
    private final Double number;

    public TokenNumber(Double number) { this.number = number; }

    @Override public TokenType type() {
        return TokenType.NUMBER;
    }

    @Override public Double value() { return number; }
}
