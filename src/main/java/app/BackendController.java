package app;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class BackendController {
    @GetMapping("/endpoint")
    public String receiveDataFromFrontend() {
        return "Hello World!";
    }

    @PostMapping("/calc")
    public String calculateExtension(String extension) {
        return extension;
    }
}
