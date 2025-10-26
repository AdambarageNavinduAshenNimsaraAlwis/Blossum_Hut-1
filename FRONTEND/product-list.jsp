<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        body {
            background-image: url('https://images.unsplash.com/photo-1542838132-92c53300491e?w=1920&q=80');
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
        .product-card {
            transition: all 0.3s ease;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }
        .table-row {
            transition: all 0.2s ease;
        }
        .table-row:hover {
            background-color: rgba(59, 130, 246, 0.05);
            transform: scale(1.01);
        }
        .action-btn {
            transition: all 0.2s ease;
        }
        .action-btn:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<!-- Include Header -->
    <jsp:include page="/WEB-INF/jsp/header.jsp" />
    <div class="max-w-7xl mx-auto animate-fade-in py-8">
        <!-- Header -->
        <div class="text-center mb-8">
            <p class="text-gray-200 text-3xl font-bold">Manage your inventory with ease</p>
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

        <!-- Actions Bar -->
        <div class="content-card rounded-xl shadow-2xl p-6 mb-6">
            <div class="flex items-center justify-between">
                <a href="${pageContext.request.contextPath}/products/add" class="inline-flex items-center bg-gradient-to-r from-pink-600 to-pink-700 text-white font-bold py-3 px-6 rounded-lg hover:from-pink-700 hover:to-pink-800 transform hover:scale-105 transition-all duration-200 shadow-lg">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"/>
                    </svg>
                    Add New Product
                </a>
                <div class="text-gray-600 font-semibold">
                    <span class="text-2xl text-pink-600">${products.size()}</span> Products
                </div>
            </div>
        </div>

        <!-- Products Table -->
        <div class="content-card rounded-xl shadow-2xl overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead class="bg-gradient-to-r from-pink-600 to-pink-700 text-white">
                        <tr>
                            <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">ID</th>
                            <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Image</th>
                            <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Name</th>
                            <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Description</th>
                            <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Category</th>
                            <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Price</th>
                            <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Availability</th>
                            <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Status</th>
                            <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Actions</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-gray-200">
                        <c:forEach var="product" items="${products}">
                            <tr class="table-row">
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="text-sm font-bold text-gray-900">#${product.id}</span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${not empty product.imagePath}">
                                            <img src="${pageContext.request.contextPath}/${product.imagePath}"
                                                 alt="${product.name}"
                                                 class="w-16 h-16 rounded-lg object-cover shadow-md border-2 border-gray-200">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="w-16 h-16 rounded-lg bg-gray-200 flex items-center justify-center shadow-md">
                                                <svg class="w-8 h-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"/>
                                                </svg>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="text-sm font-semibold text-gray-900">${product.name}</div>
                                </td>
                                <td class="px-6 py-4">
                                    <div class="text-sm text-gray-600 max-w-xs truncate">${product.description}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-purple-100 text-purple-800">
                                        ${product.category}
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="text-lg font-bold text-green-600">$<fmt:formatNumber value="${product.price}" pattern="#,##0.00"/></span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="text-sm font-semibold text-gray-900">${product.availability}</span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <c:choose>
                                        <c:when test="${product.inStock}">
                                            <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-green-100 text-green-800">
                                                <svg class="w-3 h-3 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                                                </svg>
                                                In Stock
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-bold bg-red-100 text-red-800">
                                                <svg class="w-3 h-3 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                                                </svg>
                                                Out of Stock
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm">
                                    <div class="space-y-2">
                                        <div class="flex space-x-2">
                                            <a href="${pageContext.request.contextPath}/products/view/${product.id}"
                                               class="action-btn inline-flex items-center px-3 py-1 bg-pink-500 text-white rounded-md hover:bg-pink-600 text-xs font-semibold">
                                                <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                                </svg>
                                                View
                                            </a>
                                            <a href="${pageContext.request.contextPath}/products/edit/${product.id}"
                                               class="action-btn inline-flex items-center px-3 py-1 bg-yellow-500 text-white rounded-md hover:bg-yellow-600 text-xs font-semibold">
                                                <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"/>
                                                </svg>
                                                Edit
                                            </a>
                                            <a href="${pageContext.request.contextPath}/products/delete/${product.id}"
                                               onclick="return confirm('Are you sure you want to delete this product?')"
                                               class="action-btn inline-flex items-center px-3 py-1 bg-red-500 text-white rounded-md hover:bg-red-600 text-xs font-semibold">
                                                <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                                </svg>
                                                Delete
                                            </a>
                                        </div>
                                        <form action="${pageContext.request.contextPath}/products/updateStock/${product.id}" method="post" class="flex items-center space-x-2">
                                            <input type="number" name="quantity" value="${product.availability}" min="0"
                                                   class="w-20 px-2 py-1 border-2 border-gray-300 rounded-md text-sm focus:border-pink-500 focus:outline-none">
                                            <button type="submit"
                                                    class="action-btn inline-flex items-center px-3 py-1 bg-green-500 text-white rounded-md hover:bg-green-600 text-xs font-semibold">
                                                <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 4v5h.582m15.356 2A8.001 8.001 0 004.582 9m0 0H9m11 11v-5h-.581m0 0a8.003 8.003 0 01-15.357-2m15.357 2H15"/>
                                                </svg>
                                                Update Stock
                                            </button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        <c:if test="${empty products}">
                            <tr>
                                <td colspan="9" class="px-6 py-12 text-center">
                                    <div class="flex flex-col items-center justify-center">
                                        <svg class="w-16 h-16 text-gray-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 13V6a2 2 0 00-2-2H6a2 2 0 00-2 2v7m16 0v5a2 2 0 01-2 2H6a2 2 0 01-2-2v-5m16 0h-2.586a1 1 0 00-.707.293l-2.414 2.414a1 1 0 01-.707.293h-3.172a1 1 0 01-.707-.293l-2.414-2.414A1 1 0 006.586 13H4"/>
                                        </svg>
                                        <p class="text-gray-500 text-lg font-semibold">No products available</p>
                                        <p class="text-gray-400 text-sm mt-2">Start by adding your first product</p>
                                    </div>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>


    </div>
</body>
<%@ include file="footer.jsp" %>
</html>