package edu.uncg.bigAnimals_api;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        // Legacy static pages forward to MVC routes
        registry.addViewController("/index.html").setViewName("forward:/cats");
        registry.addViewController("/add-animal.html").setViewName("forward:/cats/new");
        registry.addViewController("/details.html").setViewName("forward:/cats");
    }
}
