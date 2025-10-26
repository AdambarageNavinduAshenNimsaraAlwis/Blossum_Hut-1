<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.name} - Product Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background-image: url('https://cdn.pixabay.com/photo/2020/08/01/13/18/flowers-5455362_1280.jpg');
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
        .content-card {
            backdrop-filter: blur(10px);
            background: rgba(255, 255, 255, 0.95);
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
        @keyframes slideInLeft {
            from {
                opacity: 0;
                transform: translateX(-30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
        .animate-slide-left {
            animation: slideInLeft 0.7s ease-out;
        }
        @keyframes slideInRight {
            from {
                opacity: 0;
                transform: translateX(30px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }
        .animate-slide-right {
            animation: slideInRight 0.7s ease-out;
        }
        .product-image {
            transition: transform 0.3s ease;
        }
        .product-image:hover {
            transform: scale(1.05);
        }
        .action-btn {
            transition: all 0.3s ease;
        }
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
        .info-row {
            transition: all 0.2s ease;
        }
        .info-row:hover {
            background-color: rgba(59, 130, 246, 0.05);
        }
    </style>
</head>
<body>
<!-- Include Header -->
    <jsp:include page="/WEB-INF/jsp/header.jsp" />
    <div class="max-w-6xl mx-auto animate-fade-in py-8">
        <!-- Header -->
        <div class="text-center mb-8">
            <h1 class="text-5xl font-bold text-white mb-3 drop-shadow-lg">Product Details</h1>
            <p class="text-gray-200 text-lg">Explore our delicious offerings</p>
        </div>

        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="mb-6 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-lg shadow-lg animate-fade-in">
                <div class="flex items-center">
                    <svg class="w-6 h-6 mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                    </svg>
                    <p class="font-bold">${message}</p>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="mb-6 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-lg shadow-lg animate-fade-in">
                <div class="flex items-center">
                    <svg class="w-6 h-6 mr-3" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                    </svg>
                    <p class="font-bold">${error}</p>
                </div>
            </div>
        </c:if>

        <!-- Navigation Bar -->
        <c:if test="${sessionScope.userRole != 'ADMIN'}">
        <div class="content-card rounded-xl shadow-2xl p-4 mb-6">
            <div class="flex flex-wrap items-center justify-between gap-4">
                <a href="${pageContext.request.contextPath}/products/user/list"
                   class="action-btn inline-flex items-center bg-gradient-to-r from-gray-600 to-gray-700 text-white font-bold py-2 px-5 rounded-lg hover:from-gray-700 hover:to-gray-800">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                    </svg>
                    Back to Products
                </a>
                <a href="${pageContext.request.contextPath}/cart"
                   class="action-btn inline-flex items-center bg-gradient-to-r from-pink-500 to-pink-600 text-white font-bold py-2 px-5 rounded-lg hover:from-pink-600 hover:to-pink-700 relative">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"/>
                    </svg>
                    View Cart
                    <span class="ml-2 inline-flex items-center justify-center w-6 h-6 text-xs font-bold text-orange-600 bg-white rounded-full">
                        ${cartItemCount != null ? cartItemCount : 0}
                    </span>
                </a>
            </div>
        </div>
        </c:if>

        <!-- Product Details Card -->
        <div class="content-card rounded-2xl shadow-2xl overflow-hidden">
            <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 p-8">
                <!-- Product Image Section -->
                <div class="animate-slide-left">
                    <div class="bg-gray-100 rounded-2xl p-6 shadow-inner">
                        <c:choose>
                            <c:when test="${not empty product.imagePath}">
                                <img src="${pageContext.request.contextPath}/${product.imagePath}"
                                     alt="${product.name}"
                                     class="product-image w-full h-auto rounded-xl shadow-lg object-cover">
                            </c:when>
                            <c:otherwise>
                                <div class="flex items-center justify-center h-96 bg-gray-200 rounded-xl">
                                    <div class="text-center">
                                        <svg class="w-24 h-24 mx-auto text-gray-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                        </svg>
                                        <p class="text-gray-500 font-semibold text-lg">No Image Available</p>
                                    </div>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Product Information Section -->
                <div class="animate-slide-right space-y-4">
                    <!-- Product Name -->
                    <div class="info-row p-4 rounded-lg border-l-4 border-blue-500 bg-blue-50">
                        <h3 class="text-sm font-semibold text-gray-600 uppercase mb-1">Product Name</h3>
                        <p class="text-2xl font-bold text-gray-900">${product.name}</p>
                    </div>

                    <!-- Description -->
                    <div class="info-row p-4 rounded-lg border-l-4 border-purple-500 bg-purple-50">
                        <h3 class="text-sm font-semibold text-gray-600 uppercase mb-1">Description</h3>
                        <p class="text-gray-700 leading-relaxed">${product.description}</p>
                    </div>

                    <!-- Category -->
                    <div class="info-row p-4 rounded-lg border-l-4 border-pink-500 bg-pink-50">
                        <h3 class="text-sm font-semibold text-gray-600 uppercase mb-1">Category</h3>
                        <span class="inline-flex items-center px-4 py-2 rounded-full text-sm font-bold bg-pink-200 text-pink-800">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 7h.01M7 3h5c.512 0 1.024.195 1.414.586l7 7a2 2 0 010 2.828l-7 7a2 2 0 01-2.828 0l-7-7A1.994 1.994 0 013 12V7a4 4 0 014-4z"/>
                            </svg>
                            ${product.category}
                        </span>
                    </div>

                    <!-- Price -->
                    <div class="info-row p-4 rounded-lg border-l-4 border-green-500 bg-green-50">
                        <h3 class="text-sm font-semibold text-gray-600 uppercase mb-1">Price</h3>
                        <p class="text-4xl font-bold text-green-600">
                            Rs.<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/>
                        </p>
                    </div>

                    <!-- Availability -->
                    <div class="info-row p-4 rounded-lg border-l-4 border-yellow-500 bg-yellow-50">
                        <h3 class="text-sm font-semibold text-gray-600 uppercase mb-1">Availability</h3>
                        <c:choose>
                            <c:when test="${product.inStock}">
                                <span class="inline-flex items-center text-lg font-bold text-green-600">
                                    <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                                    </svg>
                                    ${product.availability} units available
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="inline-flex items-center text-lg font-bold text-red-600">
                                    <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                                    </svg>
                                    Out of Stock
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Status -->
                    <div class="info-row p-4 rounded-lg border-l-4 border-indigo-500 bg-indigo-50">
                        <h3 class="text-sm font-semibold text-gray-600 uppercase mb-1">Status</h3>
                        <c:choose>
                            <c:when test="${product.inStock}">
                                <span class="inline-flex items-center px-4 py-2 rounded-full text-sm font-bold bg-green-100 text-green-800">
                                    <span class="w-2 h-2 bg-green-500 rounded-full mr-2 animate-pulse"></span>
                                    In Stock
                                </span>
                            </c:when>
                            <c:otherwise>
                                <span class="inline-flex items-center px-4 py-2 rounded-full text-sm font-bold bg-red-100 text-red-800">
                                    <span class="w-2 h-2 bg-red-500 rounded-full mr-2"></span>
                                    Out of Stock
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- Add to Cart -->
                    <c:if test="${sessionScope.userRole != 'ADMIN'}">
                    <div class="info-row p-6 rounded-lg border-l-4 border-pink-500 bg-pink-50">
                        <h3 class="text-sm font-semibold text-gray-600 uppercase mb-3">Add to Cart</h3>
                        <c:choose>
                            <c:when test="${product.inStock && product.availability > 0}">
                                <form action="${pageContext.request.contextPath}/cart/add" method="post" class="space-y-4">
                                    <input type="hidden" name="productId" value="${product.id}">
                                    <div class="flex items-center space-x-4">
                                        <label class="text-gray-700 font-semibold">Quantity:</label>
                                        <input type="number" name="quantity" value="1" min="1" max="${product.availability}"
                                               class="w-24 px-4 py-2 border-2 border-gray-300 rounded-lg focus:border-orange-500 focus:outline-none text-center font-bold text-lg">
                                        <span class="text-sm text-gray-500">Max: ${product.availability}</span>
                                    </div>
                                    <button type="submit"
                                            class="action-btn w-full bg-gradient-to-r from-pink-500 to-pink-600 text-white font-bold py-4 px-8 rounded-lg hover:from-pink-600 hover:to-pink-700 shadow-lg">
                                        <span class="flex items-center justify-center">
                                            <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"/>
                                            </svg>
                                            Add to Cart
                                        </span>
                                    </button>
                                </form>
                            </c:when>
                            <c:otherwise>
                                <button disabled
                                        class="w-full bg-gray-400 text-white font-bold py-4 px-8 rounded-lg cursor-not-allowed opacity-60">
                                    <span class="flex items-center justify-center">
                                        <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18.364 18.364A9 9 0 005.636 5.636m12.728 12.728A9 9 0 015.636 5.636m12.728 12.728L5.636 5.636"/>
                                        </svg>
                                        Currently Unavailable
                                    </span>
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</body>
<%@ include file="footer.jsp" %>
</html>