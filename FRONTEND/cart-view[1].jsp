<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
</head>
<body class="bg-gradient-to-br from-gray-50 to-gray-100 min-h-screen">
<!-- Include Header -->
    <jsp:include page="/WEB-INF/jsp/header.jsp" />
    <!-- Header -->
    <div class="bg-white shadow-md sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-4">
            <div class="flex items-center justify-between">
                <h1 class="text-3xl font-bold text-gray-800 flex items-center">
                    <i class="fas fa-shopping-cart mr-3 text-blue-600"></i>
                    Shopping Cart
                </h1>
                <div class="flex space-x-4">
                    <a href="${pageContext.request.contextPath}/products/user/list"
                       class="flex items-center px-4 py-2 bg-pink-600 text-white rounded-lg hover:bg-pink-700 transition duration-300 shadow-md hover:shadow-lg">
                        <i class="fas fa-store mr-2"></i>
                        Continue Shopping
                    </a>
                    <a href="${pageContext.request.contextPath}/orders"
                       class="flex items-center px-4 py-2 bg-gray-700 text-white rounded-lg hover:bg-gray-800 transition duration-300 shadow-md hover:shadow-lg">
                        <i class="fas fa-box mr-2"></i>
                        My Orders
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Message Alerts -->
        <c:if test="${not empty message}">
            <div class="mb-6 bg-green-50 border-l-4 border-green-500 p-4 rounded-lg shadow-md animate-fade-in">
                <div class="flex items-center">
                    <i class="fas fa-check-circle text-green-500 text-xl mr-3"></i>
                    <p class="text-green-800 font-medium">${message}</p>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-lg shadow-md animate-fade-in">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle text-red-500 text-xl mr-3"></i>
                    <p class="text-red-800 font-medium">${error}</p>
                </div>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${empty cart.cartItems}">
                <!-- Empty Cart State -->
                <div class="bg-white rounded-2xl shadow-xl p-12 text-center">
                    <div class="mb-6">
                        <i class="fas fa-shopping-basket text-gray-300 text-8xl"></i>
                    </div>
                    <h2 class="text-2xl font-semibold text-gray-800 mb-3">Your cart is empty</h2>
                    <p class="text-gray-600 mb-8">Looks like you haven't added anything to your cart yet</p>
                    <a href="${pageContext.request.contextPath}/products/user/list"
                       class="inline-flex items-center px-8 py-3 bg-gradient-to-r from-pink-600 to-pink-700 text-white rounded-lg hover:from-pink-700 hover:to-pink-800 transition duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                        <i class="fas fa-shopping-bag mr-2"></i>
                        Browse Products
                    </a>
                </div>
            </c:when>
            <c:otherwise>
                <!-- Cart Items -->
                <div class="bg-white rounded-2xl shadow-xl overflow-hidden">
                    <!-- Desktop Table View -->
                    <div class="hidden md:block overflow-x-auto">
                        <table class="w-full">
                            <thead class="bg-gradient-to-r from-gray-700 to-gray-800 text-white">
                                <tr>
                                    <th class="px-6 py-4 text-left text-sm font-semibold uppercase tracking-wider">Image</th>
                                    <th class="px-6 py-4 text-left text-sm font-semibold uppercase tracking-wider">Product</th>
                                    <th class="px-6 py-4 text-left text-sm font-semibold uppercase tracking-wider">Price</th>
                                    <th class="px-6 py-4 text-left text-sm font-semibold uppercase tracking-wider">Quantity</th>
                                    <th class="px-6 py-4 text-left text-sm font-semibold uppercase tracking-wider">Subtotal</th>
                                    <th class="px-6 py-4 text-left text-sm font-semibold uppercase tracking-wider">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-gray-200">
                                <c:forEach var="item" items="${cart.cartItems}">
                                    <tr class="hover:bg-gray-50 transition duration-200">
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${not empty item.product.imagePath}">
                                                    <img src="${pageContext.request.contextPath}/${item.product.imagePath}"
                                                         alt="${item.product.name}"
                                                         class="w-16 h-16 object-cover rounded-lg shadow-md border-2 border-gray-200">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-16 h-16 bg-gray-200 rounded-lg flex items-center justify-center shadow-md border-2 border-gray-300">
                                                        <i class="fas fa-image text-gray-400 text-2xl"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4">
                                            <p class="font-semibold text-gray-800">${item.product.name}</p>
                                        </td>
                                        <td class="px-6 py-4">
                                            <span class="text-lg font-semibold text-gray-900">$<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <form action="${pageContext.request.contextPath}/cart/update/${item.id}" method="post" class="flex items-center space-x-2">
                                                <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.availability}"
                                                       class="w-20 px-3 py-2 border-2 border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-center font-medium">
                                                <button type="submit"
                                                        class="px-4 py-2 bg-pink-600 text-white rounded-lg hover:bg-pink-700 transition duration-300 shadow-md hover:shadow-lg">
                                                    <i class="fas fa-sync-alt mr-1"></i>
                                                    Update
                                                </button>
                                            </form>
                                        </td>
                                        <td class="px-6 py-4">
                                            <span class="text-xl font-bold text-blue-600">$<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></span>
                                        </td>
                                        <td class="px-6 py-4">
                                            <a href="${pageContext.request.contextPath}/cart/remove/${item.id}"
                                               onclick="return confirm('Remove this item from cart?')"
                                               class="inline-flex items-center px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition duration-300 shadow-md hover:shadow-lg">
                                                <i class="fas fa-trash-alt mr-2"></i>
                                                Remove
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                <tr class="bg-gradient-to-r from-gray-100 to-gray-50">
                                    <td colspan="4" class="px-6 py-6 text-right">
                                        <span class="text-xl font-bold text-gray-800">Total:</span>
                                    </td>
                                    <td colspan="2" class="px-6 py-6">
                                        <span class="text-3xl font-bold text-blue-600">$<fmt:formatNumber value="${cart.totalAmount}" pattern="#,##0.00"/></span>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <!-- Mobile Card View -->
                    <div class="md:hidden divide-y divide-gray-200">
                        <c:forEach var="item" items="${cart.cartItems}">
                            <div class="p-6 hover:bg-gray-50 transition duration-200">
                                <div class="flex space-x-4">
                                    <c:choose>
                                        <c:when test="${not empty item.product.imagePath}">
                                            <img src="${pageContext.request.contextPath}/${item.product.imagePath}"
                                                 alt="${item.product.name}"
                                                 class="w-24 h-24 object-cover rounded-lg shadow-md border-2 border-gray-200">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="w-24 h-24 bg-gray-200 rounded-lg flex items-center justify-center shadow-md border-2 border-gray-300">
                                                <i class="fas fa-image text-gray-400 text-3xl"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="flex-1">
                                        <h3 class="font-semibold text-gray-800 mb-2">${item.product.name}</h3>
                                        <p class="text-lg font-semibold text-gray-900 mb-2">$<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></p>
                                        <form action="${pageContext.request.contextPath}/cart/update/${item.id}" method="post" class="flex items-center space-x-2 mb-3">
                                            <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.availability}"
                                                   class="w-16 px-2 py-1 border-2 border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-blue-500 text-center font-medium">
                                            <button type="submit"
                                                    class="px-3 py-1 bg-blue-600 text-white text-sm rounded-lg hover:bg-blue-700 transition duration-300">
                                                <i class="fas fa-sync-alt mr-1"></i>
                                                Update
                                            </button>
                                        </form>
                                        <div class="flex justify-between items-center">
                                            <span class="text-xl font-bold text-blue-600">$<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></span>
                                            <a href="${pageContext.request.contextPath}/cart/remove/${item.id}"
                                               onclick="return confirm('Remove this item from cart?')"
                                               class="px-3 py-1 bg-red-600 text-white text-sm rounded-lg hover:bg-red-700 transition duration-300">
                                                <i class="fas fa-trash-alt mr-1"></i>
                                                Remove
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                        <div class="p-6 bg-gradient-to-r from-gray-100 to-gray-50">
                            <div class="flex justify-between items-center">
                                <span class="text-xl font-bold text-gray-800">Total:</span>
                                <span class="text-3xl font-bold text-blue-600">$<fmt:formatNumber value="${cart.totalAmount}" pattern="#,##0.00"/></span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Action Buttons -->
                <div class="mt-8 flex flex-col sm:flex-row justify-between items-center space-y-4 sm:space-y-0 sm:space-x-4">
                    <a href="${pageContext.request.contextPath}/cart/clear"
                       onclick="return confirm('Clear entire cart?')"
                       class="w-full sm:w-auto">
                        <button type="button"
                                class="w-full px-8 py-3 bg-gradient-to-r from-red-600 to-red-700 text-white rounded-lg hover:from-red-700 hover:to-red-800 transition duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 flex items-center justify-center">
                            <i class="fas fa-trash mr-2"></i>
                            Clear Cart
                        </button>
                    </a>
                    <a href="${pageContext.request.contextPath}/orders/checkout"
                       class="w-full sm:w-auto">
                        <button type="button"
                                class="w-full px-8 py-3 bg-gradient-to-r from-green-600 to-green-700 text-white rounded-lg hover:from-green-700 hover:to-green-800 transition duration-300 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 flex items-center justify-center font-semibold text-lg">
                            <i class="fas fa-credit-card mr-2"></i>
                            Proceed to Checkout
                        </button>
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- Footer Spacing -->
    <div class="h-16"></div>

    <style>
        @keyframes fade-in {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .animate-fade-in {
            animation: fade-in 0.5s ease-out;
        }
    </style>
</body>
<%@ include file="footer.jsp" %>
</html>