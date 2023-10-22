package token;

import org.jetbrains.annotations.NotNull;

public enum Operator {
    PLUS,
    MINUS,
    MUL,
    DIV,
    MOD,
    POW;

    static public int priority(@NotNull Operator operator) {
        return switch (operator) {
            case PLUS, MINUS  -> 1;
            case MUL, MOD, DIV -> 2;
            case POW -> 3;
        };
    }
}
