package it.raffo.e_commerce.model;

import java.time.LocalDate;
import java.util.Set;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "Ordini")
public class Ordine {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "data_ordine")
    private LocalDate dataOrdine;

    @Column(name = "prezzo_totale")
    private Double prezzoTotale;

    @ManyToMany
    @JoinTable(name = "ordine_prodotto", joinColumns = @JoinColumn(name = "ordine_id"), inverseJoinColumns = @JoinColumn(name = "prodotto_id"))
    private Set<Prodotto> prodotti;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    // CONSTRUCTORS

    public Ordine() {
        this.dataOrdine = LocalDate.now();
    }

    public Ordine(Set<Prodotto> prodotti) {
        this.dataOrdine = LocalDate.now();
        this.prodotti = prodotti;
        this.prezzoTotale = calcolaTotale();
    }

    // GETTER & SETTER

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public LocalDate getDataOrdine() {
        return dataOrdine;
    }

    public void setDataOrdine(LocalDate dataOrdine) {
        this.dataOrdine = dataOrdine;
    }

    public Double getPrezzoTotale() {
        return prezzoTotale;
    }

    public void setPrezzoTotale(Double prezzoTotale) {
        this.prezzoTotale = prezzoTotale;
    }

    public Set<Prodotto> getProdotti() {
        return prodotti;
    }

    public void setProdotti(Set<Prodotto> prodotti) {
        this.prodotti = prodotti;
        this.prezzoTotale = calcolaTotale();
    }

    // CALCOLA PREZZO

    private Double calcolaTotale() {
        return prodotti.stream()
                .mapToDouble(Prodotto::getPrezzo)
                .sum();
    }

    // TOSTRING - EQUALS - HASHCODE

    @Override
    public int hashCode() {
        final int prime = 31;
        int result = 1;
        result = prime * result + ((id == null) ? 0 : id.hashCode());
        result = prime * result + ((dataOrdine == null) ? 0 : dataOrdine.hashCode());
        result = prime * result + ((prezzoTotale == null) ? 0 : prezzoTotale.hashCode());
        result = prime * result + ((prodotti == null) ? 0 : prodotti.hashCode());
        return result;
    }

    @Override
    public String toString() {
        return "Ordine [id=" + id + ", dataOrdine=" + dataOrdine + ", prezzoTotale=" + prezzoTotale + ", prodotti="
                + prodotti + "]";
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Ordine other = (Ordine) obj;
        if (id == null) {
            if (other.id != null)
                return false;
        } else if (!id.equals(other.id))
            return false;
        if (dataOrdine == null) {
            if (other.dataOrdine != null)
                return false;
        } else if (!dataOrdine.equals(other.dataOrdine))
            return false;
        if (prezzoTotale == null) {
            if (other.prezzoTotale != null)
                return false;
        } else if (!prezzoTotale.equals(other.prezzoTotale))
            return false;
        if (prodotti == null) {
            if (other.prodotti != null)
                return false;
        } else if (!prodotti.equals(other.prodotti))
            return false;
        return true;
    }

}
