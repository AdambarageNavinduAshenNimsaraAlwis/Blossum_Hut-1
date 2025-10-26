<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html class="h-full">
<head>
    <meta charset="UTF-8">
    <title>Order Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
        .background-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: url('https://cdn.pixabay.com/photo/2016/05/20/16/59/flowers-1405552_1280.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            z-index: -2;
        }
        .background-overlay::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            z-index: -1;
        }
        .card-hover {
            transition: all 0.3s ease;
        }
        .card-hover:hover {
            transform: translateY(-2px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.3);
        }
        .status-badge {
            animation: fadeIn 0.5s ease-in;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: scale(0.9); }
            to { opacity: 1; transform: scale(1); }
        }
        .table-row {
            transition: background-color 0.2s ease;
        }
        .table-row:hover {
            background-color: rgba(99, 102, 241, 0.05);
        }
        .info-row {
            transition: all 0.2s ease;
        }
        .info-row:hover {
            background-color: rgba(249, 250, 251, 0.8);
        }
    </style>
</head>
<body class="h-full flex flex-col">
<!-- Include Header -->
    <jsp:include page="/WEB-INF/jsp/header.jsp" />
    <!-- Background with Overlay -->
    <div class="background-overlay"></div>

    <!-- Header Section -->
    <div class="bg-white/95 backdrop-blur-sm shadow-lg border-b border-gray-200 sticky top-0 z-50">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6">
            <div class="flex items-center justify-between">
                <h1 class="text-3xl font-bold text-gray-900 tracking-tight flex items-center">
                    <svg class="w-8 h-8 mr-3 text-indigo-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                    </svg>
                    Order Details
                </h1>
                <a href="${pageContext.request.contextPath}/orders"
                   class="inline-flex items-center px-5 py-2.5 bg-gray-700 hover:bg-gray-800 text-white font-medium rounded-lg transition-all duration-200 shadow-md hover:shadow-lg">
                    <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"></path>
                    </svg>
                    Back to Orders
                </a>
            </div>
        </div>
    </div>

    <!-- Main Content -->
    <div class="flex-grow max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 w-full">
        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="mb-6 bg-green-50/95 backdrop-blur-sm border-l-4 border-green-500 rounded-r-lg p-4 shadow-lg status-badge">
                <div class="flex items-center">
                    <svg class="w-6 h-6 text-green-500 mr-3 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <p class="text-green-800 font-medium">${message}</p>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="mb-6 bg-red-50/95 backdrop-blur-sm border-l-4 border-red-500 rounded-r-lg p-4 shadow-lg status-badge">
                <div class="flex items-center">
                    <svg class="w-6 h-6 text-red-500 mr-3 flex-shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                    </svg>
                    <p class="text-red-800 font-medium">${error}</p>
                </div>
            </div>
        </c:if>

        <!-- Order Information Card -->
        <div class="mb-8">
            <div class="bg-white/95 backdrop-blur-sm rounded-xl shadow-xl overflow-hidden card-hover">
                <div class="bg-gradient-to-r from-pink-600 to-purple-600 px-6 py-4">
                    <h2 class="text-2xl font-bold text-white flex items-center">
                        <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                        </svg>
                        Order Information
                    </h2>
                </div>
                <div class="p-6">
                    <table class="min-w-full">
                        <tbody class="divide-y divide-gray-200">
                            <tr class="info-row">
                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50/50 w-1/3">Field</th>
                                <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50/50">Value</th>
                            </tr>
                            <tr class="info-row">
                                <td class="px-6 py-4 text-sm font-medium text-gray-600">Order Number</td>
                                <td class="px-6 py-4 text-sm text-gray-900 font-semibold">${order.orderNumber}</td>
                            </tr>
                            <tr class="info-row">
                                <td class="px-6 py-4 text-sm font-medium text-gray-600">Order Date</td>
                                <td class="px-6 py-4 text-sm text-gray-900">${order.createdAt}</td>
                            </tr>
                            <tr class="info-row">
                                <td class="px-6 py-4 text-sm font-medium text-gray-600">Status</td>
                                <td class="px-6 py-4">
                                    <span class="px-4 py-2 inline-flex text-sm font-bold rounded-full bg-indigo-100 text-indigo-800">
                                        ${order.status.displayName}
                                    </span>
                                </td>
                            </tr>
                            <tr class="info-row">
                                <td class="px-6 py-4 text-sm font-medium text-gray-600">Delivery Address</td>
                                <td class="px-6 py-4 text-sm text-gray-900">${order.deliveryAddress}</td>
                            </tr>
                            <tr class="info-row">
                                <td class="px-6 py-4 text-sm font-medium text-gray-600">Phone Number</td>
                                <td class="px-6 py-4 text-sm text-gray-900 font-medium">${order.phoneNumber}</td>
                            </tr>
                            <tr class="info-row">
                                <td class="px-6 py-4 text-sm font-medium text-gray-600">Special Instructions</td>
                                <td class="px-6 py-4 text-sm text-gray-900">${order.specialInstructions}</td>
                            </tr>
                            <tr class="info-row bg-indigo-50/50">
                                <td class="px-6 py-4 text-sm font-bold text-gray-900">Total Amount</td>
                                <td class="px-6 py-4 text-xl font-bold text-indigo-600">$<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Payment Information Card -->
        <div class="mb-8">
            <div class="bg-white/95 backdrop-blur-sm rounded-xl shadow-xl overflow-hidden card-hover">
                <div class="bg-gradient-to-r from-emerald-600 to-teal-600 px-6 py-4">
                    <h2 class="text-2xl font-bold text-white flex items-center">
                        <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"></path>
                        </svg>
                        Payment Information
                    </h2>
                </div>
                <div class="p-6">
                    <c:choose>
                        <c:when test="${not empty order.payment}">
                            <table class="min-w-full">
                                <tbody class="divide-y divide-gray-200">
                                    <tr class="info-row">
                                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 w-1/3">Transaction ID:</th>
                                        <td class="px-6 py-4">
                                            <a href="${pageContext.request.contextPath}/payments/${order.payment.id}"
                                               class="text-indigo-600 hover:text-indigo-800 font-semibold underline transition-colors duration-200">
                                                ${order.payment.transactionId}
                                            </a>
                                        </td>
                                    </tr>
                                    <tr class="info-row">
                                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Payment Method:</th>
                                        <td class="px-6 py-4 text-sm text-gray-900 font-medium">${order.payment.paymentMethod}</td>
                                    </tr>
                                    <tr class="info-row">
                                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Payment Status:</th>
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${order.payment.paymentStatus == 'PENDING'}">
                                                    <span class="px-4 py-2 inline-flex text-sm font-bold rounded-full bg-orange-100 text-orange-700">PENDING</span>
                                                </c:when>
                                                <c:when test="${order.payment.paymentStatus == 'APPROVED'}">
                                                    <span class="px-4 py-2 inline-flex text-sm font-bold rounded-full bg-green-100 text-green-700">APPROVED</span>
                                                </c:when>
                                                <c:when test="${order.payment.paymentStatus == 'REJECTED'}">
                                                    <span class="px-4 py-2 inline-flex text-sm font-bold rounded-full bg-red-100 text-red-700">REJECTED</span>
                                                </c:when>
                                                <c:when test="${order.payment.paymentStatus == 'REFUNDED'}">
                                                    <span class="px-4 py-2 inline-flex text-sm font-bold rounded-full bg-blue-100 text-blue-700">REFUNDED</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-4 py-2 inline-flex text-sm font-bold rounded-full bg-gray-100 text-gray-700">${order.payment.paymentStatus}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                    <tr class="info-row bg-emerald-50/50">
                                        <th class="px-6 py-4 text-left text-sm font-bold text-gray-900">Amount Paid:</th>
                                        <td class="px-6 py-4 text-xl font-bold text-emerald-600">$<fmt:formatNumber value="${order.payment.amount}" pattern="#,##0.00"/></td>
                                    </tr>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="text-center py-8">
                                <svg class="w-16 h-16 mx-auto text-red-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4m0 4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                                </svg>
                                <p class="text-red-600 font-semibold text-lg mb-6">Payment not submitted yet.</p>
                                <a href="${pageContext.request.contextPath}/payments/order/${order.id}">
                                    <button type="button" class="inline-flex items-center px-6 py-3 bg-emerald-600 hover:bg-emerald-700 text-white font-semibold rounded-lg transition-all duration-200 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"></path>
                                        </svg>
                                        Submit Payment
                                    </button>
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- Order Items Card -->
        <div class="mb-8">
            <div class="bg-white/95 backdrop-blur-sm rounded-xl shadow-xl overflow-hidden card-hover">
                <div class="bg-gradient-to-r from-purple-600 to-pink-600 px-6 py-4">
                    <h2 class="text-2xl font-bold text-white flex items-center">
                        <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"></path>
                        </svg>
                        Order Items
                    </h2>
                </div>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50/90">
                            <tr>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">Image</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">Product</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">Price</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">Quantity</th>
                                <th class="px-6 py-4 text-left text-xs font-semibold text-gray-700 uppercase tracking-wider">Subtotal</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white/95 divide-y divide-gray-200">
                            <c:forEach var="item" items="${order.orderItems}">
                                <tr class="table-row">
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <c:choose>
                                            <c:when test="${not empty item.product.imagePath}">
                                                <div class="flex-shrink-0 h-16 w-16 rounded-lg overflow-hidden shadow-md ring-2 ring-gray-200">
                                                    <img src="${pageContext.request.contextPath}/${item.product.imagePath}"
                                                         alt="${item.product.name}" class="h-full w-full object-cover">
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="flex-shrink-0 h-16 w-16 bg-gray-100 rounded-lg flex items-center justify-center shadow-md">
                                                    <svg class="w-8 h-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                                    </svg>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="px-6 py-4">
                                        <div class="text-sm font-semibold text-gray-900">${item.product.name}</div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm text-gray-900 font-medium">$<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></div>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <span class="px-3 py-1 inline-flex text-sm font-semibold rounded-full bg-gray-100 text-gray-800">
                                            ${item.quantity}
                                        </span>
                                    </td>
                                    <td class="px-6 py-4 whitespace-nowrap">
                                        <div class="text-sm font-bold text-gray-900">$<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr class="bg-gradient-to-r from-purple-50 to-pink-50">
                                <td colspan="4" class="px-6 py-5 text-right">
                                    <span class="text-lg font-bold text-gray-900">Total:</span>
                                </td>
                                <td class="px-6 py-5 whitespace-nowrap">
                                    <span class="text-2xl font-bold text-purple-600">$<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Cancel Order Section -->
        <c:if test="${order.status != 'DELIVERED' && order.status != 'CANCELLED'}">
            <div class="flex justify-center">
                <form action="${pageContext.request.contextPath}/orders/${order.id}/cancel" method="post"
                      onsubmit="return confirm('Are you sure you want to cancel this order?')"
                      class="w-full max-w-md">
                    <button type="submit"
                            class="w-full inline-flex items-center justify-center px-6 py-3 bg-red-600 hover:bg-red-700 text-white font-bold rounded-lg transition-all duration-200 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                        Cancel Order
                    </button>
                </form>
            </div>
        </c:if>
    </div>
    <%@ include file="footer.jsp" %>
</body>
</html>