package edu.uncg.bigAnimals_api;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RootController {
    @GetMapping("/")
    public String home() {
        return "redirect:/cats"; // list page
    }
}
