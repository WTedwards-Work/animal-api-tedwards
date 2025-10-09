package edu.uncg.bigAnimals_api;

import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.net.URI;
import java.util.List;

@RestController
@RequestMapping("/api/bigcats")
@CrossOrigin(origins = "*")
public class BigCatController {

    private final BigCatService service;

    public BigCatController(BigCatService service) {
        this.service = service;
    }

    // GET all
    @GetMapping
    public List<BigCat> all() { return service.getAll(); }

    // GET by id
    @GetMapping("/{id}")
    public BigCat one(@PathVariable Long id) { return service.getById(id); }

    // POST create
    @PostMapping
    public ResponseEntity<BigCat> create(@Valid @RequestBody BigCat b) {
        BigCat saved = service.create(b);
        return ResponseEntity.created(URI.create("/api/bigcats/" + saved.getBigCatId())).body(saved);
    }

    // PUT update
    @PutMapping("/{id}")
    public BigCat update(@PathVariable Long id, @Valid @RequestBody BigCat in) {
        return service.update(id, in);
    }

    // DELETE
    @DeleteMapping("/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable Long id) { service.delete(id); }

    // --- Custom query endpoints ---
    @GetMapping("/search")
    public List<BigCat> search(@RequestParam("q") String q) { return service.searchByName(q); }

    @GetMapping("/common/{name}")
    public List<BigCat> byCommonName(@PathVariable("name") String name) { return service.byCommonName(name); }

    @GetMapping("/status/{status}")
    public List<BigCat> byStatus(@PathVariable("status") ConservationStatus status) { return service.byStatus(status); }

    @GetMapping("/habitat")
    public List<BigCat> byHabitat(@RequestParam("q") String habitat) { return service.byHabitat(habitat); }

    @GetMapping("/age")
    public List<BigCat> byAge(@RequestParam(required = false) Double min,
                              @RequestParam(required = false) Double max) {
        return service.byAgeRange(min, max);
    }
}
