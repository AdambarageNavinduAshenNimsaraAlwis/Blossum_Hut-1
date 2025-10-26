<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Product</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background-image: url('https://images.unsplash.com/photo-1495195134817-aeb325a55b65?w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            position: relative;
        }
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            z-index: -1;
        }
        .form-card {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
        }
        .input-field {
            transition: all 0.3s ease;
        }
        .input-field:focus {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .animate-fade-in {
            animation: fadeIn 0.6s ease-out;
        }
    </style>
    <script>
        // Validate product name
        function validateProductName(name) {
            const cleaned = name.trim();

            if (cleaned.length < 3) {
                return { valid: false, message: "Product name must be at least 3 characters" };
            }

            if (cleaned.length > 100) {
                return { valid: false, message: "Product name must not exceed 100 characters" };
            }

            if (!/^[a-zA-Z0-9\s\-&(),.']+$/.test(cleaned)) {
                return { valid: false, message: "Product name contains invalid characters" };
            }

            return { valid: true, message: "Valid product name" };
        }

        // Validate description
        function validateDescription(description) {
            const cleaned = description.trim();

            if (cleaned.length === 0) {
                return { valid: false, message: "Description is required" };
            }

            if (cleaned.length < 10) {
                return { valid: false, message: "Description must be at least 10 characters" };
            }

            if (cleaned.length > 1000) {
                return { valid: false, message: "Description must not exceed 1000 characters" };
            }

            return { valid: true, message: "Valid description" };
        }

        // Validate price
        function validatePrice(price) {
            const priceNum = parseFloat(price);

            if (isNaN(priceNum)) {
                return { valid: false, message: "Price must be a valid number" };
            }

            if (priceNum <= 0) {
                return { valid: false, message: "Price must be greater than 0" };
            }

            if (priceNum > 999999.99) {
                return { valid: false, message: "Price must not exceed 999999.99" };
            }

            // Check decimal places
            if (!/^\d+(\.\d{1,2})?$/.test(price)) {
                return { valid: false, message: "Price can have maximum 2 decimal places" };
            }

            return { valid: true, message: "Valid price" };
        }

        // Validate availability/stock
        function validateAvailability(availability) {
            const stockNum = parseInt(availability, 10);

            if (isNaN(stockNum)) {
                return { valid: false, message: "Stock quantity must be a valid number" };
            }

            if (stockNum < 0) {
                return { valid: false, message: "Stock quantity cannot be negative" };
            }

            if (stockNum > 999999) {
                return { valid: false, message: "Stock quantity exceeds maximum limit" };
            }

            return { valid: true, message: "Valid stock quantity" };
        }

        // Validate image file
        function validateImageFile(file) {
            if (!file) {
                return { valid: false, message: "No file selected" };
            }

            const allowedFormats = ['image/jpeg', 'image/png', 'image/gif'];
            if (!allowedFormats.includes(file.type)) {
                return { valid: false, message: "Only JPG, PNG, and GIF formats are allowed" };
            }

            const maxSize = 5 * 1024 * 1024; // 5MB
            if (file.size > maxSize) {
                return { valid: false, message: "File size must not exceed 5MB" };
            }

            const minSize = 100 * 1024; // 100KB minimum
            if (file.size < minSize) {
                return { valid: false, message: "File size must be at least 100KB" };
            }

            return { valid: true, message: "Valid image file" };
        }

        // Real-time validation feedback
        function validateFieldOnChange(fieldId) {
            const field = document.getElementById(fieldId);
            let feedbackId = fieldId + "Feedback";
            let feedback = document.getElementById(feedbackId);

            if (!feedback) {
                feedback = document.createElement("span");
                feedback.id = feedbackId;
                feedback.style.marginLeft = "10px";
                feedback.style.fontSize = "12px";
                field.parentNode.appendChild(feedback);
            }

            const value = field.value;
            let validation = { valid: false, message: "" };

            switch (fieldId) {
                case "name":
                    if (value.trim() === "") {
                        feedback.textContent = "";
                        return;
                    }
                    validation = validateProductName(value);
                    break;
                case "description":
                    if (value.trim() === "") {
                        feedback.textContent = "";
                        return;
                    }
                    validation = validateDescription(value);
                    break;
                case "price":
                    if (value.trim() === "") {
                        feedback.textContent = "";
                        return;
                    }
                    validation = validatePrice(value);
                    break;
                case "availability":
                    if (value.trim() === "") {
                        feedback.textContent = "";
                        return;
                    }
                    validation = validateAvailability(value);
                    break;
            }

            if (validation.valid) {
                feedback.textContent = "✓ " + validation.message;
                feedback.style.color = "green";
            } else {
                feedback.textContent = "✗ " + validation.message;
                feedback.style.color = "red";
            }
        }

        // Comprehensive form validation on submit
        function validateProductForm() {
            const name = document.getElementById("name").value;
            const description = document.getElementById("description").value;
            const category = document.getElementById("category").value;
            const price = document.getElementById("price").value;
            const availability = document.getElementById("availability").value;
            const imageFile = document.getElementById("image").files[0];

            // Validate product name
            let nameValidation = validateProductName(name);
            if (!nameValidation.valid) {
                alert("Product Name: " + nameValidation.message);
                document.getElementById("name").focus();
                return false;
            }

            // Validate description
            let descValidation = validateDescription(description);
            if (!descValidation.valid) {
                alert("Description: " + descValidation.message);
                document.getElementById("description").focus();
                return false;
            }

            // Validate category
            if (!category) {
                alert("Please select a category");
                document.getElementById("category").focus();
                return false;
            }

            // Validate price
            let priceValidation = validatePrice(price);
            if (!priceValidation.valid) {
                alert("Price: " + priceValidation.message);
                document.getElementById("price").focus();
                return false;
            }

            // Validate availability
            let availValidation = validateAvailability(availability);
            if (!availValidation.valid) {
                alert("Stock Quantity: " + availValidation.message);
                document.getElementById("availability").focus();
                return false;
            }

            // Validate image if provided
            if (imageFile) {
                let imageValidation = validateImageFile(imageFile);
                if (!imageValidation.valid) {
                    alert("Product Image: " + imageValidation.message);
                    document.getElementById("image").focus();
                    return false;
                }
            }

            return true;
        }

        // Handle image file change
        document.addEventListener("DOMContentLoaded", function() {
            const imageInput = document.getElementById("image");
            if (imageInput) {
                imageInput.addEventListener("change", function(e) {
                    const file = e.target.files[0];
                    let feedbackId = "imageFeedback";
                    let feedback = document.getElementById(feedbackId);

                    if (!feedback) {
                        feedback = document.createElement("span");
                        feedback.id = feedbackId;
                        feedback.style.marginLeft = "10px";
                        feedback.style.fontSize = "12px";
                        this.parentNode.appendChild(feedback);
                    }

                    if (file) {
                        let validation = validateImageFile(file);
                        if (validation.valid) {
                            feedback.textContent = "✓ Valid image";
                            feedback.style.color = "green";
                        } else {
                            feedback.textContent = "✗ " + validation.message;
                            feedback.style.color = "red";
                            this.value = "";
                        }
                    } else {
                        feedback.textContent = "";
                    }
                });
            }

            // Add real-time validation to form fields
            document.getElementById("name").addEventListener("change", function() {
                validateFieldOnChange("name");
            });
            document.getElementById("description").addEventListener("change", function() {
                validateFieldOnChange("description");
            });
            document.getElementById("price").addEventListener("change", function() {
                validateFieldOnChange("price");
            });
            document.getElementById("availability").addEventListener("change", function() {
                validateFieldOnChange("availability");
            });
        });

        // Format price input
        function formatPrice(input) {
            let value = input.value;
            // Allow only numbers and one decimal point
            value = value.replace(/[^0-9.]/g, '');
            // Remove extra decimal points
            if ((value.match(/\./g) || []).length > 1) {
                value = value.replace(/\.+$/, '');
            }
            input.value = value;
        }

        // Format availability input (integers only)
        function formatAvailability(input) {
            input.value = input.value.replace(/[^0-9]/g, '');
        }
    </script>
</head>
<body>
<!-- Include Header -->
    <jsp:include page="/WEB-INF/jsp/header.jsp" />
    <div class="max-w-4xl mx-auto animate-fade-in py-8">
        <!-- Header -->
        <div class="text-center mb-8">
            <h1 class="text-5xl font-bold text-white mb-2 drop-shadow-lg">Add New Product</h1>
            <p class="text-gray-200 text-lg">Fill in the details to add a new product to your inventory</p>
        </div>

        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="mb-6 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-lg shadow-lg">
                <div class="flex items-center">
                    <svg class="w-6 h-6 mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                    </svg>
                    <p class="font-bold">${message}</p>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="mb-6 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-lg shadow-lg">
                <div class="flex items-center">
                    <svg class="w-6 h-6 mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                    </svg>
                    <p class="font-bold">${error}</p>
                </div>
            </div>
        </c:if>

        <!-- Form Card -->
        <div class="form-card rounded-2xl shadow-2xl p-8">
            <form action="${pageContext.request.contextPath}/products/save" method="post" enctype="multipart/form-data" onsubmit="return validateProductForm()">
                <div class="space-y-6">
                    <!-- Product Name -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-start">
                        <label for="name" class="text-gray-700 font-semibold text-lg pt-2">
                            Product Name <span class="text-red-500">*</span>
                        </label>
                        <div class="md:col-span-2">
                            <input type="text" id="name" name="name" required
                                   class="input-field w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-pink-500 focus:outline-none"
                                   placeholder="Enter product name (e.g., Organic Apple Juice)"
                                   onchange="validateFieldOnChange('name')">
                            <span id="nameFeedback" class="text-sm font-medium"></span>
                        </div>
                    </div>

                    <!-- Description -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-start">
                        <label for="description" class="text-gray-700 font-semibold text-lg pt-2">
                            Description <span class="text-red-500">*</span>
                        </label>
                        <div class="md:col-span-2">
                            <textarea id="description" name="description" rows="5" required
                                      class="input-field w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-pink-500 focus:outline-none resize-none"
                                      placeholder="Enter product description (min 10 characters)"
                                      onchange="validateFieldOnChange('description')"></textarea>
                            <span id="descriptionFeedback" class="text-sm font-medium block mb-1"></span>
                            <small class="text-gray-500 text-xs">Minimum 10 characters, Maximum 1000 characters</small>
                        </div>
                    </div>

                    <!-- Category -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-start">
                        <label for="category" class="text-gray-700 font-semibold text-lg pt-2">
                            Category <span class="text-red-500">*</span>
                        </label>
                        <div class="md:col-span-2">
                            <select id="category" name="category" required
                                class="input-field w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-pink-500 focus:outline-none bg-white">
                                <option value="">-- Select Flower Category --</option>

                                <!-- Gift Flowers -->
                                <optgroup label="🌹 Gift Flowers">
                                    <option value="Rose">Rose</option>
                                    <option value="Tulip">Tulip</option>
                                    <option value="Orchid">Orchid</option>
                                    <option value="Lily">Lily</option>
                                    <option value="Carnation">Carnation</option>
                                    <option value="Gerbera Daisy">Gerbera Daisy</option>
                                    <option value="Peony">Peony</option>
                                    <option value="Hydrangea">Hydrangea</option>
                                </optgroup>

                                <!-- Festival Flowers -->
                                <optgroup label="🎉 Festival Flowers">
                                    <option value="Marigold">Marigold</option>
                                    <option value="Jasmine">Jasmine</option>
                                    <option value="Lotus">Lotus</option>
                                    <option value="Chrysanthemum">Chrysanthemum</option>
                                    <option value="Tuberose">Tuberose</option>
                                    <option value="Hibiscus">Hibiscus</option>
                                    <option value="Ixora">Ixora</option>
                                </optgroup>

                                <!-- Decorative Flowers -->
                                <optgroup label="🎀 Decorative Flowers">
                                    <option value="Anthurium">Anthurium</option>
                                    <option value="Gladiolus">Gladiolus</option>
                                    <option value="Alstroemeria">Alstroemeria</option>
                                    <option value="Dahlia">Dahlia</option>
                                    <option value="Gypsophila">Gypsophila (Baby’s Breath)</option>
                                    <option value="Sunflower">Sunflower</option>
                                    <option value="Lavender">Lavender</option>
                                </optgroup>
                            </select>

                        </div>
                    </div>

                    <!-- Price -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-start">
                        <label for="price" class="text-gray-700 font-semibold text-lg pt-2">
                            Price (USD) <span class="text-red-500">*</span>
                        </label>
                        <div class="md:col-span-2">
                            <div class="relative">
                                <span class="absolute left-4 top-3 text-gray-500 text-lg font-semibold">$</span>
                                <input type="text" id="price" name="price" required
                                       class="input-field w-full pl-10 pr-4 py-3 border-2 border-gray-300 rounded-lg focus:border-pink-500 focus:outline-none"
                                       placeholder="0.00" pattern="\d+(\.\d{1,2})?"
                                       oninput="formatPrice(this); validateFieldOnChange('price')">
                            </div>
                            <span id="priceFeedback" class="text-sm font-medium block mb-1"></span>
                            <small class="text-gray-500 text-xs">Maximum 2 decimal places, range: 0.01 - 999999.99</small>
                        </div>
                    </div>

                    <!-- Availability -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-start">
                        <label for="availability" class="text-gray-700 font-semibold text-lg pt-2">
                            Stock Quantity <span class="text-red-500">*</span>
                        </label>
                        <div class="md:col-span-2">
                            <input type="text" id="availability" name="availability" required
                                   class="input-field w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:border-pink-500 focus:outline-none"
                                   placeholder="0"
                                   oninput="formatAvailability(this); validateFieldOnChange('availability')">
                            <span id="availabilityFeedback" class="text-sm font-medium block mb-1"></span>
                            <small class="text-gray-500 text-xs">Enter quantity in whole numbers only</small>
                        </div>
                    </div>

                    <!-- Product Image -->
                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 items-start">
                        <label for="image" class="text-gray-700 font-semibold text-lg pt-2">
                            Product Image
                        </label>
                        <div class="md:col-span-2">
                            <div class="flex items-center justify-center w-full">
                                <label for="image" class="flex flex-col items-center justify-center w-full h-32 border-2 border-gray-300 border-dashed rounded-lg cursor-pointer bg-gray-50 hover:bg-gray-100 transition-colors">
                                    <div class="flex flex-col items-center justify-center pt-5 pb-6">
                                        <svg class="w-10 h-10 mb-3 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 16a4 4 0 01-.88-7.903A5 5 0 1115.9 6L16 6a5 5 0 011 9.9M15 13l-3-3m0 0l-3 3m3-3v12"/>
                                        </svg>
                                        <p class="mb-2 text-sm text-gray-500"><span class="font-semibold">Click to upload</span> or drag and drop</p>
                                        <p class="text-xs text-gray-500">JPG, PNG or GIF (100KB - 5MB)</p>
                                    </div>
                                    <input id="image" name="image" type="file" class="hidden" accept="image/jpeg,image/png,image/gif">
                                </label>
                            </div>
                            <span id="imageFeedback" class="text-sm font-medium block mt-2"></span>
                        </div>
                    </div>

                    <!-- Buttons -->
                    <div class="flex flex-col sm:flex-row gap-4 pt-6 border-t-2 border-gray-200">
                        <button type="submit"
                                class="flex-1 bg-gradient-to-r from-pink-600 to-pink-700 text-white font-bold py-4 px-8 rounded-lg hover:from-pink-700 hover:to-pink-800 transform hover:scale-105 transition-all duration-200 shadow-lg">
                            <span class="flex items-center justify-center">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                                </svg>
                                Add Product
                            </span>
                        </button>
                        <a href="${pageContext.request.contextPath}/products" class="flex-1">
                            <button type="button"
                                    class="w-full bg-gray-600 text-white font-bold py-4 px-8 rounded-lg hover:bg-gray-700 transform hover:scale-105 transition-all duration-200 shadow-lg">
                                <span class="flex items-center justify-center">
                                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                                    </svg>
                                    Cancel
                                </span>
                            </button>
                        </a>
                    </div>
                </div>
            </form>

            <!-- Footer Notes -->
            <div class="mt-8 pt-6 border-t-2 border-gray-200 space-y-2">
                <div class="flex items-start text-gray-600">
                    <svg class="w-5 h-5 mr-2 mt-0.5 text-red-500" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
                    </svg>
                    <p class="text-sm"><strong>Note:</strong> All fields marked with <span class="text-red-500">*</span> are required.</p>
                </div>
                <div class="flex items-start text-gray-600">
                    <svg class="w-5 h-5 mr-2 mt-0.5 text-pink-500" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                    </svg>
                    <p class="text-sm"><strong>Validation:</strong> Form validates in real-time as you fill in the fields.</p>
                </div>
            </div>
        </div>
    </div>
</body>
<%@ include file="footer.jsp" %>
</html>