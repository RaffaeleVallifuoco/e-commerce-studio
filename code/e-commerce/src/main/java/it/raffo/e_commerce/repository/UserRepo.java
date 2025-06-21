package it.raffo.e_commerce.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import it.raffo.e_commerce.model.User;
import it.raffo.e_commerce.model.User.Sesso;

public interface UserRepo extends JpaRepository<User, Integer> {

    Optional<User> findByUsername(String username);

    int countBySesso(Sesso sesso);

}
