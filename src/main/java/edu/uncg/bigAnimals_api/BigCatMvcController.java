package edu.uncg.bigAnimals_api;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
@RequestMapping("/cats")
public class BigCatMvcController {

    private final BigCatService service;

    public BigCatMvcController(BigCatService service) {
        this.service = service;
    }

    // Display all cats
    @GetMapping
    public String listCats(Model model) {
        model.addAttribute("catList", service.getAll());
        return "animal-list";
    }

    // Display details for one cat
    @GetMapping("/{id}")
    public String getCat(@PathVariable Long id, Model model) {
        model.addAttribute("cat", service.getById(id));
        return "animal-details";
    }

    // Show create form
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("cat", new BigCat());
        return "animal-create";
    }

    // Handle form submission for new cat
    @PostMapping("/new")
    public String createCat(@ModelAttribute BigCat cat) {
        service.create(cat);
        // BigCat does not expose getId(), so redirect to the list view instead
        return "redirect:/cats";
    }

    // Show update form
    @GetMapping("/{id}/edit")
    public String showUpdateForm(@PathVariable Long id, Model model) {
        model.addAttribute("cat", service.getById(id));
        return "animal-update";
    }

    // Handle update form submission
    @PostMapping("/update/{id}")
    public String updateCat(@PathVariable Long id, @ModelAttribute BigCat cat) {
        service.update(id, cat);
        return "redirect:/cats";
    }

    // Delete cat (GET for HTML)
    @GetMapping("/delete/{id}")
    public String deleteCat(@PathVariable Long id) {
        service.delete(id);
        return "redirect:/cats";
    }
}
