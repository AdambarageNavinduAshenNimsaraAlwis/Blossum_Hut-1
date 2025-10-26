package com.example.flowersystem.service;

import com.example.flowersystem.model.User;

public interface JwtService {
    String generateToken(User user);
    String extractUsername(String token);
    boolean validateToken(String token, String email);
}