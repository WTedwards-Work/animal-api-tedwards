package edu.uncg.bigAnimals_api;

import org.springframework.boot.CommandLineRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * Seeds the database with example BigCat data when the app starts,
 * if there are no existing entries.
 */
@Configuration
public class SeedData {

    @Bean
    CommandLineRunner seedDatabase(BigCatService service) {
        return args -> {
            if (service.getAll().isEmpty()) {

                service.create(new BigCat(
                        "Tiger",
                        "Powerful predator found mainly in Asia.",
                        "Tiger",
                        "Panthera tigris",
                        ConservationStatus.EN,
                        5.0,
                        "Tropical Forest",
                        220.5
                ));

                service.create(new BigCat(
                        "Lion",
                        "Known as the king of the jungle.",
                        "Lion",
                        "Panthera leo",
                        ConservationStatus.VU,
                        6.0,
                        "Savannah",
                        190.0
                ));

                service.create(new BigCat(
                        "Leopard",
                        "Solitary and agile hunter with rosette spots.",
                        "Leopard",
                        "Panthera pardus",
                        ConservationStatus.VU,
                        4.0,
                        "Rainforest",
                        90.5
                ));

                System.out.println(" Seed data added successfully!");
            } else {
                System.out.println(" Database already contains data — skipping seed.");
            }
        };
    }
}
