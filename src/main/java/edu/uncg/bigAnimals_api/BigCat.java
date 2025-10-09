package edu.uncg.bigAnimals_api;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "big_cats")
public class BigCat {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long bigCatId;

    @NotBlank
    @Column(nullable = false)
    private String name;

    @NotBlank
    @Column(nullable = false, length = 2000)
    private String description;

    @NotBlank
    @Column(nullable = false)
    private String commonName; // Lion, Tiger, etc.

    private String scientificName;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private ConservationStatus conservationStatus = ConservationStatus.VU;

    @NotNull
    @Column(nullable = false)
    private Double age;

    private String habitat;
    private Double weightKg;

    public BigCat() {}

    public BigCat(String name, String description, String commonName, String scientificName,
                  ConservationStatus conservationStatus, Double age, String habitat, Double weightKg) {
        this.name = name;
        this.description = description;
        this.commonName = commonName;
        this.scientificName = scientificName;
        this.conservationStatus = conservationStatus;
        this.age = age;
        this.habitat = habitat;
        this.weightKg = weightKg;
    }

    // Getters and setters
    public Long getBigCatId() { return bigCatId; }
    public void setBigCatId(Long bigCatId) { this.bigCatId = bigCatId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getCommonName() { return commonName; }
    public void setCommonName(String commonName) { this.commonName = commonName; }
    public String getScientificName() { return scientificName; }
    public void setScientificName(String scientificName) { this.scientificName = scientificName; }
    public ConservationStatus getConservationStatus() { return conservationStatus; }
    public void setConservationStatus(ConservationStatus conservationStatus) { this.conservationStatus = conservationStatus; }
    public Double getAge() { return age; }
    public void setAge(Double age) { this.age = age; }
    public String getHabitat() { return habitat; }
    public void setHabitat(String habitat) { this.habitat = habitat; }
    public Double getWeightKg() { return weightKg; }
    public void setWeightKg(Double weightKg) { this.weightKg = weightKg; }
}
