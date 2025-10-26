<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Products</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background: #ffffff;
            min-height: 100vh;
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
        .product-card {
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }
        .product-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }
        .product-image {
            transition: transform 0.3s ease;
        }
        .product-card:hover .product-image {
            transform: scale(1.1);
        }
        .nav-bar {
            backdrop-filter: blur(20px);
            background: rgba(255, 255, 255, 0.95);
        }
        .action-btn {
            transition: all 0.2s ease;
        }
        .action-btn:hover {
            transform: scale(1.05);
        }
        @keyframes pulse-slow {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.7;
            }
        }
        .pulse-slow {
            animation: pulse-slow 2s ease-in-out infinite;
        }
    </style>
</head>
<body>
<!-- Include Header -->
    <jsp:include page="/WEB-INF/jsp/header.jsp" />
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Header Section -->
        <div class="mb-10 animate-fade-in">
            <div class="bg-gradient-to-r from-orange-500 via-purple-600 to-pink-600 rounded-2xl shadow-2xl p-8 relative overflow-hidden">
                <!-- Decorative Elements -->
                <div class="absolute top-0 right-0 w-64 h-64 bg-white opacity-5 rounded-full -mr-32 -mt-32"></div>
                <div class="absolute bottom-0 left-0 w-48 h-48 bg-white opacity-5 rounded-full -ml-24 -mb-24"></div>

                <div class="relative z-10">
                    <div class="flex flex-col md:flex-row md:items-center md:justify-between gap-6">
                        <!-- Title Section -->
                        <div>
                            <h1 class="text-4xl md:text-5xl font-extrabold text-white mb-2 flex items-center gap-3">
                                <svg class="w-10 h-10 md:w-12 md:h-12" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6.253v13m0-13C10.832 5.477 9.246 5 7.5 5S4.168 5.477 3 6.253v13C4.168 18.477 5.754 18 7.5 18s3.332.477 4.5 1.253m0-13C13.168 5.477 14.754 5 16.5 5c1.747 0 3.332.477 4.5 1.253v13C19.832 18.477 18.247 18 16.5 18c-1.746 0-3.332.477-4.5 1.253"/>
                                </svg>
                                Browse Our Collection
                            </h1>
                        </div>

                        <!-- Action Buttons -->
                        <div class="flex flex-wrap items-center gap-3">
                            <a href="${pageContext.request.contextPath}/cart"
                               class="action-btn inline-flex items-center bg-white text-orange-600 font-bold py-3 px-6 rounded-xl hover:bg-orange-50 shadow-lg relative group">
                                <svg class="w-5 h-5 mr-2 group-hover:scale-110 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"/>
                                </svg>
                                View Cart
                                <span class="ml-2 inline-flex items-center justify-center min-w-6 h-6 px-1 text-xs font-bold text-white bg-orange-600 rounded-full pulse-slow">
                                    ${cartItemCount != null ? cartItemCount : 0}
                                </span>
                            </a>
                            <a href="${pageContext.request.contextPath}/orders"
                               class="action-btn inline-flex items-center bg-white text-green-700 font-bold py-3 px-6 rounded-xl hover:bg-green-50 shadow-lg group">
                                <svg class="w-5 h-5 mr-2 group-hover:scale-110 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01"/>
                                </svg>
                                My Orders
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="mb-6 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-xl shadow-lg animate-fade-in">
                <div class="flex items-center">
                    <svg class="w-6 h-6 mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                    </svg>
                    <p class="font-bold">${message}</p>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="mb-6 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-xl shadow-lg animate-fade-in">
                <div class="flex items-center">
                    <svg class="w-6 h-6 mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                    </svg>
                    <p class="font-bold">${error}</p>
                </div>
            </div>
        </c:if>

        <!-- Products Section -->
        <c:choose>
            <c:when test="${empty products}">
                <div class="nav-bar rounded-2xl shadow-2xl p-16 text-center animate-fade-in">
                    <svg class="w-24 h-24 mx-auto text-gray-400 mb-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"/>
                    </svg>
                    <p class="text-2xl text-gray-600 font-semibold mb-2">No products available at the moment.</p>
                    <p class="text-gray-500">Check back soon for delicious offerings!</p>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Product Cards Grid -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                    <c:forEach var="product" items="${products}">
                        <div class="product-card bg-white rounded-2xl shadow-xl overflow-hidden animate-fade-in">
                            <!-- Product Image -->
                            <div class="relative h-56 bg-gradient-to-br from-gray-100 to-gray-200 overflow-hidden">
                                <c:choose>
                                    <c:when test="${not empty product.imagePath}">
                                        <img src="${pageContext.request.contextPath}/${product.imagePath}"
                                             alt="${product.name}"
                                             class="product-image w-full h-full object-cover">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="flex items-center justify-center h-full">
                                            <svg class="w-20 h-20 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                            </svg>
                                        </div>
                                    </c:otherwise>
                                </c:choose>

                                <!-- Category Badge -->
                                <div class="absolute top-3 left-3">
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-white text-purple-700 shadow-lg">
                                        <svg class="w-3 h-3 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M17.707 9.293a1 1 0 010 1.414l-7 7a1 1 0 01-1.414 0l-7-7A.997.997 0 012 10V5a3 3 0 013-3h5c.256 0 .512.098.707.293l7 7zM5 6a1 1 0 100-2 1 1 0 000 2z" clip-rule="evenodd"/>
                                        </svg>
                                        ${product.category}
                                    </span>
                                </div>

                                <!-- Availability Badge -->
                                <div class="absolute top-3 right-3">
                                    <c:choose>
                                        <c:when test="${product.availability > 0}">
                                            <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-green-500 text-white shadow-lg">
                                                <span class="w-2 h-2 bg-white rounded-full mr-1 animate-pulse"></span>
                                                ${product.availability} Left
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-red-500 text-white shadow-lg">
                                                <svg class="w-3 h-3 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                                                </svg>
                                                Out of Stock
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <!-- Product Info -->
                            <div class="p-5">
                                <!-- Product Name -->
                                <h3 class="text-xl font-bold text-gray-900 mb-2 truncate">${product.name}</h3>

                                <!-- Description -->
                                <p class="text-gray-600 text-sm mb-4 line-clamp-2 h-10">${product.description}</p>

                                <!-- Price -->
                                <div class="flex items-center justify-between mb-4">
                                    <div class="flex items-baseline">
                                        <span class="text-3xl font-bold text-green-600">$<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></span>
                                    </div>
                                </div>

                                <!-- Action Section -->
                                <div class="space-y-2">
                                    <c:choose>
                                        <c:when test="${product.inStock && product.availability > 0}">
                                            <form action="${pageContext.request.contextPath}/cart/add" method="post" class="space-y-2">
                                                <input type="hidden" name="productId" value="${product.id}">
                                                <div class="flex items-center justify-center space-x-2 bg-gray-50 rounded-lg p-2">
                                                    <label class="text-sm font-semibold text-gray-700">Qty:</label>
                                                    <input type="number" name="quantity" value="1" min="1" max="${product.availability}"
                                                           class="w-16 px-2 py-1 border-2 border-gray-300 rounded-lg text-center font-bold focus:border-orange-500 focus:outline-none">
                                                    <span class="text-xs text-gray-500">Max: ${product.availability}</span>
                                                </div>
                                                <button type="submit"
                                                        class="action-btn w-full bg-gradient-to-r from-pink-500 to-pink-600 text-white font-bold py-3 px-4 rounded-xl hover:from-pink-600 hover:to-pink-700 shadow-lg">
                                                    <span class="flex items-center justify-center">
                                                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"/>
                                                        </svg>
                                                        Add to Cart
                                                    </span>
                                                </button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <button disabled
                                                    class="w-full bg-gray-300 text-gray-500 font-bold py-3 px-4 rounded-xl cursor-not-allowed opacity-60">
                                                <span class="flex items-center justify-center">
                                                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636"/>
                                                    </svg>
                                                    Out of Stock
                                                </span>
                                            </button>
                                        </c:otherwise>
                                    </c:choose>

                                    <!-- View Details Link -->
                                    <a href="${pageContext.request.contextPath}/products/view/${product.id}"
                                       class="action-btn block text-center bg-gradient-to-r from-purple-600 to-purple-700 text-white font-bold py-3 px-4 rounded-xl hover:from-purple-700 hover:to-purple-800 shadow-lg">
                                        <span class="flex items-center justify-center">
                                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                            </svg>
                                            View Details
                                        </span>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>


    </div>
</body>
<%@ include file="footer.jsp" %>
</html>