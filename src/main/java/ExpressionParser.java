import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;

import java.util.ArrayDeque;

public class ExpressionParser {

    public ArrayDeque<OwnerToken> parse(String inputExpression) throws RuntimeException {
        AntlrErrorListener errorListener = new AntlrErrorListener();
        ExpressionListener listener = new ExpressionListener();

        InputExpressionLexer lexer = new InputExpressionLexer(new ANTLRInputStream(inputExpression));
        lexer.removeErrorListeners();
        lexer.addErrorListener(errorListener);

        InputExpressionParser parser = new InputExpressionParser(new CommonTokenStream(lexer));
        parser.removeErrorListeners();
        parser.addErrorListener(errorListener);
        parser.addParseListener(listener);

        parser.expression();

        return listener.getPolishNotation();
    }
}
