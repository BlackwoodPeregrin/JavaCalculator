package listener;

import java.util.ArrayDeque;

import antrl.gen.InputExpressionBaseListener;
import antrl.gen.InputExpressionParser;

import token.*;

public class ExpressionListener extends InputExpressionBaseListener {

    private class PolishNotationBuildHelper {
        final ArrayDeque<OwnerToken> input = new ArrayDeque<>();
        final ArrayDeque<OwnerToken> output = new ArrayDeque<>();

        public void addUnaryOperator(UnaryOperator operator) {
            final var token = input.peekLast();
            if (token != null && token.type() == TokenType.UNARY_OPERATOR) {
                output.addLast(token);
            } else {
                input.addLast(new TokenUnaryOperator(operator));
            }
        }

        public void addBracketOperator(BracketOperator operator) {
            switch (operator) {
                case LEFT -> {
                    input.addLast(new TokenBracketOperator(operator));
                }
                case RIGHT -> {
                    while (true) {
                        if (input.isEmpty()) {
                            throw new RuntimeException("Error in PolishNotationBuilder, not find left bracket");
                        }
                        var token = input.removeLast();
                        if (token.value() == BracketOperator.LEFT) {
                            if (input.peekLast() != null && input.peekLast().type() == TokenType.FUNC) {
                                output.addLast(input.removeLast());
                            }
                            break;
                        }
                        output.addLast(token);
                    }
                }
            }
        }

        public void addOperator(Operator operator) {
            var token = input.peekLast();
            while (token != null && token.type() != TokenType.BRACKET_OPERATOR) {
                if (token.type() == TokenType.OPERATOR
                        && Operator.priority(operator) > Operator.priority((Operator) token.value())) {
                    break;
                }
                output.addLast(input.removeLast());
                token = input.peekLast();
            }
            input.addLast(new TokenOperator(operator));
        }

        public void addNumber(Double number) {
            output.addLast(new TokenNumber(number));
        }

        public void addFunc(Func fun) {
            input.addLast(new TokenFunc(fun));
        }
    }

    private final PolishNotationBuildHelper buildHelper = new PolishNotationBuildHelper();

    public ArrayDeque<OwnerToken> getPolishNotation() {
        while (!buildHelper.input.isEmpty()) {
            buildHelper.output.addLast(buildHelper.input.removeLast());
        }
        return buildHelper.output;
    }

    @Override public void exitOperator(InputExpressionParser.OperatorContext ctx) {
        if (ctx.Plus() != null) {
            buildHelper.addOperator(Operator.PLUS);
        } else if (ctx.Minus() != null) {
            buildHelper.addOperator(Operator.MINUS);
        } else if (ctx.Mult() != null) {
            buildHelper.addOperator(Operator.MUL);
        } else if (ctx.Div() != null) {
            buildHelper.addOperator(Operator.DIV);
        } else if (ctx.Mod() != null) {
            buildHelper.addOperator(Operator.MOD);
        } else {
            buildHelper.addOperator(Operator.POW);
        }
    }

    @Override public void exitLBrecket(InputExpressionParser.LBrecketContext ctx) {
        buildHelper.addBracketOperator(BracketOperator.LEFT);
    }

    @Override public void exitRBrecket(InputExpressionParser.RBrecketContext ctx) {
        buildHelper.addBracketOperator(BracketOperator.RIGHT);
    }

    @Override public void exitUnaryOperator(InputExpressionParser.UnaryOperatorContext ctx) {
        buildHelper.addUnaryOperator(ctx.Plus() != null ? UnaryOperator.PLUS : UnaryOperator.MINUS);
    }

    @Override public void exitNumber(InputExpressionParser.NumberContext ctx) {
        var number = ctx.Number().getText();
        buildHelper.addNumber(Double.parseDouble(number));
    }

    @Override public void exitFun(InputExpressionParser.FunContext ctx) {
        if (ctx.Sin() != null) {
            buildHelper.addFunc(Func.SIN);
        } else if (ctx.Cos() != null) {
            buildHelper.addFunc(Func.COS);
        } else if (ctx.Tan() != null) {
            buildHelper.addFunc(Func.TAN);
        } else if (ctx.Asin() != null) {
            buildHelper.addFunc(Func.ASIN);
        } else if (ctx.Acos() != null) {
            buildHelper.addFunc(Func.ACOS);
        } else if (ctx.Atan() != null) {
            buildHelper.addFunc(Func.ATAN);
        } else if (ctx.Sqrt() != null) {
            buildHelper.addFunc(Func.SQRT);
        } else if (ctx.Ln() != null) {
            buildHelper.addFunc(Func.LN);
        } else {
            buildHelper.addFunc(Func.LOG);
        }
    }
}
