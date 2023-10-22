package parser;

import listener.AntlrErrorListener;
import listener.ExpressionListener;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

import antrl.gen.InputExpressionLexer;
import antrl.gen.InputExpressionParser;

import org.springframework.stereotype.Service;
import token.OwnerToken;


import java.util.ArrayDeque;

@Service
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
