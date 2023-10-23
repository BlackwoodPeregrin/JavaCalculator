package processor;

import org.jetbrains.annotations.NotNull;
import token.*;
import java.util.ArrayDeque;

public class PolishNotationProcessor {
    public static Double process(@NotNull ArrayDeque<OwnerToken> polishNotation) {
        ArrayDeque<TokenNumber> temp = new ArrayDeque<>();

        while (!polishNotation.isEmpty()) {
            var token = polishNotation.removeFirst();

            if (token instanceof TokenNumber) {
                temp.addFirst((TokenNumber) token);
            } else if (token instanceof TokenFunc) {
                processTokenFunc(((TokenFunc) token).value(), temp);
            } else if (token instanceof TokenOperator) {
                processTokenOperator(((TokenOperator) token).value(), temp);
            } else if (token instanceof TokenUnaryOperator) {
                if (token.value() == UnaryOperator.MINUS) {
                    if (temp.peekFirst() == null) {
                        throw new RuntimeException("Error In process, find unary sign but temp deque is empty");
                    }
                    temp.addFirst(new TokenNumber(temp.removeFirst().value() * -1));
                }
            } else {
                throw new RuntimeException("Error In process, instance of token is " + token.getClass());
            }
        }

        if (temp.size() != 1) {
            throw new RuntimeException("Error In process, final temp deque size not equal 1");
        }

        return temp.removeFirst().value();
    }

    private static void processTokenFunc(Func fun, ArrayDeque<TokenNumber> temp) {
        if (temp.size() < 1) {
            throw new RuntimeException("Error In process TokenFunc, temp deque is empty");
        }

        Double value = temp.removeFirst().value();

        temp.addFirst(
            calculateFunc(fun, value)
        );
    }

    private static void processTokenOperator(Operator operator, ArrayDeque<TokenNumber> temp) {
        if (temp.size() < 2) {
            throw new RuntimeException("Error In process TokenOperator, deque size less then 2");
        }
        var num2 = temp.removeFirst().value();
        var num1 = temp.removeFirst().value();

        temp.addFirst(
            calculateOperator(operator, num1, num2)
        );
    }

    private static TokenNumber calculateFunc(
        Func fun,
        Double num
    ) {
        double value = 0.0;
        switch (fun) {
            case SIN -> value = Math.sin(num);
            case COS -> value = Math.cos(num);
            case TAN -> value = Math.tan(num);
            case ASIN -> {
                if (num < -1 || num > 1) {
                    throw new RuntimeException("Error. Argument function asin must be in diapason [-1;1]");
                }
                value = Math.asin(num);
            }
            case ACOS -> {
                if (num < -1 || num > 1) {
                    throw new RuntimeException("Error. Argument function acos must be in diapason [-1;1]");
                }
                value = Math.acos(num);
            }
            case ATAN -> value = Math.atan(num);
            case SQRT -> {
                if (num <= 0) {
                    throw new RuntimeException("Error. Argument function sqrt must be positive");
                }
                value = Math.sqrt(num);
            }
            case LN -> {
                if (num <= 0) {
                    throw new RuntimeException("Error. Argument function ln must be positive");
                }
                value = Math.log10(num);
            }
            case LOG -> {
                if (num <= 0) {
                    throw new RuntimeException("Error. Argument function log must be positive");
                }
                value = Math.log(num);
            }
            case Exp -> {
                value = Math.exp(num);
            }
        };
        return new TokenNumber(value);
    }

    private static TokenNumber calculateOperator(
            Operator operator,
            Double num1,
            Double num2
    ) {
        double valueResult = 0.0;

        switch (operator) {
            case PLUS -> valueResult = num1 + num2;
            case MINUS -> valueResult = num1 - num2;
            case MUL -> valueResult = num1 * num2;
            case DIV -> {
                if (num2 == 0) {
                    throw new RuntimeException("Error, Division by Zero");
                }
                valueResult = num1 / num2;
            }
            case MOD -> valueResult = num1 % num2;
            case POW -> valueResult = Math.pow(num1, num2);
        };
        return new TokenNumber(valueResult);
    }
}
