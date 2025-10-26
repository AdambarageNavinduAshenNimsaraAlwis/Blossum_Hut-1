<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Date" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:useBean id="currentDate" class="java.util.Date" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Payments (Admin)</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @media print {
            @page {
                size: A4 landscape;
                margin: 15mm;
            }

            body {
                background: white !important;
                margin: 0;
                padding: 0;
            }

            * {
                -webkit-print-color-adjust: exact !important;
                print-color-adjust: exact !important;
                color-adjust: exact !important;
            }

            .no-print {
                display: none !important;
            }

            .print-section {
                page-break-inside: avoid;
                margin-bottom: 20px;
            }

            .header-print {
                display: block !important;
                margin-bottom: 20px;
                border-bottom: 3px solid #333;
                padding-bottom: 15px;
            }

            .print-title {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 8px;
                color: #000;
            }

            .print-date {
                font-size: 12px;
                color: #666;
            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 15px;
                font-size: 10px;
            }

            th, td {
                border: 1px solid #333;
                padding: 8px 6px;
                text-align: left;
                vertical-align: top;
            }

            th {
                background-color: #e5e7eb !important;
                font-weight: bold;
                color: #000 !important;
                white-space: nowrap;
            }

            tbody tr:nth-child(even) {
                background-color: #f9fafb !important;
            }

            .col-txn { width: 13%; }
            .col-order { width: 13%; }
            .col-customer { width: 22%; }
            .col-date { width: 14%; }
            .col-amount { width: 10%; }
            .col-method { width: 13%; }
            .col-status { width: 10%; }

            .status-badge {
                padding: 3px 8px;
                border-radius: 4px;
                font-weight: bold;
                font-size: 9px;
                display: inline-block;
                white-space: nowrap;
            }

            .status-pending {
                background-color: #fed7aa !important;
                color: #92400e !important;
                border: 1px solid #f59e0b;
            }

            .status-approved {
                background-color: #bbf7d0 !important;
                color: #14532d !important;
                border: 1px solid #22c55e;
            }

            .status-rejected {
                background-color: #fecaca !important;
                color: #7f1d1d !important;
                border: 1px solid #ef4444;
            }

            .status-refunded {
                background-color: #bfdbfe !important;
                color: #1e3a8a !important;
                border: 1px solid #3b82f6;
            }

            .stats-table {
                margin-bottom: 20px;
                font-size: 11px;
            }

            .stats-table td, .stats-table th {
                padding: 8px 10px;
                border: 1px solid #333;
            }

            .stat-value {
                font-weight: bold;
                font-size: 12px;
            }

            h3 {
                font-size: 16px;
                font-weight: bold;
                margin-bottom: 10px;
                color: #000;
            }

            a {
                color: #000 !important;
                text-decoration: none !important;
            }

            .customer-name {
                font-weight: 600;
                font-size: 10px;
                margin-bottom: 2px;
            }

            .customer-email {
                font-size: 9px;
                color: #555;
            }

            .amount-cell {
                font-weight: 700;
                font-size: 11px;
                white-space: nowrap;
            }
        }

        @media screen {
            .header-print {
                display: none;
            }
        }
    </style>
</head>
<body class="min-h-screen bg-gradient-to-br from-purple-50 via-pink-50 to-red-50">
    <jsp:include page="/WEB-INF/jsp/header.jsp" />

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <div class="flex items-center justify-between mb-8 no-print">
            <div class="flex items-center">
                <svg class="w-10 h-10 text-purple-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"/>
                </svg>
                <h1 class="text-4xl font-bold text-gray-800">Manage Payments (Admin)</h1>
            </div>
            <button onclick="window.print()" class="inline-flex items-center px-6 py-3 bg-pink-600 hover:bg-pink-700 text-white font-medium rounded-lg shadow-md transition duration-150 ease-in-out">
                <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 17h2a2 2 0 002-2v-4a2 2 0 00-2-2H5a2 2 0 00-2 2v4a2 2 0 002 2h2m2 4h6a2 2 0 002-2v-4a2 2 0 00-2-2H9a2 2 0 00-2 2v4a2 2 0 002 2zm8-12V5a2 2 0 00-2-2H9a2 2 0 00-2 2v4h10z"/>
                </svg>
                Print PDF
            </button>
        </div>

        <c:if test="${not empty message}">
            <div class="mb-6 bg-green-50 border-l-4 border-green-400 p-4 rounded-r-lg shadow-sm no-print">
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

        <c:if test="${not empty error}">
            <div class="mb-6 bg-red-50 border-l-4 border-red-400 p-4 rounded-r-lg shadow-sm no-print">
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

        <div class="header-print">
            <div class="print-title">Payment Management Report</div>
            <div class="print-date">Generated on: <fmt:formatDate value="${currentDate}" pattern="MMM dd, yyyy HH:mm:ss"/></div>
        </div>

        <div class="mb-6 print-section">
            <h3 class="text-2xl font-bold text-gray-800 mb-4 flex items-center">
                <svg class="w-6 h-6 text-purple-600 mr-2 no-print" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"/>
                </svg>
                <span class="no-print">Payment Statistics</span>
                <span class="hidden print:inline">Payment Statistics</span>
            </h3>

            <c:set var="pendingCount" value="0"/>
            <c:set var="approvedCount" value="0"/>
            <c:set var="rejectedCount" value="0"/>
            <c:set var="refundedCount" value="0"/>
            <c:set var="totalAmount" value="0"/>

            <c:forEach var="p" items="${payments}">
                <c:if test="${p.paymentStatus == 'PENDING'}">
                    <c:set var="pendingCount" value="${pendingCount + 1}"/>
                </c:if>
                <c:if test="${p.paymentStatus == 'APPROVED'}">
                    <c:set var="approvedCount" value="${approvedCount + 1}"/>
                    <c:set var="totalAmount" value="${totalAmount + p.amount}"/>
                </c:if>
                <c:if test="${p.paymentStatus == 'REJECTED'}">
                    <c:set var="rejectedCount" value="${rejectedCount + 1}"/>
                </c:if>
                <c:if test="${p.paymentStatus == 'REFUNDED'}">
                    <c:set var="refundedCount" value="${refundedCount + 1}"/>
                </c:if>
            </c:forEach>

            <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden">
                <table class="min-w-full stats-table">
                    <tr class="bg-gradient-to-r from-purple-50 to-pink-50">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Total Payments</th>
                        <td class="px-6 py-4 text-left stat-value">${payments.size()}</td>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Pending</th>
                        <td class="px-6 py-4 text-left stat-value">${pendingCount}</td>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Approved</th>
                        <td class="px-6 py-4 text-left stat-value">${approvedCount}</td>
                    </tr>
                    <tr class="bg-white">
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Rejected</th>
                        <td class="px-6 py-4 text-left stat-value">${rejectedCount}</td>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Refunded</th>
                        <td class="px-6 py-4 text-left stat-value">${refundedCount}</td>
                        <th class="px-6 py-4 text-left text-sm font-semibold text-gray-700">Total Amount (Approved)</th>
                        <td class="px-6 py-4 text-left stat-value">$<fmt:formatNumber value="${totalAmount}" pattern="#,##0.00"/></td>
                    </tr>
                </table>
            </div>
        </div>

        <c:choose>
            <c:when test="${empty payments}">
                <div class="bg-white rounded-lg shadow-sm border border-gray-200 p-12 text-center no-print">
                    <svg class="mx-auto h-24 w-24 text-gray-400 mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z"/>
                    </svg>
                    <h3 class="text-xl font-semibold text-gray-900 mb-2">No Payment Records</h3>
                    <p class="text-gray-600">No payment records found</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bg-white rounded-lg shadow-sm border border-gray-200 overflow-hidden print-section">
                    <h3 class="px-6 py-4 text-xl font-bold text-gray-800 bg-gradient-to-r from-purple-50 to-pink-50 no-print">Payment Details</h3>
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gradient-to-r from-purple-50 to-pink-50">
                                <tr>
                                    <th class="col-txn px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Transaction ID</th>
                                    <th class="col-order px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Order Number</th>
                                    <th class="col-customer px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Customer</th>
                                    <th class="col-date px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Date</th>
                                    <th class="col-amount px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Amount</th>
                                    <th class="col-method px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Payment Method</th>
                                    <th class="col-status px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase">Status</th>
                                    <th class="px-4 py-3 text-left text-xs font-medium text-gray-700 uppercase no-print">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                <c:forEach var="payment" items="${payments}">
                                    <tr class="hover:bg-gray-50 transition duration-150">
                                        <td class="col-txn px-4 py-3 text-sm font-medium text-gray-900">
                                            <a href="${pageContext.request.contextPath}/payments/${payment.id}" class="text-purple-600 hover:text-purple-800 hover:underline no-print">
                                                ${payment.transactionId}
                                            </a>
                                            <span class="hidden print:inline">${payment.transactionId}</span>
                                        </td>
                                        <td class="col-order px-4 py-3 text-sm font-medium text-gray-900">
                                            <a href="${pageContext.request.contextPath}/orders/admin/${payment.order.id}" class="text-purple-600 hover:text-purple-800 hover:underline no-print">
                                                ${payment.order.orderNumber}
                                            </a>
                                            <span class="hidden print:inline">${payment.order.orderNumber}</span>
                                        </td>
                                        <td class="col-customer px-4 py-3 text-sm">
                                            <div class="customer-name">${payment.order.user.firstName} ${payment.order.user.lastName}</div>
                                            <div class="customer-email">${payment.order.user.email}</div>
                                        </td>
                                        <td class="col-date px-4 py-3 text-sm text-gray-900">${payment.createdAt}</td>
                                        <td class="col-amount px-4 py-3 text-sm amount-cell">$<fmt:formatNumber value="${payment.amount}" pattern="#,##0.00"/></td>
                                        <td class="col-method px-4 py-3 text-sm text-gray-900">${payment.paymentMethod}</td>
                                        <td class="col-status px-4 py-3">
                                            <c:choose>
                                                <c:when test="${payment.paymentStatus == 'PENDING'}">
                                                    <span class="status-badge status-pending">PENDING</span>
                                                </c:when>
                                                <c:when test="${payment.paymentStatus == 'APPROVED'}">
                                                    <span class="status-badge status-approved">APPROVED</span>
                                                </c:when>
                                                <c:when test="${payment.paymentStatus == 'REJECTED'}">
                                                    <span class="status-badge status-rejected">REJECTED</span>
                                                </c:when>
                                                <c:when test="${payment.paymentStatus == 'REFUNDED'}">
                                                    <span class="status-badge status-refunded">REFUNDED</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge">${payment.paymentStatus}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm no-print">
                                            <div class="flex flex-col gap-2">
                                                <a href="${pageContext.request.contextPath}/payments/${payment.id}" class="inline-flex items-center justify-center px-3 py-1.5 bg-purple-600 hover:bg-purple-700 text-white text-xs font-medium rounded transition duration-150 ease-in-out">
                                                    <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                                                    </svg>
                                                    View Details
                                                </a>
                                                <c:if test="${payment.paymentStatus == 'PENDING'}">
                                                    <form action="${pageContext.request.contextPath}/payments/admin/${payment.id}/approve" method="post" style="display: inline;">
                                                        <button type="submit" onclick="return confirm('Approve this payment?')" class="w-full inline-flex items-center justify-center px-3 py-1.5 bg-green-600 hover:bg-green-700 text-white text-xs font-medium rounded transition duration-150 ease-in-out">
                                                            <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                            </svg>
                                                            Approve
                                                        </button>
                                                    </form>
                                                    <form action="${pageContext.request.contextPath}/payments/admin/${payment.id}/reject" method="post" style="display: inline;">
                                                        <input type="hidden" name="notes" value="Rejected by admin">
                                                        <button type="submit" onclick="return confirm('Reject this payment?')" class="w-full inline-flex items-center justify-center px-3 py-1.5 bg-red-600 hover:bg-red-700 text-white text-xs font-medium rounded transition duration-150 ease-in-out">
                                                            <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                                                            </svg>
                                                            Reject
                                                        </button>
                                                    </form>
                                                </c:if>
                                                <c:if test="${payment.paymentStatus == 'APPROVED'}">
                                                    <span class="inline-flex items-center justify-center px-3 py-1.5 bg-green-100 text-green-800 text-xs font-semibold rounded">
                                                        <svg class="w-3 h-3 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                                            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                                                        </svg>
                                                        Approved
                                                    </span>
                                                </c:if>
                                                <form action="${pageContext.request.contextPath}/payments/admin/${payment.id}/delete" method="post" style="display: inline;">
                                                    <button type="submit" onclick="return confirm('Are you sure you want to delete this payment record? This action cannot be undone.')" class="w-full inline-flex items-center justify-center px-3 py-1.5 bg-gray-700 hover:bg-gray-800 text-white text-xs font-medium rounded transition duration-150 ease-in-out">
                                                        <svg class="w-3 h-3 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"/>
                                                        </svg>
                                                        Delete
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
<%@ include file="footer.jsp" %>
</html>