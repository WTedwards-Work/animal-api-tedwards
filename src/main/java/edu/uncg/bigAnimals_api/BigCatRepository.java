package edu.uncg.bigAnimals_api;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import java.util.List;

public interface BigCatRepository extends JpaRepository<BigCat, Long> {

    List<BigCat> findByNameContainingIgnoreCase(String name);

    List<BigCat> findByCommonNameIgnoreCase(String commonName);

    List<BigCat> findByConservationStatus(ConservationStatus status);

    List<BigCat> findByHabitatContainingIgnoreCase(String habitat);

    @Query("select b from BigCat b where (:min is null or b.age >= :min) and (:max is null or b.age <= :max)")
    List<BigCat> findByAgeBetween(Double min, Double max);
}
