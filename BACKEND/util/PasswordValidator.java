package com.example.flowersystem.util;

import org.springframework.stereotype.Component;

@Component
public class PasswordValidator {

    private static final String PASSWORD_PATTERN =
            "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$";

    public boolean isValid(String password) {
        return password != null && password.matches(PASSWORD_PATTERN);
    }

    public String getPasswordRequirements() {
        return "Password must contain at least 8 characters, one uppercase letter, " +
                "one lowercase letter, one number and one special character (@$!%*?&)";
    }
}