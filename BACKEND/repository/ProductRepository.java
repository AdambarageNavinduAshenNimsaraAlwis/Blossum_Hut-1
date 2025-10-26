package com.example.flowersystem.repository;

import com.example.flowersystem.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface ProductRepository extends JpaRepository<Product, Long> {
    List<Product> findByCategory(String category);
    List<Product> findByInStock(Boolean inStock);
    List<Product> findByNameContainingIgnoreCase(String name);
}
