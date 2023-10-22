package app;

import com.google.gson.JsonObject;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestBody;
import parser.ExpressionParser;
import processor.PolishNotationProcessor;
import com.google.gson.Gson;

@RestController
public class ApiController {
    private final Gson gson = new Gson();

    @PostMapping("/calc")
    public String calculateExtension(@RequestBody String requestBody) {
        RequestResult resRequest;
        try {
            JsonObject jsonRequest = gson.fromJson(requestBody, JsonObject.class);
            var result = PolishNotationProcessor.process(
                ExpressionParser.parse(jsonRequest.get("expression").getAsString())
            );
            resRequest = new RequestResult(true, result.toString());
        } catch (Exception ex) {
            resRequest = new RequestResult(false, ex.getMessage());
        }
        return gson.toJson(resRequest);
    }
}
