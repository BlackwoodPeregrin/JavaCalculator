import org.jetbrains.annotations.NotNull;

public enum Operator {
    PLUS,
    MINUS,
    MULT,
    DIV,
    MOD,
    POW,
    UNARY_PLUS,
    UNARY_MINUS,
    LEFT_BRACKET,
    RIGHT_BRACKET;

    static public int priority(@NotNull Operator operator) {
        return switch (operator) {
            case PLUS, MINUS  -> 0;
            case MULT, MOD, DIV -> 1;
            case POW -> 2;
            case UNARY_PLUS, UNARY_MINUS -> 3;
            case LEFT_BRACKET, RIGHT_BRACKET -> -1;
        };
    }
}
