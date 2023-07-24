import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

import token.OwnerToken;


import java.util.ArrayDeque;

public class ExpressionParser {
    public static ArrayDeque<OwnerToken> parse(String expression) throws RuntimeException {
        AntlrErrorListener errorListener = new AntlrErrorListener();

        InputExpressionLexer lexer = new InputExpressionLexer(CharStreams.fromString(expression));
        lexer.removeErrorListeners();
        lexer.addErrorListener(errorListener);

        InputExpressionParser parser = new InputExpressionParser(new CommonTokenStream(lexer));
        parser.removeErrorListeners();
        parser.addErrorListener(errorListener);

        ExpressionListener listener = new ExpressionListener();
        parser.addParseListener(listener);

        parser.expression();

        return listener.getPolishNotation();
    }
}
