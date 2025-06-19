package it.raffo.e_commerce.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import it.raffo.e_commerce.model.Ordine;

public interface OrdineRepository extends JpaRepository<Ordine, Integer> {

    Double findAverageBy();

    @Query("SELECT AVG(o.prezzoTotale) FROM Ordine o")
    Double mediaOrdini();

}
