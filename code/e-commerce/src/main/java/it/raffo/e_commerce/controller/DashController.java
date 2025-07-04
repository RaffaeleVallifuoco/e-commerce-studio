package it.raffo.e_commerce.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import jakarta.validation.Valid;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import it.raffo.e_commerce.model.Prodotto;
import it.raffo.e_commerce.model.User;
import it.raffo.e_commerce.model.User.Sesso;
import it.raffo.e_commerce.repository.ProdottoRepo;
import it.raffo.e_commerce.repository.UserRepo;
import it.raffo.e_commerce.repository.CategoryRepo;
import it.raffo.e_commerce.repository.MarcaRepo;
import it.raffo.e_commerce.repository.OrdineRepository;

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

    @Autowired
    OrdineRepository ordineRepo;

    // HOME
    @GetMapping("/home")
    public String dashboardHome(Model model, @RequestParam(name = "keyword", required = false) String keyword) {

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        Optional<User> currentUser = userRepo.findByUsername(username);
        User user = currentUser.get();
        Double aov = ordineRepo.mediaOrdini();
        if (aov == null)
            aov = 0.0;

        // GRAFICI JS

        List<Object[]> vendite = ordineRepo.getVenditePerData();
        List<String> dateLabels = new ArrayList<>();
        List<Double> totalePrezzi = new ArrayList<>();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

        for (Object[] riga : vendite) {
            LocalDate data = (LocalDate) riga[0];
            Double somma = (Double) riga[1];

            dateLabels.add(data.format(formatter));
            totalePrezzi.add(somma);
        }

        List<Object[]> ordiniPerSesso = ordineRepo.countOrdiniPerSesso();
        Map<String, Long> sessoCount = new HashMap<>();

        for (Object[] riga : ordiniPerSesso) {
            String sesso = riga[0].toString(); // "M" o "F"
            Long count = (Long) riga[1];
            sessoCount.put(sesso, count);
        }

        // ATTRIBUTES

        model.addAttribute("ordiniPerSesso", sessoCount);
        model.addAttribute("user", user);
        model.addAttribute("category", categoryRepo.findAll());
        model.addAttribute("total", productRepo.countByAllIgnoreCase());
        model.addAttribute("outOfStock", productRepo.countByQuantitaLessThan(1));
        model.addAttribute("runningOut", productRepo.countByQuantitaGreaterThanAndQuantitaLessThan(1, 20));
        model.addAttribute("uomini", userRepo.countBySesso(Sesso.M));
        model.addAttribute("donne", userRepo.countBySesso(Sesso.F));
        model.addAttribute("aov", aov);
        model.addAttribute("orders", ordineRepo.count());
        model.addAttribute("brand", brandRepo.findAll());
        model.addAttribute("dateLabels", dateLabels);
        model.addAttribute("totalePrezzi", totalePrezzi);
        model.addAttribute("nuovoprodotto", new Prodotto());

        return "/dash/home";
    }

    // PFODUCT FIND ALL
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

        // ATTRIBUTES

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

        // ATTRIBUTES

        model.addAttribute("user", user);
        model.addAttribute("list", productList);
        model.addAttribute("keyword", keyword);
        model.addAttribute("evidence", productRepo.findByEvidenceTrue());
        model.addAttribute("category", categoryRepo.findAll());
        model.addAttribute("runningOut", productRepo.findByQuantitaGreaterThanAndQuantitaLessThan(1, 20));

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

        // ATTRIBUTES

        model.addAttribute("user", user);
        model.addAttribute("list", productList);
        model.addAttribute("keyword", keyword);
        model.addAttribute("evidence", productRepo.findByEvidenceTrue());
        model.addAttribute("category", categoryRepo.findAll());
        model.addAttribute("outOfStock", productRepo.findByQuantitaLessThan(1));

        return "/dash/outofstock";
    }

    // SEARCH BY CATEGORY
    @GetMapping("/home/{category_id}")
    public String getCategory(@PathVariable("category_id") Integer categoryId,
            Model model) {

        List<Prodotto> productList = new ArrayList<>();

        productList = productRepo.findByCategoriaId(categoryId);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        Optional<User> currentUser = userRepo.findByUsername(username);

        // ATTRIBUTES

        User user = currentUser.get();
        model.addAttribute("user", user);
        model.addAttribute("list", productList);
        model.addAttribute("evidence", productRepo.findByEvidenceTrue());
        model.addAttribute("category", categoryRepo.findAll());

        return "/dash/home";
    }

    // PRODUCT DETAIL
    @GetMapping("/show/{id}")
    public String getProductById(@PathVariable("id") Integer id, Model model) {

        Prodotto product = productRepo.getReferenceById(id);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        Optional<User> currentUser = userRepo.findByUsername(username);
        User user = currentUser.get();

        // ATTRIBUTES

        model.addAttribute("user", user);
        model.addAttribute("product", product);
        model.addAttribute("evidence", productRepo.findByEvidenceTrue());
        model.addAttribute("category", categoryRepo.findAll());

        return "/dash/detail";

    }

    // UPDATE
    @GetMapping({ "/form/{id}" })
    public String productForm(@PathVariable(required = true) Integer id, Model model) {
        if (id != null) {
            Prodotto product = productRepo.getReferenceById(id);
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();
            Optional<User> currentUser = userRepo.findByUsername(username);
            User user = currentUser.get();

            // ATTRIBUTES

            model.addAttribute("user", user);
            model.addAttribute("product", product);
            model.addAttribute("category", categoryRepo.findAll());
            model.addAttribute("isUpdate", true);
            model.addAttribute("brand", brandRepo.findAll());
        }

        return "/dash/form"; //
    }

    @PostMapping("/{id}/edit")
    public String Update(@PathVariable("id") Integer id, @Valid @ModelAttribute("product") Prodotto productUpdate,
            BindingResult bindingresult,
            @RequestParam("file") MultipartFile file,
            Model model, RedirectAttributes redirectAttributes) {

        // UPDATE ERROR
        if (bindingresult.hasErrors()) {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();
            Optional<User> currentUser = userRepo.findByUsername(username);
            User user = currentUser.get();

            // ATTRIBUTES

            model.addAttribute("user", user);
            model.addAttribute("evidence", productRepo.findByEvidenceTrue());
            model.addAttribute("category", categoryRepo.findAll());
            model.addAttribute("brand", brandRepo.findAll());
            return "/dash/form";
        }

        // UPDATE

        Prodotto existingProduct = productRepo.getReferenceById(id);

        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String username = authentication.getName();
        Optional<User> currentUser = userRepo.findByUsername(username);
        User user = currentUser.get();

        // MULTIPART EXCEPTION HANDLING

        if (file != null && !file.isEmpty()) {
            try {
                String nomeFile = java.util.UUID.randomUUID() + "_" + file.getOriginalFilename();
                java.nio.file.Path uploadPath = java.nio.file.Paths.get("uploads/");
                if (!java.nio.file.Files.exists(uploadPath)) {
                    java.nio.file.Files.createDirectories(uploadPath);
                }
                file.transferTo(uploadPath.resolve(nomeFile));
                existingProduct.setPhotoPath(nomeFile);
            } catch (java.io.IOException e) {
                e.printStackTrace();
            }
        }

        existingProduct.setNome(productUpdate.getNome());
        existingProduct.setDescrizione(productUpdate.getDescrizione());
        existingProduct.setEvidence(productUpdate.isEvidence());
        existingProduct.setCategoria(productUpdate.getCategoria());
        existingProduct.setMarca(productUpdate.getMarca());
        existingProduct.setPrezzo(productUpdate.getPrezzo());
        existingProduct.setQuantita(productUpdate.getQuantita());
        existingProduct.setDataProduzione(productUpdate.getDataProduzione());

        // SAVE

        productRepo.save(existingProduct);

        // ATTRIBUTES
        model.addAttribute("user", user);
        redirectAttributes.addFlashAttribute("success", "Prodotto modifiato con successo!");
        return "redirect:/dash/show/{id}";
    }

    // CREATE
    @PostMapping("/insert")
    public String store(@Valid @ModelAttribute("nuovoprodotto") Prodotto productForm,
            BindingResult bindingresult,
            @RequestParam("file") MultipartFile file,
            Model model, RedirectAttributes redirectAttributes) {

        // INSERT ERROR
        if (bindingresult.hasErrors()) {

            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            String username = authentication.getName();
            Optional<User> currentUser = userRepo.findByUsername(username);
            User user = currentUser.get();
            Double aov = ordineRepo.mediaOrdini();
            if (aov == null)
                aov = 0.0;

            // GRAFICI JS

            List<Object[]> vendite = ordineRepo.getVenditePerData();

            List<String> dateLabels = new ArrayList<>();
            List<Double> totalePrezzi = new ArrayList<>();

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");

            for (Object[] riga : vendite) {
                LocalDate data = (LocalDate) riga[0];
                Double somma = (Double) riga[1];

                dateLabels.add(data.format(formatter));
                totalePrezzi.add(somma);
            }

            List<Object[]> ordiniPerSesso = ordineRepo.countOrdiniPerSesso();
            Map<String, Long> sessoCount = new HashMap<>();

            for (Object[] riga : ordiniPerSesso) {
                String sesso = riga[0].toString(); // "M" o "F"
                Long count = (Long) riga[1];
                sessoCount.put(sesso, count);
            }

            // ATTRIBUTES RITORNO A HOME
            model.addAttribute("user", user);
            model.addAttribute("category", categoryRepo.findAll());
            model.addAttribute("brand", brandRepo.findAll());
            model.addAttribute("openOffcanvas", true);

            model.addAttribute("category", categoryRepo.findAll());
            model.addAttribute("total", productRepo.countByAllIgnoreCase());
            model.addAttribute("outOfStock", productRepo.countByQuantitaLessThan(1));
            model.addAttribute("runningOut", productRepo.countByQuantitaGreaterThanAndQuantitaLessThan(1, 20));
            model.addAttribute("uomini", userRepo.countBySesso(Sesso.M));
            model.addAttribute("donne", userRepo.countBySesso(Sesso.F));
            model.addAttribute("aov", aov);
            model.addAttribute("orders", ordineRepo.count());
            model.addAttribute("brand", brandRepo.findAll());
            model.addAttribute("dateLabels", dateLabels);
            model.addAttribute("totalePrezzi", totalePrezzi);
            model.addAttribute("ordiniPerSesso", sessoCount);

            return "/dash/home";
        }

        // MULTIPART EXCEPTION HANDLING

        if (!file.isEmpty()) {
            try {
                String nomeFile = java.util.UUID.randomUUID() + "_" + file.getOriginalFilename();
                java.nio.file.Path uploadPath = java.nio.file.Paths.get("uploads/");
                if (!java.nio.file.Files.exists(uploadPath)) {
                    java.nio.file.Files.createDirectories(uploadPath);
                }
                file.transferTo(uploadPath.resolve(nomeFile));
                productForm.setPhotoPath(nomeFile);
            } catch (java.io.IOException e) {
                e.printStackTrace();
            }
        }

        productRepo.save(productForm);

        // ATTRIBUTES

        model.addAttribute("nuovoprodotto", productForm); // contiene gli errori
        redirectAttributes.addFlashAttribute("success", "Prodotto inserito con successo!");

        return "redirect:/dash/home";

    }

    // DELETE
    @PostMapping("/{id}/delete")
    public String delete(@PathVariable("id") Integer id) {

        productRepo.deleteById(id);

        return "redirect:/dash/products";
    }

}
