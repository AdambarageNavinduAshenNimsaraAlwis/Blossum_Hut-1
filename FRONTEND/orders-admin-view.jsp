<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Details - ${order.orderNumber}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-image: url('https://cdn.pixabay.com/photo/2021/04/22/17/55/flowers-6199691_1280.png');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;
        }
        .overlay {
            background-color: rgba(0, 0, 0, 0.6);
            min-height: 100vh;
        }
        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }
        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        .animate-slideIn {
            animation: slideInDown 0.5s ease-out;
        }
    </style>
</head>
<body>
<!-- Include Header -->
    <jsp:include page="/WEB-INF/jsp/header.jsp" />
    <div class="overlay">
        <div class="min-h-screen py-8 px-4 sm:px-6 lg:px-8">
            <div class="max-w-6xl mx-auto">
                <!-- Header -->
                <div class="glass-effect rounded-2xl shadow-2xl p-6 mb-6 animate-slideIn">
                    <div class="flex items-center justify-between flex-wrap gap-4">
                        <h1 class="text-4xl font-bold bg-gradient-to-r from-pink-600 to-purple-600 bg-clip-text text-transparent flex items-center gap-3">
                            <i class="fas fa-receipt text-indigo-600"></i>
                            Order Details
                        </h1>
                        <div class="flex gap-3 flex-wrap">
                            <c:choose>
                                <c:when test="${isAdmin}">
                                    <a href="${pageContext.request.contextPath}/orders/admin/all"
                                       class="px-5 py-2.5 bg-gradient-to-r from-pink-500 to-pink-600 hover:from-pink-600 hover:to-pink-700 text-white font-semibold rounded-lg shadow-lg hover:shadow-xl transition-all duration-200 flex items-center gap-2 transform hover:scale-105">
                                        <i class="fas fa-arrow-left"></i>
                                        Back to All Orders
                                    </a>
                                    <a href="${pageContext.request.contextPath}/products"
                                       class="px-5 py-2.5 bg-gradient-to-r from-pink-500 to-pink-600 hover:from-pink-600 hover:to-pink-700 text-white font-semibold rounded-lg shadow-lg hover:shadow-xl transition-all duration-200 flex items-center gap-2 transform hover:scale-105">
                                        <i class="fas fa-box"></i>
                                        Manage Products
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/orders"
                                       class="px-5 py-2.5 bg-gradient-to-r from-indigo-500 to-indigo-600 hover:from-indigo-600 hover:to-indigo-700 text-white font-semibold rounded-lg shadow-lg hover:shadow-xl transition-all duration-200 flex items-center gap-2 transform hover:scale-105">
                                        <i class="fas fa-arrow-left"></i>
                                        Back to My Orders
                                    </a>
                                    <a href="${pageContext.request.contextPath}/products/user/list"
                                       class="px-5 py-2.5 bg-gradient-to-r from-purple-500 to-purple-600 hover:from-purple-600 hover:to-purple-700 text-white font-semibold rounded-lg shadow-lg hover:shadow-xl transition-all duration-200 flex items-center gap-2 transform hover:scale-105">
                                        <i class="fas fa-shopping-bag"></i>
                                        Browse Products
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

                <!-- Messages -->
                <c:if test="${not empty message}">
                    <div class="glass-effect rounded-xl shadow-lg p-5 mb-6 border-l-4 border-green-500 animate-slideIn">
                        <div class="flex items-center">
                            <i class="fas fa-check-circle text-green-500 text-2xl mr-3"></i>
                            <p class="text-green-800 font-semibold text-lg">${message}</p>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty error}">
                    <div class="glass-effect rounded-xl shadow-lg p-5 mb-6 border-l-4 border-red-500 animate-slideIn">
                        <div class="flex items-center">
                            <i class="fas fa-exclamation-circle text-red-500 text-2xl mr-3"></i>
                            <p class="text-red-800 font-semibold text-lg">${error}</p>
                        </div>
                    </div>
                </c:if>

                <!-- Order Information -->
                <div class="glass-effect rounded-2xl shadow-2xl overflow-hidden mb-6 animate-slideIn">
                    <div class="bg-gradient-to-r from-pink-600 to-purple-600 px-6 py-4">
                        <h2 class="text-2xl font-bold text-white flex items-center gap-2">
                            <i class="fas fa-info-circle"></i>
                            Order Information
                        </h2>
                    </div>
                    <div class="p-6">
                        <div class="grid md:grid-cols-2 gap-6">
                            <div class="bg-gradient-to-br from-indigo-50 to-purple-50 rounded-xl p-5 border border-indigo-200 hover:shadow-lg transition-all duration-200">
                                <div class="flex items-center gap-3 mb-2">
                                    <i class="fas fa-hashtag text-indigo-600 text-xl"></i>
                                    <span class="text-slate-600 font-semibold">Order Number:</span>
                                </div>
                                <p class="text-2xl font-bold text-slate-800 ml-8">${order.orderNumber}</p>
                            </div>

                            <div class="bg-gradient-to-br from-blue-50 to-cyan-50 rounded-xl p-5 border border-blue-200 hover:shadow-lg transition-all duration-200">
                                <div class="flex items-center gap-3 mb-2">
                                    <i class="fas fa-calendar-alt text-blue-600 text-xl"></i>
                                    <span class="text-slate-600 font-semibold">Order Date:</span>
                                </div>
                                <p class="text-xl font-semibold text-slate-800 ml-8">${order.createdAt}</p>
                            </div>

                            <div class="bg-gradient-to-br from-purple-50 to-pink-50 rounded-xl p-5 border border-purple-200 hover:shadow-lg transition-all duration-200">
                                <div class="flex items-center gap-3 mb-2">
                                    <i class="fas fa-flag text-purple-600 text-xl"></i>
                                    <span class="text-slate-600 font-semibold">Status:</span>
                                </div>
                                <div class="ml-8">
                                    <c:choose>
                                        <c:when test="${order.status == 'PENDING'}">
                                            <span class="inline-flex items-center gap-2 px-4 py-2 rounded-full text-sm font-bold bg-orange-100 text-orange-700 border-2 border-orange-300">
                                                <i class="fas fa-clock"></i>${order.status}
                                            </span>
                                        </c:when>
                                        <c:when test="${order.status == 'CONFIRMED' || order.status == 'PREPARING'}">
                                            <span class="inline-flex items-center gap-2 px-4 py-2 rounded-full text-sm font-bold bg-blue-100 text-blue-700 border-2 border-blue-300">
                                                <i class="fas fa-check"></i>${order.status}
                                            </span>
                                        </c:when>
                                        <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                                            <span class="inline-flex items-center gap-2 px-4 py-2 rounded-full text-sm font-bold bg-purple-100 text-purple-700 border-2 border-purple-300">
                                                <i class="fas fa-truck"></i>${order.status}
                                            </span>
                                        </c:when>
                                        <c:when test="${order.status == 'DELIVERED'}">
                                            <span class="inline-flex items-center gap-2 px-4 py-2 rounded-full text-sm font-bold bg-green-100 text-green-700 border-2 border-green-300">
                                                <i class="fas fa-check-double"></i>${order.status}
                                            </span>
                                        </c:when>
                                        <c:when test="${order.status == 'CANCELLED'}">
                                            <span class="inline-flex items-center gap-2 px-4 py-2 rounded-full text-sm font-bold bg-red-100 text-red-700 border-2 border-red-300">
                                                <i class="fas fa-times"></i>${order.status}
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="inline-flex items-center gap-2 px-4 py-2 rounded-full text-sm font-bold bg-slate-100 text-slate-700 border-2 border-slate-300">
                                                ${order.status}
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <c:if test="${isAdmin}">
                                <div class="bg-gradient-to-br from-green-50 to-emerald-50 rounded-xl p-5 border border-green-200 hover:shadow-lg transition-all duration-200">
                                    <div class="flex items-center gap-3 mb-2">
                                        <i class="fas fa-user text-green-600 text-xl"></i>
                                        <span class="text-slate-600 font-semibold">Customer Name:</span>
                                    </div>
                                    <p class="text-xl font-semibold text-slate-800 ml-8">${order.user.firstName} ${order.user.lastName}</p>
                                </div>

                                <div class="bg-gradient-to-br from-yellow-50 to-orange-50 rounded-xl p-5 border border-yellow-200 hover:shadow-lg transition-all duration-200">
                                    <div class="flex items-center gap-3 mb-2">
                                        <i class="fas fa-envelope text-yellow-600 text-xl"></i>
                                        <span class="text-slate-600 font-semibold">Customer Email:</span>
                                    </div>
                                    <p class="text-lg font-semibold text-slate-800 ml-8 break-all">${order.user.email}</p>
                                </div>
                            </c:if>

                            <div class="bg-gradient-to-br from-rose-50 to-pink-50 rounded-xl p-5 border border-rose-200 hover:shadow-lg transition-all duration-200">
                                <div class="flex items-center gap-3 mb-2">
                                    <i class="fas fa-map-marker-alt text-rose-600 text-xl"></i>
                                    <span class="text-slate-600 font-semibold">Delivery Address:</span>
                                </div>
                                <p class="text-lg font-semibold text-slate-800 ml-8">${order.deliveryAddress}</p>
                            </div>

                            <div class="bg-gradient-to-br from-teal-50 to-cyan-50 rounded-xl p-5 border border-teal-200 hover:shadow-lg transition-all duration-200">
                                <div class="flex items-center gap-3 mb-2">
                                    <i class="fas fa-phone text-teal-600 text-xl"></i>
                                    <span class="text-slate-600 font-semibold">Phone Number:</span>
                                </div>
                                <p class="text-xl font-semibold text-slate-800 ml-8">${order.phoneNumber}</p>
                            </div>

                            <c:if test="${not empty order.specialInstructions}">
                                <div class="md:col-span-2 bg-gradient-to-br from-amber-50 to-orange-50 rounded-xl p-5 border border-amber-200 hover:shadow-lg transition-all duration-200">
                                    <div class="flex items-center gap-3 mb-2">
                                        <i class="fas fa-comment-dots text-amber-600 text-xl"></i>
                                        <span class="text-slate-600 font-semibold">Special Instructions:</span>
                                    </div>
                                    <p class="text-lg text-slate-800 ml-8">${order.specialInstructions}</p>
                                </div>
                            </c:if>

                            <div class="md:col-span-2 bg-gradient-to-br from-emerald-50 to-green-50 rounded-xl p-5 border-2 border-emerald-300 hover:shadow-lg transition-all duration-200">
                                <div class="flex items-center gap-3 mb-2">
                                    <i class="fas fa-dollar-sign text-emerald-600 text-2xl"></i>
                                    <span class="text-slate-600 font-semibold text-lg">Total Amount:</span>
                                </div>
                                <p class="text-3xl font-bold text-emerald-600 ml-9">Rs.<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/></p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Order Items -->
                <div class="glass-effect rounded-2xl shadow-2xl overflow-hidden mb-6 animate-slideIn">
                    <div class="bg-gradient-to-r from-purple-600 to-pink-600 px-6 py-4">
                        <h2 class="text-2xl font-bold text-white flex items-center gap-2">
                            <i class="fas fa-shopping-basket"></i>
                            Order Items
                        </h2>
                    </div>
                    <div class="overflow-x-auto">
                        <table class="w-full">
                            <thead>
                                <tr class="bg-gradient-to-r from-slate-100 to-slate-200 border-b-2 border-slate-300">
                                    <th class="px-6 py-4 text-left text-sm font-bold text-slate-700 uppercase tracking-wider">
                                        <i class="fas fa-image mr-2"></i>Image
                                    </th>
                                    <th class="px-6 py-4 text-left text-sm font-bold text-slate-700 uppercase tracking-wider">
                                        <i class="fas fa-tag mr-2"></i>Product Name
                                    </th>
                                    <th class="px-6 py-4 text-left text-sm font-bold text-slate-700 uppercase tracking-wider">
                                        <i class="fas fa-dollar-sign mr-2"></i>Price
                                    </th>
                                    <th class="px-6 py-4 text-left text-sm font-bold text-slate-700 uppercase tracking-wider">
                                        <i class="fas fa-cubes mr-2"></i>Quantity
                                    </th>
                                    <th class="px-6 py-4 text-left text-sm font-bold text-slate-700 uppercase tracking-wider">
                                        <i class="fas fa-calculator mr-2"></i>Subtotal
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-200">
                                <c:forEach var="item" items="${order.orderItems}">
                                    <tr class="hover:bg-slate-50 transition-colors duration-150">
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${not empty item.product.imagePath}">
                                                    <img src="${pageContext.request.contextPath}/${item.product.imagePath}"
                                                         alt="${item.product.name}"
                                                         class="w-20 h-20 object-cover rounded-lg shadow-md border-2 border-slate-200 hover:scale-110 transition-transform duration-200">
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="w-20 h-20 bg-gradient-to-br from-slate-200 to-slate-300 rounded-lg flex items-center justify-center border-2 border-slate-300">
                                                        <i class="fas fa-image text-slate-400 text-2xl"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4 font-semibold text-slate-800">${item.product.name}</td>
                                        <td class="px-6 py-4 text-slate-700 font-medium">Rs.<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></td>
                                        <td class="px-6 py-4">
                                            <span class="inline-flex items-center justify-center w-10 h-10 bg-indigo-100 text-indigo-700 font-bold rounded-full border-2 border-indigo-300">
                                                ${item.quantity}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 font-bold text-green-600 text-lg">Rs.<fmt:formatNumber value="${item.subtotal}" pattern="#,##0.00"/></td>
                                    </tr>
                                </c:forEach>
                                <tr class="bg-gradient-to-r from-emerald-50 to-green-50 border-t-4 border-emerald-300">
                                    <td colspan="4" class="px-6 py-5 text-right">
                                        <span class="text-xl font-bold text-slate-800 flex items-center justify-end gap-2">
                                            <i class="fas fa-receipt"></i>
                                            Total:
                                        </span>
                                    </td>
                                    <td class="px-6 py-5 text-2xl font-bold text-emerald-600">
                                        Rs.<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Actions -->
                <div class="glass-effect rounded-2xl shadow-2xl p-6 animate-slideIn">
                    <c:if test="${!isAdmin && (order.status == 'PENDING' || order.status == 'CONFIRMED')}">
                        <div class="flex justify-center">
                            <form action="${pageContext.request.contextPath}/orders/${order.id}/cancel"
                                  method="post"
                                  onsubmit="return confirm('Are you sure you want to cancel this order?');">
                                <button type="submit"
                                        class="px-8 py-4 bg-gradient-to-r from-red-500 to-rose-600 hover:from-red-600 hover:to-rose-700 text-white text-lg font-bold rounded-xl shadow-lg hover:shadow-2xl transition-all duration-200 transform hover:scale-105 flex items-center gap-3">
                                    <i class="fas fa-times-circle text-2xl"></i>
                                    Cancel Order
                                </button>
                            </form>
                        </div>
                    </c:if>

                    <c:if test="${isAdmin}">
                        <div class="bg-gradient-to-r from-indigo-50 to-purple-50 rounded-xl p-6 border-2 border-indigo-200">
                            <h3 class="text-2xl font-bold text-slate-800 mb-4 flex items-center gap-2">
                                <i class="fas fa-edit text-indigo-600"></i>
                                Update Order Status
                            </h3>
                            <form action="${pageContext.request.contextPath}/orders/admin/${order.id}/updateStatus"
                                  method="post"
                                  class="flex flex-wrap gap-4 items-end">
                                <div class="flex-1 min-w-[250px]">
                                    <label class="block text-sm font-bold text-slate-700 mb-2">
                                        <i class="fas fa-flag mr-1"></i>
                                        Select New Status
                                    </label>
                                    <select name="status"
                                            class="w-full px-4 py-3 border-2 border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-all duration-200 text-lg font-semibold">
                                        <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>⏳ Pending</option>
                                        <option value="CONFIRMED" ${order.status == 'CONFIRMED' ? 'selected' : ''}>✅ Confirmed</option>
                                        <option value="PREPARING" ${order.status == 'PREPARING' ? 'selected' : ''}>👨‍🍳 Preparing</option>
                                        <option value="OUT_FOR_DELIVERY" ${order.status == 'OUT_FOR_DELIVERY' ? 'selected' : ''}>🚚 Out for Delivery</option>
                                        <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>✔️ Delivered</option>
                                        <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>❌ Cancelled</option>
                                    </select>
                                </div>
                                <button type="submit"
                                        class="px-8 py-3 bg-gradient-to-r from-pink-500 to-purple-600 hover:from-indigo-600 hover:to-purple-700 text-white text-lg font-bold rounded-lg shadow-lg hover:shadow-xl transition-all duration-200 transform hover:scale-105 flex items-center gap-2">
                                    <i class="fas fa-sync-alt"></i>
                                    Update Status
                                </button>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</body>
<%@ include file="footer.jsp" %>
</html>