<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="min-h-screen relative">
<!-- Include Header -->
    <jsp:include page="/WEB-INF/jsp/header.jsp" />
    <!-- Background Image with Overlay -->
    <div class="fixed inset-0 z-0">
        <img src="https://images.unsplash.com/photo-1556742049-0cfed4f6a45d?w=1920&q=80"
             alt="Shopping Background"
             class="w-full h-full object-cover">
        <div class="absolute inset-0 bg-black bg-opacity-60"></div>
    </div>

    <!-- Content Wrapper -->
    <div class="relative z-10">
    <!-- Main Content -->
    <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Checkout Header Inside Content -->
        <div class="mb-8 text-center">
            <div class="inline-flex items-center justify-center w-20 h-20 bg-gradient-to-br from-pink-600 to-purple-600 rounded-full mb-4 shadow-xl">
                <i class="fas fa-credit-card text-white text-3xl"></i>
            </div>
            <h1 class="text-4xl font-bold text-white mb-3 drop-shadow-lg">Checkout</h1>
            <div class="flex items-center justify-center space-x-2 mb-6">
                <div class="w-3 h-3 bg-green-500 rounded-full animate-pulse"></div>
                <span class="text-sm text-white font-medium drop-shadow-md">Secure Checkout Process</span>
            </div>
            <div class="w-24 h-1 bg-gradient-to-r from-pink-400 to-purple-400 mx-auto rounded-full"></div>
        </div>
        <!-- Error Alert -->
        <c:if test="${not empty error}">
            <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-lg shadow-md animate-shake">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle text-red-500 text-2xl mr-3"></i>
                    <p style="color: red;" class="text-red-800 font-semibold">${error}</p>
                </div>
            </div>
        </c:if>

        <!-- Navigation Links -->
        <div class="mb-8 flex flex-wrap gap-3">
            <a href="${pageContext.request.contextPath}/cart"
               class="inline-flex items-center px-5 py-2.5 bg-white border-2 border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 hover:border-gray-400 transition duration-300 shadow-md hover:shadow-lg font-medium">
                <i class="fas fa-arrow-left mr-2"></i>
                Back to Cart
            </a>
            <span class="flex items-center text-gray-400">|</span>
            <a href="${pageContext.request.contextPath}/products/user/list"
               class="inline-flex items-center px-5 py-2.5 bg-white border-2 border-blue-300 text-blue-700 rounded-lg hover:bg-blue-50 hover:border-blue-400 transition duration-300 shadow-md hover:shadow-lg font-medium">
                <i class="fas fa-store mr-2"></i>
                Continue Shopping
            </a>
        </div>

        <!-- Checkout Form Card -->
        <div class="bg-white rounded-2xl shadow-2xl overflow-hidden border border-gray-100">
            <!-- Card Header -->
            <div class="bg-gradient-to-r from-pink-600 to-purple-600 px-8 py-6">
                <h2 class="text-2xl font-bold text-white flex items-center">
                    <i class="fas fa-shipping-fast mr-3"></i>
                    Delivery Information
                </h2>
                <p class="text-blue-100 mt-2">Please provide your delivery details to complete the order</p>
            </div>

            <!-- Form Content -->
            <form action="${pageContext.request.contextPath}/orders/create" method="post" class="p-8">
                <div class="space-y-6">
                    <!-- Delivery Address -->
                    <div class="group">
                        <label for="deliveryAddress" class="block text-sm font-semibold text-gray-700 mb-2 flex items-center">
                            <i class="fas fa-map-marker-alt mr-2 text-blue-600"></i>
                            Delivery Address:
                            <span class="text-red-500 ml-1">*</span>
                        </label>
                        <div class="relative">
                            <textarea id="deliveryAddress"
                                      name="deliveryAddress"
                                      rows="4"
                                      cols="50"
                                      required
                                      placeholder="Enter your complete delivery address including street, city, state, and postal code..."
                                      class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:ring-4 focus:ring-blue-200 focus:border-blue-500 transition duration-300 resize-none hover:border-gray-400 shadow-sm"></textarea>
                            <div class="absolute top-3 right-3 text-gray-400">
                                <i class="fas fa-home text-xl"></i>
                            </div>
                        </div>
                        <p class="mt-1 text-xs text-gray-500 flex items-center">
                            <i class="fas fa-info-circle mr-1"></i>
                            Please provide a detailed address for accurate delivery
                        </p>
                    </div>

                    <!-- Phone Number -->
                    <div class="group">
                        <label for="phoneNumber" class="block text-sm font-semibold text-gray-700 mb-2 flex items-center">
                            <i class="fas fa-phone mr-2 text-green-600"></i>
                            Phone Number:
                            <span class="text-red-500 ml-1">*</span>
                        </label>
                        <div class="relative">
                            <input type="tel"
                                   id="phoneNumber"
                                   name="phoneNumber"
                                   required
                                   placeholder="+1 (555) 123-4567"
                                   class="w-full px-4 py-3 pl-12 border-2 border-gray-300 rounded-lg focus:ring-4 focus:ring-blue-200 focus:border-blue-500 transition duration-300 hover:border-gray-400 shadow-sm">
                            <div class="absolute left-4 top-1/2 transform -translate-y-1/2 text-gray-400">
                                <i class="fas fa-phone-alt"></i>
                            </div>
                        </div>
                        <p class="mt-1 text-xs text-gray-500 flex items-center">
                            <i class="fas fa-info-circle mr-1"></i>
                            We'll use this to contact you about your delivery
                        </p>
                    </div>

                    <!-- Special Instructions -->
                    <div class="group">
                        <label for="specialInstructions" class="block text-sm font-semibold text-gray-700 mb-2 flex items-center">
                            <i class="fas fa-clipboard-list mr-2 text-purple-600"></i>
                            Special Instructions:
                            <span class="text-gray-400 text-xs ml-2">(Optional)</span>
                        </label>
                        <div class="relative">
                            <textarea id="specialInstructions"
                                      name="specialInstructions"
                                      rows="3"
                                      cols="50"
                                      placeholder="Any special delivery instructions? (e.g., gate code, preferred delivery time, etc.)"
                                      class="w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:ring-4 focus:ring-blue-200 focus:border-blue-500 transition duration-300 resize-none hover:border-gray-400 shadow-sm"></textarea>
                            <div class="absolute top-3 right-3 text-gray-400">
                                <i class="fas fa-comment-dots text-xl"></i>
                            </div>
                        </div>
                    </div>

                    <!-- Security Notice -->
                    <div class="bg-gradient-to-r from-green-50 to-blue-50 border-l-4 border-green-500 p-4 rounded-lg">
                        <div class="flex items-start">
                            <i class="fas fa-shield-alt text-green-600 text-2xl mr-3 mt-1"></i>
                            <div>
                                <h3 class="font-semibold text-gray-800 mb-1">Secure Transaction</h3>
                                <p class="text-sm text-gray-600">Your information is protected with industry-standard encryption</p>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex flex-col sm:flex-row gap-4 pt-4">
                        <button type="submit"
                                class="flex-1 px-8 py-4 bg-gradient-to-r from-green-600 to-green-700 text-white rounded-lg hover:from-green-700 hover:to-green-800 transition duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 font-semibold text-lg flex items-center justify-center group">
                            <i class="fas fa-check-circle mr-2 group-hover:scale-110 transition-transform"></i>
                            Place Order
                            <i class="fas fa-arrow-right ml-2 group-hover:translate-x-1 transition-transform"></i>
                        </button>
                        <button type="button"
                                onclick="window.location.href='${pageContext.request.contextPath}/cart'"
                                class="flex-1 px-8 py-4 bg-white border-2 border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 hover:border-gray-400 transition duration-300 shadow-md hover:shadow-lg font-semibold text-lg flex items-center justify-center group">
                            <i class="fas fa-times-circle mr-2 group-hover:rotate-90 transition-transform"></i>
                            Cancel
                        </button>
                    </div>
                </div>
            </form>
        </div>

        <!-- Additional Info Section -->
        <div class="mt-8 grid grid-cols-1 md:grid-cols-3 gap-6">
            <div class="bg-white p-6 rounded-xl shadow-md hover:shadow-lg transition duration-300 border border-gray-100">
                <div class="flex items-center mb-3">
                    <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center mr-3">
                        <i class="fas fa-truck text-blue-600 text-xl"></i>
                    </div>
                    <h3 class="font-semibold text-gray-800">Fast Delivery</h3>
                </div>
                <p class="text-sm text-gray-600">Quick and reliable shipping to your doorstep</p>
            </div>

            <div class="bg-white p-6 rounded-xl shadow-md hover:shadow-lg transition duration-300 border border-gray-100">
                <div class="flex items-center mb-3">
                    <div class="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center mr-3">
                        <i class="fas fa-lock text-green-600 text-xl"></i>
                    </div>
                    <h3 class="font-semibold text-gray-800">Secure Payment</h3>
                </div>
                <p class="text-sm text-gray-600">Your payment information is always protected</p>
            </div>

            <div class="bg-white p-6 rounded-xl shadow-md hover:shadow-lg transition duration-300 border border-gray-100">
                <div class="flex items-center mb-3">
                    <div class="w-12 h-12 bg-purple-100 rounded-full flex items-center justify-center mr-3">
                        <i class="fas fa-headset text-purple-600 text-xl"></i>
                    </div>
                    <h3 class="font-semibold text-gray-800">24/7 Support</h3>
                </div>
                <p class="text-sm text-gray-600">We're here to help whenever you need us</p>
            </div>
        </div>
    </div>

    <!-- Footer Spacing -->
    <div class="h-16"></div>
    </div>
    <!-- End Content Wrapper -->

    <!-- Include Footer -->
    <jsp:include page="footer.jsp" />

    <style>
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }
        .animate-shake {
            animation: shake 0.5s ease-in-out;
        }
        @keyframes pulse {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }
        .animate-pulse {
            animation: pulse 2s cubic-bezier(0.4, 0, 0.6, 1) infinite;
        }
    </style>
</body>
<%@ include file="footer.jsp" %>
</html>