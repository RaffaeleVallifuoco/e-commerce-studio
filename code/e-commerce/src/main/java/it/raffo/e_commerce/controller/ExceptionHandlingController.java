package it.raffo.e_commerce.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.NoHandlerFoundException;

@Controller
public class ExceptionHandlingController {

    @GetMapping("/403")
    public String handleAccessDeniedException403() {
        return "/common/403";
    }

    @GetMapping("/404")
    public String handleAccessDeniedException404() {
        return "/common/404";
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    public String handle404(NoHandlerFoundException ex) {
        return "/common/404";
    }

    @ExceptionHandler(Exception.class)
    public String handleGeneralException() {
        return "/common/error";
    }

}
