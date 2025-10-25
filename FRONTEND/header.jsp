<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="userRole" value="${sessionScope.userRole}" />

<c:choose>
    <c:when test="${userRole == 'ADMIN'}">
        <!-- Admin Header -->
        <nav class="bg-gradient-to-r from-pink-600 to-pink-500 text-white sticky top-0 z-50 shadow-lg">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 py-3">
                <div class="flex justify-between items-center">
                    <!-- Left: Website Name -->
                    <a href="/home" class="flex items-center space-x-3 cursor-pointer">
                        <i class="fas fa-spa text-pink-100 text-2xl"></i>
                        <h1 class="text-xl sm:text-2xl font-bold bg-gradient-to-r from-pink-100 to-white bg-clip-text text-transparent">BlossomHut</h1>
                    </a>

                    <!-- Right: Navigation + User Role + Logout -->
                    <div class="flex items-center space-x-2 sm:space-x-6">
                        <!-- Navigation Links -->
                        <div class="hidden lg:flex items-center space-x-4 text-sm">
                            <a href="/admin/dashboard" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-home"></i>
                                <span>Dashboard</span>
                            </a>
                            <a href="/orders/admin/all" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-boxes"></i>
                                <span>Orders</span>
                            </a>
                            <a href="/payments/admin/all" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-money-bill-wave"></i>
                                <span>Payments</span>
                            </a>

                            <a href="/products" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-apple-alt"></i>
                                <span>Products</span>
                            </a>
                        </div>

                        <!-- User Role Badge -->
                        <div class="flex items-center space-x-2 bg-pink-700 px-3 py-1.5 rounded-lg border border-pink-200">
                            <i class="fas fa-user-tie text-pink-100 text-sm"></i>
                            <span class="text-gray-100 text-xs sm:text-sm font-medium hidden sm:inline">Admin</span>
                        </div>

                        <!-- Logout Button -->
                        <button id="logoutBtn" class="px-3 sm:px-4 py-1.5 bg-red-600 text-white rounded-lg hover:bg-red-700 transition font-semibold text-xs sm:text-sm flex items-center space-x-1">
                            <i class="fas fa-sign-out-alt"></i>
                            <span class="hidden sm:inline">Logout</span>
                        </button>
                    </div>
                </div>
            </div>
        </nav>
    </c:when>
    <c:when test="${userRole == 'USER'}">
        <!-- Customer/User Header -->
        <nav class="bg-gradient-to-r from-pink-600 to-pink-500 text-white sticky top-0 z-50 shadow-lg">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 py-3">
                <div class="flex justify-between items-center">
                    <!-- Left: Website Name -->
                    <a href="/home" class="flex items-center space-x-3 cursor-pointer">
                        <i class="fas fa-spa text-pink-100 text-2xl"></i>
                        <h1 class="text-xl sm:text-2xl font-bold bg-gradient-to-r from-pink-100 to-white bg-clip-text text-transparent">BlossomHut</h1>
                    </a>

                    <!-- Right: Navigation + User Role + Logout -->
                    <div class="flex items-center space-x-2 sm:space-x-6">
                        <!-- Navigation Links -->
                        <div class="hidden lg:flex items-center space-x-4 text-sm">
                            <a href="/dashboard" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-home"></i>
                                <span>Dashboard</span>
                            </a>
                            <a href="/products/user/list" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-apple-alt"></i>
                                <span>Browse Products</span>
                            </a>
                            <a href="/cart" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-shopping-cart"></i>
                                <span>Cart</span>
                            </a>
                            <a href="/orders" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-boxes"></i>
                                <span>My Orders</span>
                            </a>
                            <a href="/payments/my" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-wallet"></i>
                                <span>Payments</span>
                            </a>

                            <a href="/profile" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-user-cog"></i>
                                <span>Profile</span>
                            </a>
                        </div>

                        <!-- User Role Badge -->
                        <div class="flex items-center space-x-2 bg-pink-700 px-3 py-1.5 rounded-lg border border-pink-200">
                            <i class="fas fa-user-circle text-pink-100 text-sm"></i>
                            <span class="text-pink-50 text-xs sm:text-sm font-medium hidden sm:inline">Customer</span>
                        </div>

                        <!-- Logout Button -->
                        <button id="logoutBtn" class="px-3 sm:px-4 py-1.5 bg-red-600 text-white rounded-lg hover:bg-red-700 transition font-semibold text-xs sm:text-sm flex items-center space-x-1">
                            <i class="fas fa-sign-out-alt"></i>
                            <span class="hidden sm:inline">Logout</span>
                        </button>
                    </div>
                </div>
            </div>
        </nav>
    </c:when>
    <c:otherwise>
        <!-- Default Header (if role not set) -->
        <nav class="bg-gradient-to-r from-pink-600 to-pink-500 text-white sticky top-0 z-50 shadow-lg">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 py-3">
                <div class="flex justify-between items-center">
                    <!-- Left: Website Name -->
                    <a href="/home" class="flex items-center space-x-3 cursor-pointer">
                        <i class="fas fa-spa text-pink-100 text-2xl"></i>
                        <h1 class="text-xl sm:text-2xl font-bold bg-gradient-to-r from-pink-100 to-white bg-clip-text text-transparent">BlossomHut</h1>
                    </a>

                    <!-- Right: Navigation + User Role + Logout -->
                    <div class="flex items-center space-x-2 sm:space-x-6">
                        <!-- Navigation Links -->
                        <div class="hidden lg:flex items-center space-x-4 text-sm">
                            <a href="/" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-home"></i>
                                <span>Home</span>
                            </a>
                            <a href="/products/user/list" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-apple-alt"></i>
                                <span>Products</span>
                            </a>
                            <a href="/cart" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-shopping-cart"></i>
                                <span>Cart</span>
                            </a>
                            <a href="/login" class="hover:text-pink-100 transition flex items-center space-x-1 px-3 py-2 rounded-lg hover:bg-pink-700">
                                <i class="fas fa-sign-in-alt"></i>
                                <span>Login</span>
                            </a>
                        </div>

                        <!-- User Role Badge -->
                        <div class="flex items-center space-x-2 bg-pink-700 px-3 py-1.5 rounded-lg border border-pink-200">
                            <i class="fas fa-user text-pink-100 text-sm"></i>
                            <span class="text-pink-50 text-xs sm:text-sm font-medium hidden sm:inline">Guest</span>
                        </div>

                        <!-- Logout Button -->
                        <button id="logoutBtn" class="px-3 sm:px-4 py-1.5 bg-red-600 text-white rounded-lg hover:bg-red-700 transition font-semibold text-xs sm:text-sm flex items-center space-x-1">
                            <i class="fas fa-sign-out-alt"></i>
                            <span class="hidden sm:inline">Logout</span>
                        </button>
                    </div>
                </div>
            </div>
        </nav>
    </c:otherwise>
</c:choose>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<script>
    document.getElementById("logoutBtn").addEventListener("click", async () => {
        if (confirm("Are you sure you want to logout?")) {
            try {
                const response = await fetch('/api/auth/logout', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' }
                });

                if (response.ok) {
                    window.location.href = '/login';
                } else {
                    alert('Logout failed!');
                }
            } catch (error) {
                console.error('Logout error:', error);
                alert('Logout failed!');
            }
        }
    });
</script>