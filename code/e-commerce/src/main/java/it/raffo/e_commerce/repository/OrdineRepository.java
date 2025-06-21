package it.raffo.e_commerce.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import it.raffo.e_commerce.model.Ordine;

public interface OrdineRepository extends JpaRepository<Ordine, Integer> {

    Double findAverageBy();

    @Query("SELECT AVG(o.prezzoTotale) FROM Ordine o")
    Double mediaOrdini();

    @Query("SELECT o.dataOrdine, SUM(o.prezzoTotale) FROM Ordine o GROUP BY o.dataOrdine ORDER BY o.dataOrdine")
    List<Object[]> getVenditePerData();

    @Query("SELECT u.sesso, COUNT(o) FROM Ordine o JOIN o.user u GROUP BY u.sesso")
    List<Object[]> countOrdiniPerSesso();

}
