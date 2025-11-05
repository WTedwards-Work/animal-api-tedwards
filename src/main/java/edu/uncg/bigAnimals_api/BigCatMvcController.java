package edu.uncg.bigAnimals_api;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@Controller
@RequestMapping("/cats")
public class BigCatMvcController {

    private final BigCatService service;

    public BigCatMvcController(BigCatService service) {
        this.service = service;
    }

    // ===================== LIST VIEW =====================
    @GetMapping({"", "/", "/all"})
    public String listCats(Model model) {
        model.addAttribute("animalList", service.getAll());
        return "animal-list"; // -> templates/animal-list.ftlh
    }

    // ===================== DETAILS VIEW ==================
    @GetMapping("/{id}")
    public String getCat(@PathVariable Long id, Model model) {
        model.addAttribute("animal", service.getById(id));
        return "animal-details"; // -> templates/animal-details.ftlh
    }

    // ===================== CREATE FORM (GET) =============
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("animal", new BigCat());
        return "animal-create"; // -> templates/animal-create.ftlh
    }

    // ===================== CREATE (POST) =================
    @PostMapping("/new")
    public String createCat(@ModelAttribute BigCat animal,
                            @RequestParam(value = "image", required = false) MultipartFile image) throws IOException {
        // Handle optional image upload
        saveImageIfPresent(animal, image);
        service.create(animal);
        return "redirect:/cats"; // list page
    }

    // ===================== UPDATE FORM (GET) =============
    @GetMapping("/update/{id}")
    public String showUpdateForm(@PathVariable Long id, Model model) {
        model.addAttribute("animal", service.getById(id));
        return "animal-update"; // -> templates/animal-update.ftlh
    }

    // ===================== UPDATE (POST) =================
    @PostMapping("/update/{id}")
    public String updateCat(@PathVariable Long id,
                            @ModelAttribute BigCat animal,
                            @RequestParam(value = "image", required = false) MultipartFile image) throws IOException {

        // Preserve existing fields that aren’t posted or when image is not replaced
        BigCat existing = service.getById(id);

        // If no new image provided, keep existing URL
        if ((image == null || image.isEmpty())) {
            animal.setImageUrl(existing.getImageUrl());
        } else {
            saveImageIfPresent(animal, image);
        }

        // Ensure we’re updating the right row
        animal.setBigCatId(id);

        service.update(id, animal);
        return "redirect:/cats/" + id; // go to updated details page
    }

    // ===================== DELETE (GET) ==================
    @GetMapping("/delete/{id}")
    public String deleteCat(@PathVariable Long id) {
        service.delete(id);
        return "redirect:/cats";
    }

    // ===================== Helpers =======================
    /**
     * Saves the uploaded image under the local "uploads" folder and sets animal.imageUrl
     * to a path like "/images/<uuid>.ext". Requires WebConfig to map /images/** to that folder.
     */
    private void saveImageIfPresent(BigCat animal, MultipartFile image) throws IOException {
        if (image == null || image.isEmpty()) return;

        Path uploadDir = Paths.get("uploads");
        Files.createDirectories(uploadDir);

        String original = StringUtils.cleanPath(image.getOriginalFilename() == null ? "" : image.getOriginalFilename());
        String ext = "";
        int dot = original.lastIndexOf('.');
        if (dot >= 0) {
            ext = original.substring(dot).toLowerCase();
        }

        String filename = UUID.randomUUID() + ext;
        Path target = uploadDir.resolve(filename);

        image.transferTo(target.toFile());
        animal.setImageUrl("/images/" + filename);
    }
}
