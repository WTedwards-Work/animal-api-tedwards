package edu.uncg.bigAnimals_api;

import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class BigCatService {

    private final BigCatRepository repo;

    public BigCatService(BigCatRepository repo) {
        this.repo = repo;
    }

    public List<BigCat> getAll() { return repo.findAll(); }

    public BigCat getById(Long id) {
        return repo.findById(id).orElseThrow(() -> new NotFoundException(id));
    }

    public BigCat create(BigCat b) {
        b.setBigCatId(null);
        return repo.save(b);
    }

    public BigCat update(Long id, BigCat in) {
        BigCat b = getById(id);
        b.setName(in.getName());
        b.setDescription(in.getDescription());
        b.setCommonName(in.getCommonName());
        b.setScientificName(in.getScientificName());
        b.setConservationStatus(in.getConservationStatus());
        b.setAge(in.getAge());
        b.setHabitat(in.getHabitat());
        b.setWeightKg(in.getWeightKg());
        return repo.save(b);
    }

    public void delete(Long id) { repo.delete(getById(id)); }

    // Queries
    public List<BigCat> searchByName(String q) { return repo.findByNameContainingIgnoreCase(q); }
    public List<BigCat> byCommonName(String cn) { return repo.findByCommonNameIgnoreCase(cn); }
    public List<BigCat> byStatus(ConservationStatus status) { return repo.findByConservationStatus(status); }
    public List<BigCat> byHabitat(String h) { return repo.findByHabitatContainingIgnoreCase(h); }
    public List<BigCat> byAgeRange(Double min, Double max) { return repo.findByAgeBetween(min, max); }
}
