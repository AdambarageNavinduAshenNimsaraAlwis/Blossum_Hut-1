package com.example.flowersystem.controller;


import com.example.flowersystem.dto.RegisterRequest;
import com.example.flowersystem.model.User;
import com.example.flowersystem.service.UserService;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private UserService userService;

    /**
     * Display all users
     */
    @GetMapping("/users")
    public String listUsersAdmin(Model model) {
        List<User> users = userService.getAllUsers(); // Make sure you have a service method to fetch all users
        model.addAttribute("users", users);
        return "user-list-admin";
    }

    /**
     * Show edit user form
     */
    @GetMapping("/users/edit/{id}")
    public String showEditUserForm(@PathVariable Long id,
                                   Model model,
                                   HttpSession session,
                                   RedirectAttributes redirectAttributes) {
        // Check if user is admin
        String role = (String) session.getAttribute("userRole");
        if (role == null || !role.equals("ADMIN")) {
            return "redirect:/login";
        }

        try {
            User user = userService.findById(id);
            model.addAttribute("user", user);
            return "user-edit-admin"; // Returns WEB-INF/jsp/edit-user.jsp
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "User not found: " + e.getMessage());
            return "redirect:/admin/users";
        }
    }

    /**
     * Process edit user form
     */
    @PostMapping("/users/edit/{id}")
    public String editUser(@PathVariable Long id,
                           @RequestParam("firstName") String firstName,
                           @RequestParam("lastName") String lastName,
                           @RequestParam("email") String email,
                           @RequestParam("role") String role,
                           @RequestParam(value = "password", required = false) String password,
                           @RequestParam(value = "confirmPassword", required = false) String confirmPassword,
                           HttpSession session,
                           RedirectAttributes redirectAttributes) {
        // Check if user is admin
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null || !userRole.equals("ADMIN")) {
            return "redirect:/login";
        }

        try {
            RegisterRequest updateRequest = new RegisterRequest();
            updateRequest.setFirstName(firstName);
            updateRequest.setLastName(lastName);
            updateRequest.setEmail(email);
            updateRequest.setRole(role);
            updateRequest.setPassword(password);
            updateRequest.setConfirmPassword(confirmPassword);

            userService.updateUserById(id, updateRequest);
            redirectAttributes.addFlashAttribute("message", "User updated successfully");
            return "redirect:/admin/users";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", e.getMessage());
            return "redirect:/admin/users/edit/" + id;
        }
    }

    /**
     * Delete user
     */
    @PostMapping("/users/delete/{id}")
    public String deleteUser(@PathVariable Long id,
                             HttpSession session,
                             RedirectAttributes redirectAttributes) {
        // Check if user is admin
        String role = (String) session.getAttribute("userRole");
        if (role == null || !role.equals("ADMIN")) {
            return "redirect:/login";
        }

        try {
            userService.deleteUserById(id);
            redirectAttributes.addFlashAttribute("message", "User deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete user: " + e.getMessage());
        }
        return "redirect:/admin/users";
    }
}