import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;

public class PolishNotationProcessorTest {
    @Test
    public void start() {
        var expectedValue = Double.valueOf(3 - 5);
        Assertions.assertEquals(expectedValue, PolishNotationProcessor.process(
                ExpressionParser.parse("3-5")
            )
        );

        expectedValue = Math.sin(1) + Math.cos(1);
        Assertions.assertEquals(expectedValue, PolishNotationProcessor.process(
                ExpressionParser.parse("sin(1)+cos(1)")
            )
        );

        expectedValue = Math.sin(-1) + Math.cos(-12) * -1 * Math.tan(-2);
        Assertions.assertEquals(expectedValue, PolishNotationProcessor.process(
                ExpressionParser.parse("sin(-1)+cos(-12)*-tan(-2)")
            )
        );

        expectedValue = Math.pow(3, -1) * 1024 - 12 * Math.sqrt(3);
        Assertions.assertEquals(expectedValue, PolishNotationProcessor.process(
                ExpressionParser.parse("3^-1*1024-12*sqrt(3)")
            )
        );

        expectedValue = Math.pow(-2, -2);
        Assertions.assertEquals(expectedValue, PolishNotationProcessor.process(
                ExpressionParser.parse("-2^-2")
            )
        );

        expectedValue = -Math.pow(2, -2);
        Assertions.assertEquals(expectedValue, PolishNotationProcessor.process(
                ExpressionParser.parse("-(2^-2)")
            )
        );
    }
}
