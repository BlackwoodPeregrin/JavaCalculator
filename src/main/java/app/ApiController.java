package app;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import parser.ExpressionParser;
import processor.PolishNotationProcessor;

@RestController
public class ApiController {

    @GetMapping("/hello")
    public String hello() {
        return "hello world";
    }

    @PostMapping("/calc")
    public String calculateExtension(String expression) {
        try {
            return PolishNotationProcessor.process(
                ExpressionParser.parse(expression)
            ).toString() + '\n';
        } catch (RuntimeException ex) {
            return ex.getMessage() + '\n';
        }
    }
}
