<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Details - ${payment.transactionId}</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen bg-gradient-to-br from-indigo-50 via-purple-50 to-pink-50">
<!-- Include Header -->
    <jsp:include page="/WEB-INF/jsp/header.jsp" />
    <!-- Main Content -->
    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Page Title -->
        <div class="flex items-center mb-8">
            <svg class="w-10 h-10 text-indigo-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
            </svg>
            <h1 class="text-4xl font-bold text-gray-800">Payment Details</h1>
        </div>

        <!-- Success Message -->
        <c:if test="${not empty message}">
            <div class="mb-6 bg-green-50 border-l-4 border-green-400 p-4 rounded-r-lg shadow-sm">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <svg class="h-5 w-5 text-green-400" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium text-green-800">${message}</p>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Error Message -->
        <c:if test="${not empty error}">
            <div class="mb-6 bg-red-50 border-l-4 border-red-400 p-4 rounded-r-lg shadow-sm">
                <div class="flex">
                    <div class="flex-shrink-0">
                        <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                        </svg>
                    </div>
                    <div class="ml-3">
                        <p class="text-sm font-medium text-red-800">${error}</p>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Navigation Links -->
        <div class="mb-6 bg-white rounded-lg shadow-sm p-4 border border-gray-200">
            <div class="flex flex-wrap gap-3 items-center">
                <c:choose>
                    <c:when test="${isAdmin}">
                        <a href="${pageContext.request.contextPath}/payments/admin/all" class="inline-flex items-center px-4 py-2 bg-pink-600 hover:bg-pink-700 text-white text-sm font-medium rounded-lg transition duration-150 ease-in-out">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                            </svg>
                            Back to All Payments
                        </a>
                        <span class="text-gray-300">|</span>
                        <a href="${pageContext.request.contextPath}/orders/admin/all" class="inline-flex items-center px-4 py-2 bg-purple-600 hover:bg-purple-700 text-white text-sm font-medium rounded-lg transition duration-150 ease-in-out">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                            </svg>
                            Manage Orders
                        </a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/payments/my" class="inline-flex items-center px-4 py-2 bg-indigo-600 hover:bg-indigo-700 text-white text-sm font-medium rounded-lg transition duration-150 ease-in-out">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                            </svg>
                            My Payments
                        </a>
                        <span class="text-gray-300">|</span>
                        <a href="${pageContext.request.contextPath}/orders/${payment.order.id}" class="inline-flex items-center px-4 py-2 bg-pink-600 hover:bg-pink-700 text-white text-sm font-medium rounded-lg transition duration-150 ease-in-out">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                            </svg>
                            View Order
                        </a>
                        <span class="text-gray-300">|</span>
                        <a href="${pageContext.request.contextPath}/orders" class="inline-flex items-center px-4 py-2 bg-purple-600 hover:bg-purple-700 text-white text-sm font-medium rounded-lg transition duration-150 ease-in-out">
                            <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                            </svg>
                            My Orders
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <!-- Payment Information Card -->
        <div class="mb-6">
            <h2 class="text-2xl font-bold text-gray-800 mb-4 flex items-center">
                <svg class="w-6 h-6 text-indigo-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                </svg>
                Payment Information
            </h2>
            <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                <table class="min-w-full divide-y divide-gray-200">
                    <tr class="hover:bg-gray-50 transition duration-150">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50 w-1/4">Transaction ID:</th>
                        <td class="px-6 py-4 text-sm text-gray-900">
                            <span class="font-bold text-indigo-600">${payment.transactionId}</span>
                        </td>
                    </tr>
                    <tr class="hover:bg-gray-50 transition duration-150">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Payment Date:</th>
                        <td class="px-6 py-4 text-sm text-gray-900">${payment.createdAt}</td>
                    </tr>
                    <tr class="hover:bg-gray-50 transition duration-150">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Payment Status:</th>
                        <td class="px-6 py-4 text-sm">
                            <c:choose>
                                <c:when test="${payment.paymentStatus == 'PENDING'}">
                                    <span class="inline-flex items-center px-4 py-2 rounded-full text-sm font-semibold bg-orange-100 text-orange-800">
                                        <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm1-12a1 1 0 10-2 0v4a1 1 0 00.293.707l2.828 2.829a1 1 0 101.415-1.415L11 9.586V6z" clip-rule="evenodd"/>
                                        </svg>
                                        PENDING
                                    </span>
                                </c:when>
                                <c:when test="${payment.paymentStatus == 'APPROVED'}">
                                    <span class="inline-flex items-center px-4 py-2 rounded-full text-sm font-semibold bg-green-100 text-green-800">
                                        <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                                        </svg>
                                        APPROVED
                                    </span>
                                </c:when>
                                <c:when test="${payment.paymentStatus == 'REJECTED'}">
                                    <span class="inline-flex items-center px-4 py-2 rounded-full text-sm font-semibold bg-red-100 text-red-800">
                                        <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                                        </svg>
                                        REJECTED
                                    </span>
                                </c:when>
                                <c:when test="${payment.paymentStatus == 'REFUNDED'}">
                                    <span class="inline-flex items-center px-4 py-2 rounded-full text-sm font-semibold bg-blue-100 text-blue-800">
                                        <svg class="w-4 h-4 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                            <path fill-rule="evenodd" d="M4 2a1 1 0 011 1v2.101a7.002 7.002 0 0111.601 2.566 1 1 0 11-1.885.666A5.002 5.002 0 005.999 7H9a1 1 0 010 2H4a1 1 0 01-1-1V3a1 1 0 011-1zm.008 9.057a1 1 0 011.276.61A5.002 5.002 0 0014.001 13H11a1 1 0 110-2h5a1 1 0 011 1v5a1 1 0 11-2 0v-2.101a7.002 7.002 0 01-11.601-2.566 1 1 0 01.61-1.276z" clip-rule="evenodd"/>
                                        </svg>
                                        REFUNDED
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    <span class="font-bold">${payment.paymentStatus}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <tr class="hover:bg-gray-50 transition duration-150">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Payment Method:</th>
                        <td class="px-6 py-4 text-sm text-gray-900">${payment.paymentMethod}</td>
                    </tr>
                    <c:if test="${not empty payment.cardHolderName}">
                        <tr class="hover:bg-gray-50 transition duration-150">
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Card Holder Name:</th>
                            <td class="px-6 py-4 text-sm text-gray-900">${payment.cardHolderName}</td>
                        </tr>
                    </c:if>
                    <c:if test="${not empty payment.cardNumber}">
                        <tr class="hover:bg-gray-50 transition duration-150">
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Card Number:</th>
                            <td class="px-6 py-4 text-sm text-gray-900">${payment.cardNumber}</td>
                        </tr>
                    </c:if>
                    <tr class="hover:bg-gray-50 transition duration-150 bg-indigo-50">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Amount:</th>
                        <td class="px-6 py-4">
                            <span class="text-2xl font-bold text-indigo-600">$<fmt:formatNumber value="${payment.amount}" pattern="#,##0.00"/></span>
                        </td>
                    </tr>
                    <c:if test="${payment.paymentStatus == 'APPROVED' && not empty payment.approvedAt}">
                        <tr class="hover:bg-gray-50 transition duration-150">
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Approved At:</th>
                            <td class="px-6 py-4 text-sm text-gray-900">${payment.approvedAt}</td>
                        </tr>
                    </c:if>
                    <c:if test="${not empty payment.approvedBy}">
                        <tr class="hover:bg-gray-50 transition duration-150">
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Processed By:</th>
                            <td class="px-6 py-4 text-sm text-gray-900">${payment.approvedBy}</td>
                        </tr>
                    </c:if>
                    <c:if test="${not empty payment.paymentNotes}">
                        <tr class="hover:bg-gray-50 transition duration-150">
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Notes:</th>
                            <td class="px-6 py-4 text-sm text-gray-900">${payment.paymentNotes}</td>
                        </tr>
                    </c:if>
                </table>
            </div>
        </div>

        <!-- Order Information Card -->
        <div class="mb-6">
            <h2 class="text-2xl font-bold text-gray-800 mb-4 flex items-center">
                <svg class="w-6 h-6 text-purple-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 11V7a4 4 0 00-8 0v4M5 9h14l1 12H4L5 9z"/>
                </svg>
                Order Information
            </h2>
            <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                <table class="min-w-full divide-y divide-gray-200">
                    <tr class="hover:bg-gray-50 transition duration-150">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50 w-1/4">Order Number:</th>
                        <td class="px-6 py-4 text-sm">
                            <a href="${pageContext.request.contextPath}/orders/admin/${payment.order.id}" class="text-purple-600 hover:text-purple-800 font-semibold hover:underline">
                                ${payment.order.orderNumber}
                            </a>
                        </td>
                    </tr>
                    <tr class="hover:bg-gray-50 transition duration-150">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Order Date:</th>
                        <td class="px-6 py-4 text-sm text-gray-900">${payment.order.createdAt}</td>
                    </tr>
                    <tr class="hover:bg-gray-50 transition duration-150">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Order Status:</th>
                        <td class="px-6 py-4 text-sm">
                            <c:choose>
                                <c:when test="${payment.order.status == 'PENDING'}">
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-orange-100 text-orange-800">${payment.order.status}</span>
                                </c:when>
                                <c:when test="${payment.order.status == 'CONFIRMED' || payment.order.status == 'PREPARING'}">
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-blue-100 text-blue-800">${payment.order.status}</span>
                                </c:when>
                                <c:when test="${payment.order.status == 'OUT_FOR_DELIVERY'}">
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-purple-100 text-purple-800">${payment.order.status}</span>
                                </c:when>
                                <c:when test="${payment.order.status == 'DELIVERED'}">
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-green-100 text-green-800">${payment.order.status}</span>
                                </c:when>
                                <c:when test="${payment.order.status == 'CANCELLED'}">
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-red-100 text-red-800">${payment.order.status}</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-semibold bg-gray-100 text-gray-800">${payment.order.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                    <c:if test="${isAdmin}">
                        <tr class="hover:bg-gray-50 transition duration-150">
                            <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Customer:</th>
                            <td class="px-6 py-4 text-sm text-gray-900">${payment.order.user.firstName} ${payment.order.user.lastName} (${payment.order.user.email})</td>
                        </tr>
                    </c:if>
                    <tr class="hover:bg-gray-50 transition duration-150">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Delivery Address:</th>
                        <td class="px-6 py-4 text-sm text-gray-900">${payment.order.deliveryAddress}</td>
                    </tr>
                    <tr class="hover:bg-gray-50 transition duration-150">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700 bg-gray-50">Phone Number:</th>
                        <td class="px-6 py-4 text-sm text-gray-900">${payment.order.phoneNumber}</td>
                    </tr>
                </table>
            </div>
        </div>

        <!-- Admin Payment Actions -->
        <c:if test="${isAdmin && payment.paymentStatus == 'PENDING'}">
            <div class="mb-6">
                <h3 class="text-2xl font-bold text-gray-800 mb-4 flex items-center">
                    <svg class="w-6 h-6 text-indigo-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6V4m0 2a2 2 0 100 4m0-4a2 2 0 110 4m-6 8a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4m6 6v10m6-2a2 2 0 100-4m0 4a2 2 0 110-4m0 4v2m0-6V4"/>
                    </svg>
                    Payment Actions
                </h3>
                <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                    <!-- Approve Payment Form -->
                    <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                        <form action="${pageContext.request.contextPath}/payments/admin/${payment.id}/approve" method="post">
                            <div class="flex items-center mb-4">
                                <svg class="w-6 h-6 text-green-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                <h4 class="text-lg font-semibold text-gray-800">Approve Payment</h4>
                            </div>
                            <div class="mb-4">
                                <label class="block text-sm font-medium text-gray-700 mb-2">Notes (Optional):</label>
                                <textarea name="notes" rows="3" class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-green-500 focus:border-transparent resize-none" placeholder="Add any notes about this approval..."></textarea>
                            </div>
                            <button type="submit" onclick="return confirm('Approve this payment?')" class="w-full inline-flex items-center justify-center px-6 py-3 bg-green-600 hover:bg-green-700 text-white font-medium rounded-lg transition duration-150 ease-in-out">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Approve Payment
                            </button>
                        </form>
                    </div>

                    <!-- Reject Payment Form -->
                    <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-6">
                        <form action="${pageContext.request.contextPath}/payments/admin/${payment.id}/reject" method="post">
                            <div class="flex items-center mb-4">
                                <svg class="w-6 h-6 text-red-600 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                </svg>
                                <h4 class="text-lg font-semibold text-gray-800">Reject Payment</h4>
                            </div>
                            <div class="mb-4">
                                <label class="block text-sm font-medium text-gray-700 mb-2">Rejection Reason (Required):</label>
                                <textarea name="notes" rows="3" required class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500 focus:border-transparent resize-none" placeholder="Explain why this payment is being rejected..."></textarea>
                            </div>
                            <button type="submit" onclick="return confirm('Reject this payment? This will cancel the order.')" class="w-full inline-flex items-center justify-center px-6 py-3 bg-red-600 hover:bg-red-700 text-white font-medium rounded-lg transition duration-150 ease-in-out">
                                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                                </svg>
                                Reject Payment
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </c:if>
    </div>
</body>
<%@ include file="footer.jsp" %>
</html>