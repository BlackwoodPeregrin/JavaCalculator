package app;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import parser.ExpressionParser;
import processor.PolishNotationProcessor;

@RestController
public class AppController {
    private static final Gson gson = new Gson();
    private final Repository rep;

    @Autowired
    public AppController(Repository rep) {
        this.rep = rep;
    }

    @PostMapping("/calc")
    public String calculation(@RequestBody String requestBody) {
        System.out.println("requestBody - " + requestBody);
        ResultRequest resRequest;
        try {
            JsonObject jsonRequest = gson.fromJson(requestBody, JsonObject.class);
            var resultCalculation = PolishNotationProcessor.process(
                ExpressionParser.parse(jsonRequest.get("expression").getAsString())
            );
            resRequest = new SuccessRequestCalc(resultCalculation.toString());
        } catch (Exception ex) {
            resRequest = new FailedRequest(ex.getMessage());
        }
        System.out.println(gson.toJson(resRequest));
        return gson.toJson(resRequest);
    }

    @GetMapping("pull/history")
    public String pullHistory() {
        ResultRequest resRequest;
        try {
            resRequest = new SuccessRequestHistoryCalc(rep.findAll());
        } catch (Exception ex) {
            resRequest = new FailedRequest(ex.getMessage());
        }
        System.out.println(gson.toJson(resRequest));
        return gson.toJson(resRequest);
    }

    @GetMapping("clear/history")
    public String clearHistory() {
        try {
            rep.deleteAll();
            return gson.toJson(true);
        } catch (Exception ex) {
            return gson.toJson(false);
        }
    }

    @PostMapping("push/history")
    public String pushHistory(@RequestBody String requestBody) {
        System.out.println("requestBody - " + requestBody);
        try {
            rep.save(gson.fromJson(requestBody, HistoryCalculation.class));
            return gson.toJson(true);
        } catch (Exception ex) {
            return gson.toJson(false);
        }
    }
}
