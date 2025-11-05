package edu.uncg.bigAnimals_api;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

/**
 * MVC controller for Big Cats.
 * - Returns view names instead of JSON.
 * - Uses model attributes named `animalList` and `animal`
 *   so they match the FreeMarker templates:
 *     - animal-list.ftlh     expects `animalList`
 *     - animal-details.ftlh  expects `animal`
 *     - animal-create.ftlh   expects `animal`
 *     - animal-update.ftlh   expects `animal`
 */
@Controller
@RequestMapping("/cats")
public class BigCatMvcController {

    private final BigCatService service;

    public BigCatMvcController(BigCatService service) {
        this.service = service;
    }

    // ===================== LIST VIEW =====================
    // Display all cats (list page). Model attribute name must be `animalList`
    // so animal-list.ftlh can iterate with <#list animalList as animal>.
    // Mapped to "", "/", and "/all" for convenience.
    @GetMapping({"", "/", "/all"})
    public String listCats(Model model) {
        model.addAttribute("animalList", service.getAll());
        return "animal-list"; // -> src/main/resources/templates/animal-list.ftlh
    }

    // ===================== DETAILS VIEW ==================
    // Display details for one cat. Model attribute name must be `animal`
    // so animal-details.ftlh can access fields like ${animal.name}.
    @GetMapping("/{id}")
    public String getCat(@PathVariable Long id, Model model) {
        model.addAttribute("animal", service.getById(id));
        return "animal-details"; // -> animal-details.ftlh
    }

    // ===================== CREATE FORM (GET) =============
    // Show the create form. Provide an empty `animal` so the form binds correctly.
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("animal", new BigCat());
        return "animal-create"; // -> animal-create.ftlh
    }

    // ===================== CREATE (POST) =================
    // Handle the create form submission as POST.
    @PostMapping("/new")
    public String createCat(@ModelAttribute BigCat animal) {
        service.create(animal);
        return "redirect:/cats"; // list page
    }

    // ===================== UPDATE FORM (GET) =============
    // Show the update form for an existing cat.
    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model) {
        model.addAttribute("animal", service.getById(id));
        return "animal-update"; // -> animal-update.ftlh
    }

    // ===================== UPDATE (POST) =================
    // Handle the update form submission as POST.
    @PostMapping("/update/{id}")
    public String updateCat(@PathVariable Long id, @ModelAttribute BigCat animal) {
        service.update(id, animal);
        return "redirect:/cats/" + id; // go to the updated animals details page
    }

    // ===================== DELETE (GET) ==================
    // HTML forms/links can’t easily send DELETE without JS, so keep a GET mapping.
    // After deletion, redirect to the list page.
    @GetMapping("/delete/{id}")
    public String deleteCat(@PathVariable Long id) {
        service.delete(id);
        return "redirect:/cats";
    }
}
