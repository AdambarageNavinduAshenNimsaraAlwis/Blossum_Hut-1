<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage All Orders</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        // Generate and download CSV file
        function exportToCSV() {
            if (confirm("Are you sure you want to export all orders to CSV?")) {
                // Get table data
                const table = document.getElementById("ordersTable");
                const rows = table.querySelectorAll("tr");
                let csvContent = "data:text/csv;charset=utf-8,";

                // Add headers
                const headers = [];
                const headerCells = rows[0].querySelectorAll("th");
                headerCells.forEach(cell => {
                    // Exclude the last column (Actions)
                    if (cell.textContent.trim() !== "Actions") {
                        headers.push('"' + cell.textContent.trim().replace(/"/g, '""') + '"');
                    }
                });
                csvContent += headers.join(",") + "\n";

                // Add data rows
                for (let i = 1; i < rows.length; i++) {
                    const cells = rows[i].querySelectorAll("td");
                    const rowData = [];

                    // Get order number from link
                    const orderNumberLink = cells[0].querySelector("a");
                    const orderNumber = orderNumberLink ? orderNumberLink.textContent.trim() : cells[0].textContent.trim();
                    rowData.push('"' + orderNumber.replace(/"/g, '""') + '"');

                    // Customer Email
                    rowData.push('"' + cells[1].textContent.trim().replace(/"/g, '""') + '"');

                    // Customer Name
                    rowData.push('"' + cells[2].textContent.trim().replace(/"/g, '""') + '"');

                    // Date
                    rowData.push('"' + cells[3].textContent.trim().replace(/"/g, '""') + '"');

                    // Total Amount
                    rowData.push('"' + cells[4].textContent.trim().replace(/"/g, '""') + '"');

                    // Status
                    rowData.push('"' + cells[5].textContent.trim().replace(/"/g, '""') + '"');

                    // Delivery Address
                    rowData.push('"' + cells[6].textContent.trim().replace(/"/g, '""') + '"');

                    // Phone
                    rowData.push('"' + cells[7].textContent.trim().replace(/"/g, '""') + '"');

                    csvContent += rowData.join(",") + "\n";
                }

                // Create download link
                const encodedUri = encodeURI(csvContent);
                const link = document.createElement("a");
                link.setAttribute("href", encodedUri);
                const currentDate = new Date().toISOString().split('T')[0];
                link.setAttribute("download", "orders_" + currentDate + ".csv");
                document.body.appendChild(link);
                link.click();
                document.body.removeChild(link);
            }
        }

        // Print table
        function printOrders() {
            const printWindow = window.open('', '', 'height=600,width=800');
            const table = document.getElementById("ordersTable");
            const currentDate = new Date().toLocaleString();
            const totalOrders = document.querySelectorAll('#ordersTable tbody tr').length;
            const htmlContent = `
                <html>
                <head>
                    <title>Orders Report</title>
                    <style>
                        body { font-family: Arial, sans-serif; margin: 20px; }
                        h1 { text-align: center; }
                        table { width: 100%; border-collapse: collapse; }
                        th, td { border: 1px solid #000; padding: 8px; text-align: left; }
                        th { background-color: #f2f2f2; font-weight: bold; }
                        tr:nth-child(even) { background-color: #f9f9f9; }
                        .page-break { page-break-after: always; }
                    </style>
                </head>
                <body>
                    <h1>Orders Report</h1>
                    <p><strong>Generated on:</strong> ${currentDate}</p>
                    <p><strong>Total Orders:</strong> ${totalOrders}</p>
                    ${table.outerHTML}
                </body>
                </html>
            `;
            printWindow.document.write(htmlContent);
            printWindow.document.close();
            printWindow.print();
        }

        // Filter orders by status
        function filterByStatus() {
            const statusFilter = document.getElementById("statusFilter").value;
            const table = document.getElementById("ordersTable");
            const rows = table.querySelectorAll("tbody tr");
            let visibleCount = 0;

            rows.forEach(row => {
                const statusCell = row.querySelector("td:nth-child(6)");
                const status = statusCell.textContent.trim();

                if (statusFilter === "" || status === statusFilter) {
                    row.style.display = "";
                    visibleCount++;
                } else {
                    row.style.display = "none";
                }
            });

            document.getElementById("visibleOrdersCount").textContent = visibleCount;
        }

        // Search orders
        function searchOrders() {
            const searchInput = document.getElementById("searchInput").value.toLowerCase();
            const table = document.getElementById("ordersTable");
            const rows = table.querySelectorAll("tbody tr");
            let visibleCount = 0;

            rows.forEach(row => {
                const cells = row.querySelectorAll("td");
                let found = false;

                cells.forEach(cell => {
                    if (cell.textContent.toLowerCase().includes(searchInput)) {
                        found = true;
                    }
                });

                if (found || searchInput === "") {
                    row.style.display = "";
                    if (searchInput === "") visibleCount++;
                } else {
                    row.style.display = "none";
                }
            });

            if (searchInput !== "") {
                visibleCount = Array.from(rows).filter(row => row.style.display !== "none").length;
            } else {
                visibleCount = rows.length;
            }

            document.getElementById("visibleOrdersCount").textContent = visibleCount;
        }

        // Reset filters
        function resetFilters() {
            document.getElementById("searchInput").value = "";
            document.getElementById("statusFilter").value = "";
            const table = document.getElementById("ordersTable");
            const rows = table.querySelectorAll("tbody tr");
            rows.forEach(row => {
                row.style.display = "";
            });
            document.getElementById("visibleOrdersCount").textContent = rows.length;
        }

        // Initialize
        document.addEventListener("DOMContentLoaded", function() {
            const rows = document.querySelectorAll("#ordersTable tbody tr");
            document.getElementById("visibleOrdersCount").textContent = rows.length;
        });
    </script>
</head>
<body class="bg-gradient-to-br from-slate-50 to-slate-100 min-h-screen">
<!-- Include Header -->
    <jsp:include page="/WEB-INF/jsp/header.jsp" />

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <!-- Page Title -->
        <div class="mb-8">
            <h1 class="text-4xl font-bold text-slate-800 flex items-center gap-3">
                <i class="fas fa-shopping-cart text-indigo-600"></i>
                Manage All Orders
                <span class="text-sm font-semibold bg-gradient-to-r from-pink-600 to-pink-600 text-white px-4 py-1.5 rounded-full shadow-md">Admin Panel</span>
            </h1>
        </div>

        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="mb-6 bg-green-50 border-l-4 border-green-500 p-4 rounded-lg shadow-sm animate-pulse">
                <div class="flex items-center">
                    <i class="fas fa-check-circle text-green-500 text-xl mr-3"></i>
                    <p class="text-green-800 font-semibold">${message}</p>
                </div>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="mb-6 bg-red-50 border-l-4 border-red-500 p-4 rounded-lg shadow-sm animate-pulse">
                <div class="flex items-center">
                    <i class="fas fa-exclamation-circle text-red-500 text-xl mr-3"></i>
                    <p class="text-red-800 font-semibold">${error}</p>
                </div>
            </div>
        </c:if>

        <!-- Export and Print Options -->
        <div class="bg-white rounded-xl shadow-lg p-6 mb-6 border border-slate-200">
            <h3 class="text-xl font-bold text-slate-800 mb-4 flex items-center gap-2">
                <i class="fas fa-download text-indigo-600"></i>
                Export & Print Options
            </h3>
            <div class="flex gap-3">
                <button onclick="exportToCSV()"
                        class="px-6 py-3 bg-gradient-to-r from-green-500 to-emerald-600 hover:from-green-600 hover:to-emerald-700 text-white font-semibold rounded-lg shadow-md hover:shadow-xl transition-all duration-200 flex items-center gap-2 transform hover:scale-105">
                    <i class="fas fa-file-csv text-xl"></i>
                    Export to CSV
                </button>
            </div>
        </div>

        <!-- Filter and Search Options -->
        <div class="bg-white rounded-xl shadow-lg p-6 mb-6 border border-slate-200">
            <h3 class="text-xl font-bold text-slate-800 mb-4 flex items-center gap-2">
                <i class="fas fa-filter text-indigo-600"></i>
                Filter & Search
            </h3>
            <div class="grid md:grid-cols-2 gap-4 mb-4">
                <div>
                    <label for="searchInput" class="block text-sm font-semibold text-slate-700 mb-2">
                        <i class="fas fa-search mr-1"></i>
                        Search Orders
                    </label>
                    <input type="text"
                           id="searchInput"
                           placeholder="Search by order number, email, name, or phone..."
                           oninput="searchOrders()"
                           class="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-all duration-200 shadow-sm">
                </div>
                <div>
                    <label for="statusFilter" class="block text-sm font-semibold text-slate-700 mb-2">
                        <i class="fas fa-tag mr-1"></i>
                        Filter by Status
                    </label>
                    <div class="flex gap-2">
                        <select id="statusFilter"
                                onchange="filterByStatus()"
                                class="flex-1 px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 transition-all duration-200 shadow-sm">
                            <option value="">All Status</option>
                            <option value="PENDING">Pending</option>
                            <option value="CONFIRMED">Confirmed</option>
                            <option value="PREPARING">Preparing</option>
                            <option value="OUT_FOR_DELIVERY">Out for Delivery</option>
                            <option value="DELIVERED">Delivered</option>
                            <option value="CANCELLED">Cancelled</option>
                        </select>
                        <button onclick="resetFilters()"
                                class="px-6 py-3 bg-gradient-to-r from-red-500 to-rose-600 hover:from-red-600 hover:to-rose-700 text-white font-semibold rounded-lg shadow-md hover:shadow-xl transition-all duration-200 transform hover:scale-105">
                            <i class="fas fa-times-circle mr-1"></i>
                            Clear
                        </button>
                    </div>
                </div>
            </div>
            <div class="bg-gradient-to-r from-indigo-50 to-purple-50 rounded-lg p-4 border border-indigo-200">
                <div class="flex items-center justify-between">
                    <span class="text-slate-700 font-semibold">
                        <i class="fas fa-eye text-indigo-600 mr-2"></i>
                        Visible Orders:
                    </span>
                    <span id="visibleOrdersCount" class="text-2xl font-bold text-indigo-600">0</span>
                </div>
            </div>
        </div>

        <!-- Orders Table -->
        <c:choose>
            <c:when test="${empty orders}">
                <div class="bg-white rounded-xl shadow-lg p-12 text-center border border-slate-200">
                    <i class="fas fa-inbox text-6xl text-slate-300 mb-4"></i>
                    <p class="text-xl font-bold text-slate-600">No orders found</p>
                    <p class="text-slate-500 mt-2">Orders will appear here once customers place them.</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bg-white rounded-xl shadow-lg overflow-hidden border border-slate-200">
                    <div class="overflow-x-auto">
                        <table id="ordersTable" class="w-full">
                            <thead>
                                <tr class="bg-gradient-to-r from-slate-700 to-slate-800 text-white">
                                    <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Order Number</th>
                                    <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Customer Email</th>
                                    <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Customer Name</th>
                                    <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Date</th>
                                    <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Total Amount</th>
                                    <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Status</th>
                                    <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Delivery Address</th>
                                    <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Phone</th>
                                    <th class="px-6 py-4 text-left text-sm font-bold uppercase tracking-wider">Actions</th>
                                </tr>
                            </thead>
                            <tbody class="divide-y divide-slate-200">
                                <c:forEach var="order" items="${orders}">
                                    <tr class="hover:bg-slate-50 transition-colors duration-150">
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <a href="${pageContext.request.contextPath}/orders/admin/${order.id}"
                                               class="text-indigo-600 hover:text-indigo-900 font-semibold hover:underline flex items-center gap-2">
                                                <i class="fas fa-receipt text-sm"></i>
                                                ${order.orderNumber}
                                            </a>
                                        </td>
                                        <td class="px-6 py-4 text-slate-700">
                                            <i class="fas fa-envelope text-slate-400 text-xs mr-1"></i>
                                            ${order.user.email}
                                        </td>
                                        <td class="px-6 py-4 font-medium text-slate-900">
                                            <i class="fas fa-user text-slate-400 text-xs mr-1"></i>
                                            ${order.user.firstName} ${order.user.lastName}
                                        </td>
                                        <td class="px-6 py-4 text-slate-700">
                                            <i class="fas fa-calendar text-slate-400 text-xs mr-1"></i>
                                            ${order.createdAt}
                                        </td>
                                        <td class="px-6 py-4 font-bold text-green-600">
                                            <i class="fas fa-dollar-sign text-sm mr-1"></i>
                                            <fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/>
                                        </td>
                                        <td class="px-6 py-4">
                                            <c:choose>
                                                <c:when test="${order.status == 'PENDING'}">
                                                    <span class="px-3 py-1 rounded-full text-xs font-bold bg-orange-100 text-orange-700 border border-orange-300">
                                                        <i class="fas fa-clock mr-1"></i>PENDING
                                                    </span>
                                                </c:when>
                                                <c:when test="${order.status == 'CONFIRMED' || order.status == 'PREPARING'}">
                                                    <span class="px-3 py-1 rounded-full text-xs font-bold bg-pink-100 text-pink-700 border border-pink-300">
                                                        <i class="fas fa-check mr-1"></i>${order.status}
                                                    </span>
                                                </c:when>
                                                <c:when test="${order.status == 'OUT_FOR_DELIVERY'}">
                                                    <span class="px-3 py-1 rounded-full text-xs font-bold bg-purple-100 text-purple-700 border border-purple-300">
                                                        <i class="fas fa-truck mr-1"></i>OUT FOR DELIVERY
                                                    </span>
                                                </c:when>
                                                <c:when test="${order.status == 'DELIVERED'}">
                                                    <span class="px-3 py-1 rounded-full text-xs font-bold bg-green-100 text-green-700 border border-green-300">
                                                        <i class="fas fa-check-double mr-1"></i>DELIVERED
                                                    </span>
                                                </c:when>
                                                <c:when test="${order.status == 'CANCELLED'}">
                                                    <span class="px-3 py-1 rounded-full text-xs font-bold bg-red-100 text-red-700 border border-red-300">
                                                        <i class="fas fa-times mr-1"></i>CANCELLED
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="px-3 py-1 rounded-full text-xs font-bold bg-slate-100 text-slate-700 border border-slate-300">
                                                        ${order.status}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="px-6 py-4 text-slate-700 max-w-xs truncate">
                                            <i class="fas fa-map-marker-alt text-slate-400 text-xs mr-1"></i>
                                            ${order.deliveryAddress}
                                        </td>
                                        <td class="px-6 py-4 text-slate-700">
                                            <i class="fas fa-phone text-slate-400 text-xs mr-1"></i>
                                            ${order.phoneNumber}
                                        </td>
                                        <td class="px-6 py-4">
                                            <form action="${pageContext.request.contextPath}/orders/admin/${order.id}/updateStatus"
                                                  method="post" class="flex gap-2">
                                                <select name="status"
                                                        class="px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-indigo-500 text-sm">
                                                    <option value="PENDING" ${order.status == 'PENDING' ? 'selected' : ''}>Pending</option>
                                                    <option value="CONFIRMED" ${order.status == 'CONFIRMED' ? 'selected' : ''}>Confirmed</option>
                                                    <option value="PREPARING" ${order.status == 'PREPARING' ? 'selected' : ''}>Preparing</option>
                                                    <option value="OUT_FOR_DELIVERY" ${order.status == 'OUT_FOR_DELIVERY' ? 'selected' : ''}>Out for Delivery</option>
                                                    <option value="DELIVERED" ${order.status == 'DELIVERED' ? 'selected' : ''}>Delivered</option>
                                                    <option value="CANCELLED" ${order.status == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                                                </select>
                                                <button type="submit"
                                                        class="px-4 py-2 bg-gradient-to-r from-pink-500 to-pink-600 hover:from-pink-600 hover:to-pink-700 text-white font-semibold rounded-lg shadow-md hover:shadow-lg transition-all duration-200 transform hover:scale-105">
                                                    <i class="fas fa-sync-alt mr-1"></i>Update
                                                </button>
                                            </form>
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