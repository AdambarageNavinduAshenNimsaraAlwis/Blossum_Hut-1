<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html class="h-full">
<head>
    <title>Edit User</title>
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

        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .input-field {
            transition: all 0.3s ease;
        }

        .input-field:focus {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(102, 126, 234, 0.3);
        }
    </style>
</head>
<body class="h-full flex flex-col">
    <!-- Include Header -->
    <jsp:include page="/WEB-INF/jsp/header.jsp" />

    <div class="flex-grow max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8 w-full">
        <!-- Back Button -->
        <div class="mb-6 slide-down">
            <a href="${pageContext.request.contextPath}/admin/users"
               class="inline-flex items-center px-4 py-2 bg-white text-purple-600 rounded-lg hover:bg-gray-100 transition-all duration-200 shadow-md hover:shadow-lg">
                <i class="fas fa-arrow-left mr-2"></i>
                Back to Users List
            </a>
        </div>

        <!-- Edit User Form -->
        <div class="glass-effect rounded-2xl shadow-2xl p-8 fade-in">
            <!-- Header -->
            <div class="text-center mb-8">
                <div class="inline-flex items-center justify-center w-16 h-16 bg-gradient-to-r from-purple-500 to-indigo-600 rounded-full mb-4">
                    <i class="fas fa-user-edit text-white text-2xl"></i>
                </div>
                <h2 class="text-3xl font-bold text-gray-800">Edit User</h2>
                <p class="text-gray-600 mt-2">Update user information</p>
            </div>

            <!-- Error/Success Messages -->
            <c:if test="${not empty error}">
                <div class="mb-6 bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-lg">
                    <i class="fas fa-exclamation-circle mr-2"></i>${error}
                </div>
            </c:if>

            <!-- Form -->
            <form action="${pageContext.request.contextPath}/admin/users/edit/${user.id}" method="POST">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <!-- First Name -->
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-user mr-2 text-purple-600"></i>First Name
                        </label>
                        <input type="text"
                               name="firstName"
                               value="${user.firstName}"
                               required
                               class="input-field w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-purple-500">
                    </div>

                    <!-- Last Name -->
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-user mr-2 text-purple-600"></i>Last Name
                        </label>
                        <input type="text"
                               name="lastName"
                               value="${user.lastName}"
                               required
                               class="input-field w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-purple-500">
                    </div>

                    <!-- Email -->
                    <div class="md:col-span-2">
                        <label class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-envelope mr-2 text-purple-600"></i>Email
                        </label>
                        <input type="email"
                               name="email"
                               value="${user.email}"
                               required
                               class="input-field w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-purple-500">
                    </div>

                    <!-- Role -->
                    <div class="md:col-span-2">
                        <label class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-shield-alt mr-2 text-purple-600"></i>Role
                        </label>
                        <select name="role"
                                class="input-field w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-purple-500">
                            <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                            <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>Customer</option>
                        </select>

                    </div>

                    <!-- Password Section -->
                    <div class="md:col-span-2">
                        <div class="bg-blue-50 border-l-4 border-blue-500 p-4 rounded-lg mb-4">
                            <p class="text-sm text-blue-700">
                                <i class="fas fa-info-circle mr-2"></i>
                                Leave password fields empty if you don't want to change the password
                            </p>
                        </div>
                    </div>

                    <!-- New Password -->
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-lock mr-2 text-purple-600"></i>New Password (Optional)
                        </label>
                        <input type="password"
                               name="password"
                               id="password"
                               placeholder="Leave empty to keep current"
                               class="input-field w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-purple-500">
                    </div>

                    <!-- Confirm Password -->
                    <div>
                        <label class="block text-sm font-semibold text-gray-700 mb-2">
                            <i class="fas fa-lock mr-2 text-purple-600"></i>Confirm Password
                        </label>
                        <input type="password"
                               name="confirmPassword"
                               id="confirmPassword"
                               placeholder="Leave empty to keep current"
                               class="input-field w-full px-4 py-3 border-2 border-gray-300 rounded-lg focus:outline-none focus:border-purple-500">
                    </div>
                </div>

                <!-- User Info Display -->
                <div class="mt-6 p-4 bg-gray-50 rounded-lg">
                    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 text-sm">
                        <div>
                            <span class="text-gray-600">User ID:</span>
                            <span class="font-semibold text-gray-800 ml-2">${user.id}</span>
                        </div>
                        <div>
                            <span class="text-gray-600">Created:</span>
                            <span class="font-semibold text-gray-800 ml-2">${user.createdAt}</span>
                        </div>
                        <div>
                            <span class="text-gray-600">Last Updated:</span>
                            <span class="font-semibold text-gray-800 ml-2">${user.updatedAt}</span>
                        </div>
                    </div>
                </div>

                <!-- Submit Buttons -->
                <div class="mt-8 flex flex-col sm:flex-row gap-4 justify-end">
                    <a href="${pageContext.request.contextPath}/admin/users"
                       class="px-6 py-3 bg-gray-300 hover:bg-gray-400 text-gray-800 rounded-lg font-medium transition-all duration-200 text-center">
                        <i class="fas fa-times mr-2"></i>Cancel
                    </a>
                    <button type="submit"
                            class="px-6 py-3 bg-gradient-to-r from-pink-500 to-pink-600 hover:from-pink-600 hover:to-pink-700 text-white rounded-lg font-medium transition-all duration-200 shadow-lg hover:shadow-xl transform hover:scale-105">
                        <i class="fas fa-save mr-2"></i>Save Changes
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Password validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const password = document.getElementById('password').value;
            const confirmPassword = document.getElementById('confirmPassword').value;

            // If password field is filled, validate
            if (password || confirmPassword) {
                if (password !== confirmPassword) {
                    e.preventDefault();
                    alert('Passwords do not match!');
                    return false;
                }
            }
        });
    </script>

    <jsp:include page="/WEB-INF/jsp/footer.jsp" />
</body>
</html>