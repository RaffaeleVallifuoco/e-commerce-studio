package it.raffo.e_commerce.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import it.raffo.e_commerce.model.Prodotto;
import it.raffo.e_commerce.model.User;
import it.raffo.e_commerce.repository.ProdottoRepo;
import it.raffo.e_commerce.repository.UserRepo;
import jakarta.servlet.http.HttpSession;
import it.raffo.e_commerce.repository.CategoryRepo;
import it.raffo.e_commerce.repository.MarcaRepo;

@Controller
@RequestMapping("/home")
public class HomeController {

    @Autowired
    ProdottoRepo productRepo;

    @Autowired
    CategoryRepo categoryRepo;

    @Autowired
    MarcaRepo brandRepo;

    @Autowired
    UserRepo userRepo;

    // @GetMapping("/")
    // public String index(Model model, @RequestParam(name = "keyword", required =
    // false) String keyword) {

    // List<Prodotto> productList = new ArrayList<>();
    // List<Prodotto> evidenceList = new ArrayList<>();

    // if (keyword != null && !keyword.isBlank()) {

    // productList = productRepo.cercaProdotti(keyword);

    // } else {

    // productList = productRepo.findAll();
    // }

    // evidenceList = productRepo.findByEvidenceTrue();

    // Authentication authentication =
    // SecurityContextHolder.getContext().getAuthentication();
    // if (authentication != null && authentication.isAuthenticated()
    // && !authentication.getPrincipal().equals("anonymousUser")) {
    // String username = authentication.getName();
    // userRepo.findByUsername(username).ifPresent(user ->
    // model.addAttribute("user", user));
    // }
    // model.addAttribute("list", productList);
    // model.addAttribute("keyword", keyword);
    // model.addAttribute("evidence", evidenceList);
    // model.addAttribute("category", categoryRepo.findAll());

    // return "/home/home";
    // }

    @GetMapping("/")
    public String index(HttpSession model, @RequestParam(name = "keyword", required = false) String keyword) {

        List<Prodotto> productList = new ArrayList<>();
        List<Prodotto> evidenceList = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {

            productList = productRepo.cercaProdotti(keyword);

        } else {

            productList = productRepo.findAll();
        }

        evidenceList = productRepo.findByEvidenceTrue();

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()
                && !authentication.getPrincipal().equals("anonymousUser")) {
            String username = authentication.getName();
            userRepo.findByUsername(username).ifPresent(user -> model.setAttribute("user", user));
        }
        model.setAttribute("list", productList);
        model.setAttribute("keyword", keyword);
        model.setAttribute("evidence", evidenceList);
        model.setAttribute("category", categoryRepo.findAll());

        return "/home/home";
    }

    @GetMapping("/{category_id}")
    public String getCategory(@PathVariable("category_id") Integer categoryId,
            Model model) {

        List<Prodotto> productList = new ArrayList<>();

        productList = productRepo.findByCategoriaId(categoryId);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()
                && !authentication.getPrincipal().equals("anonymousUser")) {
            String username = authentication.getName();
            userRepo.findByUsername(username).ifPresent(user -> model.addAttribute("user", user));
        }
        model.addAttribute("list", productList);
        model.addAttribute("evidence", productRepo.findByEvidenceTrue());
        model.addAttribute("category", categoryRepo.getReferenceById(categoryId));
        model.addAttribute("userHasAdminRole",
                model.containsAttribute("user") && ((User) model.getAttribute("user")).getRoles().stream()
                        .anyMatch(r -> r.getRole().equals("ADMIN")));

        return "/home/category";
    }

    // FIND BY ID
    @GetMapping("/detail/{id}")
    public String getProductById(@PathVariable("id") Integer id,
            Model model) {

        Prodotto product = productRepo.getReferenceById(id);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        if (authentication != null && authentication.isAuthenticated()
                && !authentication.getPrincipal().equals("anonymousUser")) {
            String username = authentication.getName();
            userRepo.findByUsername(username).ifPresent(user -> model.addAttribute("user", user));
        }
        model.addAttribute("product", product);
        model.addAttribute("evidence", productRepo.findByEvidenceTrue());
        model.addAttribute("category", categoryRepo.findAll());

        return "home/product-detail";

    }

}
