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
import it.raffo.e_commerce.repository.CategoryRepo;
import it.raffo.e_commerce.repository.MarcaRepo;

@Controller
@RequestMapping("/dash")
public class DashController {

    @Autowired
    ProdottoRepo productRepo;

    @Autowired
    CategoryRepo categoryRepo;

    @Autowired
    MarcaRepo brandRepo;

    @Autowired
    UserRepo userRepo;

    @GetMapping("/home")
    public String dashboardHome(Model model, @RequestParam(name = "keyword", required = false) String keyword) {

        List<Prodotto> productList = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {

            productList = productRepo.cercaProdotti(keyword);

        } else {

            productList = productRepo.findAll();
        }

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        Optional<User> currentUser = userRepo.findByUsername(username);
        User user = currentUser.get();
        model.addAttribute("user", user);
        model.addAttribute("list", productList);
        model.addAttribute("keyword", keyword);
        model.addAttribute("evidence", productRepo.findByEvidenceTrue());
        model.addAttribute("category", categoryRepo.findAll());
        model.addAttribute("total", productRepo.countByAllIgnoreCase());
        model.addAttribute("outOfStock", productRepo.countByQuantitaLessThan(1));
        model.addAttribute("runningOut", productRepo.countByQuantitaLessThan(20));

        return "/dash/home";
    }

    @GetMapping("/products")
    public String productsList(Model model, @RequestParam(name = "keyword", required = false) String keyword) {

        List<Prodotto> productList = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {

            productList = productRepo.cercaProdotti(keyword);

        } else {

            productList = productRepo.findAll();
        }

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        Optional<User> currentUser = userRepo.findByUsername(username);
        User user = currentUser.get();
        model.addAttribute("user", user);
        model.addAttribute("list", productList);
        model.addAttribute("keyword", keyword);
        model.addAttribute("evidence", productRepo.findByEvidenceTrue());
        model.addAttribute("category", categoryRepo.findAll());

        return "/dash/products";
    }

    @GetMapping("/runningOut")
    public String runningOutList(Model model, @RequestParam(name = "keyword", required = false) String keyword) {

        List<Prodotto> productList = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {

            productList = productRepo.cercaProdotti(keyword);

        } else {

            productList = productRepo.findAll();
        }

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        Optional<User> currentUser = userRepo.findByUsername(username);
        User user = currentUser.get();
        model.addAttribute("user", user);
        model.addAttribute("list", productList);
        model.addAttribute("keyword", keyword);
        model.addAttribute("evidence", productRepo.findByEvidenceTrue());
        model.addAttribute("category", categoryRepo.findAll());
        model.addAttribute("runningOut", productRepo.findByQuantitaLessThan(10));

        return "/dash/runningout";
    }

    @GetMapping("/outOfStock")
    public String outOfStockList(Model model, @RequestParam(name = "keyword", required = false) String keyword) {

        List<Prodotto> productList = new ArrayList<>();

        if (keyword != null && !keyword.isBlank()) {

            productList = productRepo.cercaProdotti(keyword);

        } else {

            productList = productRepo.findAll();
        }

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        Optional<User> currentUser = userRepo.findByUsername(username);
        User user = currentUser.get();
        model.addAttribute("user", user);
        model.addAttribute("list", productList);
        model.addAttribute("keyword", keyword);
        model.addAttribute("evidence", productRepo.findByEvidenceTrue());
        model.addAttribute("category", categoryRepo.findAll());
        model.addAttribute("outOfStock", productRepo.findByQuantitaLessThan(1));

        return "/dash/outofstock";
    }

    @GetMapping("/home/{category_id}")
    public String getCategory(@PathVariable("category_id") Integer categoryId,
            Model model) {

        List<Prodotto> productList = new ArrayList<>();

        productList = productRepo.findByCategoriaId(categoryId);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        Optional<User> currentUser = userRepo.findByUsername(username);
        User user = currentUser.get();
        model.addAttribute("user", user);
        model.addAttribute("list", productList);
        model.addAttribute("evidence", productRepo.findByEvidenceTrue());
        model.addAttribute("category", categoryRepo.findAll());

        return "/dash/home";
    }

}
