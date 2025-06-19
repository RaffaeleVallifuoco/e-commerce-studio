package it.raffo.e_commerce.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import it.raffo.e_commerce.model.Prodotto;
import it.raffo.e_commerce.model.User;
import it.raffo.e_commerce.repository.ProdottoRepo;
import it.raffo.e_commerce.repository.UserRepo;
import jakarta.validation.Valid;
import it.raffo.e_commerce.repository.CategoryRepo;
import it.raffo.e_commerce.repository.MarcaRepo;
import it.raffo.e_commerce.repository.OrdineRepository;

@Controller
@RequestMapping("/dash")
public class DashController {

    private final DaoAuthenticationProvider authenticationProvider;

    @Autowired
    ProdottoRepo productRepo;

    @Autowired
    CategoryRepo categoryRepo;

    @Autowired
    MarcaRepo brandRepo;

    @Autowired
    UserRepo userRepo;

    @Autowired
    OrdineRepository ordineRepo;

    DashController(DaoAuthenticationProvider authenticationProvider) {
        this.authenticationProvider = authenticationProvider;
    }

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
        Double aov = ordineRepo.mediaOrdini();
        if (aov == null)
            aov = 0.0;
        model.addAttribute("aov", aov);
        model.addAttribute("orders", ordineRepo.count());
        model.addAttribute("brand", brandRepo.findAll());

        model.addAttribute("nuovoprodotto", new Prodotto());

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

    @GetMapping("/show/{id}")
    public String getProductById(@PathVariable("id") Integer id,
            Model model) {

        Prodotto product = productRepo.getReferenceById(id);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        Optional<User> currentUser = userRepo.findByUsername(username);
        User user = currentUser.get();
        model.addAttribute("user", user);
        model.addAttribute("product", product);
        model.addAttribute("evidence", productRepo.findByEvidenceTrue());
        model.addAttribute("category", categoryRepo.findAll());

        return "/dash/detail";

    }

    // FORM INSERT / UPDATE
    @GetMapping({ "/form", "/form/{id}" })
    public String productForm(@PathVariable(required = false) Integer id, Model model) {
        if (id != null) {
            Prodotto product = productRepo.findById(id).orElse(new Prodotto());
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();
            Optional<User> currentUser = userRepo.findByUsername(username);
            User user = currentUser.get();
            model.addAttribute("user", user);
            model.addAttribute("product", product);
            model.addAttribute("category", categoryRepo.findAll());
            model.addAttribute("isUpdate", true);
            model.addAttribute("brand", brandRepo.findAll());
        } else {
            model.addAttribute("product", new Prodotto());
        }
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        Optional<User> currentUser = userRepo.findByUsername(username);
        User user = currentUser.get();
        model.addAttribute("user", user);
        model.addAttribute("brand", brandRepo.findAll());
        model.addAttribute("category", categoryRepo.findAll());
        model.addAttribute("isUpdate", false);

        return "/dash/form"; //
    }

    // UPDATE
    @PostMapping("/{id}/edit")
    public String Update(@PathVariable("id") Integer id, @Valid @ModelAttribute("ticket") Prodotto productUpdate,
            BindingResult bindingresult,
            Model model) {

        if (bindingresult.hasErrors()) {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();
            Optional<User> currentUser = userRepo.findByUsername(username);
            User user = currentUser.get();
            model.addAttribute("user", user);
            model.addAttribute("evidence", productRepo.findByEvidenceTrue());
            model.addAttribute("category", categoryRepo.findAll());

            return "/{id}/edit";
        }
        Prodotto existingProduct = productRepo.getReferenceById(id);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        Optional<User> currentUser = userRepo.findByUsername(username);
        User user = currentUser.get();
        model.addAttribute("user", user);
        existingProduct.setNome(productUpdate.getNome());
        existingProduct.setDescrizione(productUpdate.getDescrizione());
        existingProduct.setEvidence(productUpdate.isEvidence());
        existingProduct.setCategoria(productUpdate.getCategoria());
        existingProduct.setMarca(productUpdate.getMarca());
        existingProduct.setPrezzo(productUpdate.getPrezzo());
        existingProduct.setQuantita(productUpdate.getQuantita());
        existingProduct.setDataProduzione(productUpdate.getDataProduzione());

        productRepo.save(existingProduct);

        return "redirect:/dash/show/{id}";
    }

    // CREATE
    @PostMapping("/insert")
    public String store(@Valid @ModelAttribute("nuovoprodotto") Prodotto productForm, BindingResult bindingresult,
            Model model) {

        if (bindingresult.hasErrors()) {

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();
            Optional<User> currentUser = userRepo.findByUsername(username);
            User user = currentUser.get();
            model.addAttribute("user", user);
            model.addAttribute("category", categoryRepo.findAll());
            model.addAttribute("brand", brandRepo.findAll());

            return "/dash/home";
        }

        productRepo.save(productForm);

        return "redirect:/dash/home";

    }

    // DELETE
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable("id") Integer id) {

        productRepo.deleteById(id);

        return "redirect:/dash/home";
    }

}
