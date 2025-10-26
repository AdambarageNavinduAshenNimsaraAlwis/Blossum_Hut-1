<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Admin - User List</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(10px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .fade-in { animation: fadeIn 0.5s ease-out; }

        @keyframes slideDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        .slide-down { animation: slideDown 0.6s ease-out; }

        .table-row:hover {
            transform: scale(1.01);
            transition: all 0.2s ease;
        }

        .gradient-bg {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            animation: fadeIn 0.3s ease-out;
        }

        .modal-content {
            background-color: white;
            margin: 15% auto;
            padding: 30px;
            border-radius: 15px;
            width: 90%;
            max-width: 400px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.3);
            animation: slideDown 0.3s ease-out;
        }
    </style>
</head>
<body>
    <!-- Include Header -->
    <jsp:include page="/WEB-INF/jsp/header.jsp" />

    <div class="max-w-7xl mx-auto">
        <!-- Header Section -->
        <div class="slide-down mb-8">
            <div class="glass-effect rounded-2xl shadow-2xl p-8 mb-6">
                <div class="flex items-center justify-between">
                    <div>
                        <h2 class="text-4xl font-bold text-gray-800 mb-2">
                            <i class="fas fa-users text-purple-600 mr-3"></i>All Users
                        </h2>
                        <p class="text-gray-600">Manage and view all registered users</p>
                    </div>
                    <div class="hidden md:block">
                        <div class="bg-gradient-to-r from-pink-500 to-purple-600 text-white px-6 py-3 rounded-xl shadow-lg">
                            <i class="fas fa-database mr-2"></i>
                            <span class="font-semibold">Database Records</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Success/Error Messages -->
        <c:if test="${not empty message}">
            <div class="mb-6 bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-lg fade-in">
                <i class="fas fa-check-circle mr-2"></i>${message}
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="mb-6 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-lg fade-in">
                <i class="fas fa-exclamation-circle mr-2"></i>${error}
            </div>
        </c:if>

        <!-- Table Section -->
        <div class="fade-in glass-effect rounded-2xl shadow-2xl overflow-hidden">
            <div class="overflow-x-auto">
                <table class="w-full">
                    <thead>
                        <tr class="bg-gradient-to-r from-pink-600 to-pink-600 text-white">
                            <th class="px-6 py-4 text-left text-sm font-semibold uppercase tracking-wider">
                                <i class="fas fa-hashtag mr-2"></i>ID
                            </th>
                            <th class="px-6 py-4 text-left text-sm font-semibold uppercase tracking-wider">
                                <i class="fas fa-user mr-2"></i>First Name
                            </th>
                            <th class="px-6 py-4 text-left text-sm font-semibold uppercase tracking-wider">
                                <i class="fas fa-user mr-2"></i>Last Name
                            </th>
                            <th class="px-6 py-4 text-left text-sm font-semibold uppercase tracking-wider">
                                <i class="fas fa-envelope mr-2"></i>Email
                            </th>
                            <th class="px-6 py-4 text-left text-sm font-semibold uppercase tracking-wider">
                                <i class="fas fa-shield-alt mr-2"></i>Role
                            </th>
                            <th class="px-6 py-4 text-left text-sm font-semibold uppercase tracking-wider">
                                <i class="fas fa-calendar-plus mr-2"></i>Created At
                            </th>
                            <th class="px-6 py-4 text-left text-sm font-semibold uppercase tracking-wider">
                                <i class="fas fa-calendar-check mr-2"></i>Updated At
                            </th>
                            <th class="px-6 py-4 text-center text-sm font-semibold uppercase tracking-wider">
                                <i class="fas fa-cogs mr-2"></i>Actions
                            </th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                        <c:forEach var="user" items="${users}">
                            <tr class="table-row hover:bg-purple-50 transition-all duration-200">
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="inline-flex items-center justify-center w-8 h-8 rounded-full bg-purple-100 text-purple-700 font-semibold text-sm">
                                        ${user.id}
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm font-medium text-gray-900">${user.firstName}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="text-sm font-medium text-gray-900">${user.lastName}</div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex items-center">
                                        <i class="fas fa-envelope text-gray-400 mr-2"></i>
                                        <span class="text-sm text-gray-700">${user.email}</span>
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="inline-flex items-center px-3 py-1 rounded-full text-xs font-medium bg-gradient-to-r from-pink-500 to-pink-500 text-white shadow-md">
                                        <i class="fas fa-crown mr-1"></i>
                                        ${user.role}
                                    </span>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex items-center text-sm text-gray-600">
                                        <i class="far fa-clock text-gray-400 mr-2"></i>
                                        ${user.createdAt}
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <div class="flex items-center text-sm text-gray-600">
                                        <i class="far fa-clock text-gray-400 mr-2"></i>
                                        ${user.updatedAt}
                                    </div>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-center">
                                    <div class="flex items-center justify-center space-x-2">
                                        <a href="${pageContext.request.contextPath}/admin/users/edit/${user.id}"
                                           class="inline-flex items-center px-3 py-2 bg-pink-500 hover:bg-pink-600 text-white rounded-lg transition-all duration-200 shadow-md hover:shadow-lg transform hover:scale-105">
                                            <i class="fas fa-edit mr-1"></i>
                                            <span class="text-xs font-medium">Edit</span>
                                        </a>
                                        <button onclick="confirmDelete(${user.id}, '${user.email}')"
                                                class="inline-flex items-center px-3 py-2 bg-red-500 hover:bg-red-600 text-white rounded-lg transition-all duration-200 shadow-md hover:shadow-lg transform hover:scale-105">
                                            <i class="fas fa-trash-alt mr-1"></i>
                                            <span class="text-xs font-medium">Delete</span>
                                        </button>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Footer Info -->
        <div class="mt-6 text-center">
            <p class="text-white text-sm font-medium">
                <i class="fas fa-info-circle mr-2"></i>
                User Management Dashboard
            </p>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div class="text-center">
                <div class="mx-auto flex items-center justify-center h-16 w-16 rounded-full bg-red-100 mb-4">
                    <i class="fas fa-exclamation-triangle text-red-600 text-3xl"></i>
                </div>
                <h3 class="text-xl font-bold text-gray-900 mb-2">Delete User</h3>
                <p class="text-gray-600 mb-6">Are you sure you want to delete <strong id="userEmail"></strong>? This action cannot be undone.</p>
                <div class="flex justify-center space-x-4">
                    <button onclick="closeModal()"
                            class="px-6 py-2 bg-gray-300 hover:bg-gray-400 text-gray-800 rounded-lg font-medium transition-all duration-200">
                        Cancel
                    </button>
                    <form id="deleteForm" method="POST" style="display: inline;">
                        <button type="submit"
                                class="px-6 py-2 bg-red-500 hover:bg-red-600 text-white rounded-lg font-medium transition-all duration-200">
                            Delete
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function confirmDelete(userId, userEmail) {
            document.getElementById('userEmail').textContent = userEmail;
            document.getElementById('deleteForm').action = '${pageContext.request.contextPath}/admin/users/delete/' + userId;
            document.getElementById('deleteModal').style.display = 'block';
        }

        function closeModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }

        // Close modal when clicking outside
        window.onclick = function(event) {
            const modal = document.getElementById('deleteModal');
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>

    <jsp:include page="/WEB-INF/jsp/footer.jsp" />
</body>
</html>