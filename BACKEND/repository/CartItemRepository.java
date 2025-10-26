package com.example.flowersystem.repository;

import com.example.flowersystem.model.Cart;
import com.example.flowersystem.model.CartItem;
import com.example.flowersystem.model.Product;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CartItemRepository extends JpaRepository<CartItem, Long> {
    Optional<CartItem> findByCartAndProduct(Cart cart, Product product);
}