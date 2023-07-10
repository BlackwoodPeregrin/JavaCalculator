import java.util.ArrayDeque;

public class ExpressionListener extends InputExpressionBaseListener {
    private final PolishNotationBuilder builder = new PolishNotationBuilder();

    public ArrayDeque<OwnerToken> getPolishNotation() {
        return builder.getPolishNotation();
    }

    @Override
    public void exitOperator(InputExpressionParser.OperatorContext ctx) {
        if (ctx.Plus() != null) {
            builder.addOperator(Operator.PLUS);
        } else if (ctx.Minus() != null) {
            builder.addOperator(Operator.MINUS);
        } else if (ctx.Mult() != null) {
            builder.addOperator(Operator.MULT);
        } else if (ctx.Div() != null) {
            builder.addOperator(Operator.DIV);
        } else if (ctx.Mod() != null) {
            builder.addOperator(Operator.MOD);
        } else {
            builder.addOperator(Operator.POW);
        }
    }

    @Override public void exitLBrecket(InputExpressionParser.LBrecketContext ctx) {
        builder.addOperator(Operator.LEFT_BRACKET);
    }

    @Override public void exitRBrecket(InputExpressionParser.RBrecketContext ctx) {
        builder.addOperator(Operator.RIGHT_BRACKET);
    }

    @Override
    public void exitUnaryOperator(InputExpressionParser.UnaryOperatorContext ctx) {
        builder.addOperator(ctx.Plus() != null ? Operator.UNARY_PLUS : Operator.UNARY_MINUS);
    }

    @Override
    public void exitNumber(InputExpressionParser.NumberContext ctx) {
        var number = ctx.Number().getText();
        builder.addNumber(Double.parseDouble(number));
    }

    @Override
    public void exitFun(InputExpressionParser.FunContext ctx) {
        if (ctx.Sin() != null) {
            builder.addFunc(Func.SIN);
        } else if (ctx.Cos() != null) {
            builder.addFunc(Func.COS);
        } else if (ctx.Tan() != null) {
            builder.addFunc(Func.TAN);
        } else if (ctx.Asin() != null) {
            builder.addFunc(Func.ASIN);
        } else if (ctx.Acos() != null) {
            builder.addFunc(Func.ACOS);
        } else if (ctx.Atan() != null) {
            builder.addFunc(Func.ATAN);
        } else if (ctx.Sqrt() != null) {
            builder.addFunc(Func.SQRT);
        } else if (ctx.Ln() != null) {
            builder.addFunc(Func.LN);
        } else {
            builder.addFunc(Func.LOG);
        }
    }
}