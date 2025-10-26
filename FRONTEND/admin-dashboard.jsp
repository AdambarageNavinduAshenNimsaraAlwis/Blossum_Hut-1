<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes pulse {
            0%, 100% {
                opacity: 1;
            }
            50% {
                opacity: 0.8;
            }
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .animate-fade-in-up {
            animation: fadeInUp 0.6s ease-out forwards;
        }

        .animate-slide-in {
            animation: slideIn 0.5s ease-out forwards;
        }

        .card-hover {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .card-hover:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
        }

        .gradient-bg {
            background: linear-gradient(135deg, #ec4899 0%, #be185d 100%);
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }

        .stat-card {
            position: relative;
            overflow: hidden;
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: linear-gradient(135deg, transparent 0%, rgba(255, 255, 255, 0.1) 100%);
            opacity: 0;
            transition: opacity 0.3s;
        }

        .stat-card:hover::before {
            opacity: 1;
        }

        .icon-glow {
            filter: drop-shadow(0 0 8px currentColor);
        }

        .delay-100 { animation-delay: 0.1s; }
        .delay-200 { animation-delay: 0.2s; }
        .delay-300 { animation-delay: 0.3s; }
        .delay-400 { animation-delay: 0.4s; }
        .delay-500 { animation-delay: 0.5s; }
    </style>
</head>
<body class="bg-gradient-to-br from-pink-50 via-rose-50 to-pink-100 min-h-screen">

<%@ include file="/WEB-INF/jsp/header.jsp" %>

<!-- Main Content -->
<div class="max-w-7xl mx-auto px-6 py-8">

    <!-- Welcome Section -->
    <div class="gradient-bg text-white rounded-2xl p-8 mb-8 shadow-2xl relative overflow-hidden animate-fade-in-up">
        <div class="absolute top-0 right-0 w-64 h-64 bg-white opacity-5 rounded-full -mr-32 -mt-32"></div>
        <div class="absolute bottom-0 left-0 w-48 h-48 bg-white opacity-5 rounded-full -ml-24 -mb-24"></div>
        <div class="relative z-10">
            <div class="flex items-center mb-3">
                <div class="w-12 h-12 bg-white bg-opacity-20 rounded-xl flex items-center justify-center mr-4">
                    <i class="fas fa-crown text-yellow-300 text-2xl"></i>
                </div>
                <h2 class="text-4xl font-extrabold">Welcome Back, Admin</h2>
            </div>
            <div class="mt-6 flex items-center space-x-4">
                <div class="flex items-center space-x-2">
                    <div class="w-3 h-3 bg-green-400 rounded-full animate-pulse"></div>
                    <span class="text-sm font-medium">System Online</span>
                </div>
                <div class="text-sm opacity-75">|</div>
                <div class="text-sm">Last login: Today</div>
            </div>
        </div>
    </div>

    <!-- System Stats Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-5 gap-6 mb-8">

        <div class="stat-card bg-white rounded-2xl shadow-lg p-6 card-hover border-l-4 border-blue-500 animate-fade-in-up delay-100">
            <div class="flex items-center justify-between mb-4">
                <div class="w-14 h-14 bg-gradient-to-br from-blue-100 to-blue-200 rounded-xl flex items-center justify-center">
                    <i class="fas fa-shopping-bag text-blue-600 text-2xl"></i>
                </div>
                <div class="text-right">
                    <p class="text-gray-500 text-xs font-semibold uppercase tracking-wider">Total Orders</p>
                    <p class="text-3xl font-bold text-gray-800 mt-1">-</p>
                </div>
            </div>
            <a href="/orders/admin/all" class="flex items-center justify-between text-blue-600 text-sm font-semibold hover:text-blue-700 transition group">
                <span>Manage Orders</span>
                <i class="fas fa-arrow-right transform group-hover:translate-x-1 transition"></i>
            </a>
        </div>

        <div class="stat-card bg-white rounded-2xl shadow-lg p-6 card-hover border-l-4 border-green-500 animate-fade-in-up delay-200">
            <div class="flex items-center justify-between mb-4">
                <div class="w-14 h-14 bg-gradient-to-br from-green-100 to-green-200 rounded-xl flex items-center justify-center">
                    <i class="fas fa-credit-card text-green-600 text-2xl"></i>
                </div>
                <div class="text-right">
                    <p class="text-gray-500 text-xs font-semibold uppercase tracking-wider">Total Payments</p>
                    <p class="text-3xl font-bold text-gray-800 mt-1">-</p>
                </div>
            </div>
            <a href="/payments/admin/all" class="flex items-center justify-between text-green-600 text-sm font-semibold hover:text-green-700 transition group">
                <span>View Payments</span>
                <i class="fas fa-arrow-right transform group-hover:translate-x-1 transition"></i>
            </a>
        </div>



        <div class="stat-card bg-white rounded-2xl shadow-lg p-6 card-hover border-l-4 border-purple-500 animate-fade-in-up delay-400">
            <div class="flex items-center justify-between mb-4">
                <div class="w-14 h-14 bg-gradient-to-br from-purple-100 to-purple-200 rounded-xl flex items-center justify-center">
                    <i class="fas fa-users text-purple-600 text-2xl"></i>
                </div>
                <div class="text-right">
                    <p class="text-gray-500 text-xs font-semibold uppercase tracking-wider">Total Users</p>
                    <p class="text-3xl font-bold text-gray-800 mt-1">-</p>
                </div>
            </div>
            <a href="/admin/users" class="flex items-center justify-between text-purple-600 text-sm font-semibold hover:text-purple-700 transition group">
                <span>Manage Users</span>
                <i class="fas fa-arrow-right transform group-hover:translate-x-1 transition"></i>
            </a>
        </div>



    </div>

    <!-- Management Sections -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">

        <!-- Orders Management -->
        <div class="bg-white rounded-2xl shadow-xl overflow-hidden card-hover group">
            <div class="h-48 bg-gradient-to-br from-blue-400 via-blue-500 to-blue-600 flex items-center justify-center relative overflow-hidden">
                <div class="absolute inset-0 bg-black opacity-0 group-hover:opacity-10 transition"></div>
                <i class="fas fa-boxes text-white text-6xl icon-glow relative z-10 transform group-hover:scale-110 transition"></i>
                <div class="absolute top-4 right-4 w-20 h-20 bg-white opacity-10 rounded-full"></div>
                <div class="absolute bottom-4 left-4 w-16 h-16 bg-white opacity-10 rounded-full"></div>
            </div>
            <div class="p-6">
                <h3 class="text-xl font-bold text-gray-800 mb-2 flex items-center">
                    Orders Management
                    <span class="ml-2 text-xs bg-blue-100 text-blue-600 px-2 py-1 rounded-full">Active</span>
                </h3>
                <p class="text-gray-600 text-sm mb-6">View, track, and update order statuses</p>
                <a href="/orders/admin/all" class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-blue-600 to-blue-700 text-white rounded-xl hover:from-blue-700 hover:to-blue-800 transition font-semibold shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                    Manage Orders
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>

        <!-- Payments Management -->
        <div class="bg-white rounded-2xl shadow-xl overflow-hidden card-hover group">
            <div class="h-48 bg-gradient-to-br from-green-400 via-green-500 to-green-600 flex items-center justify-center relative overflow-hidden">
                <div class="absolute inset-0 bg-black opacity-0 group-hover:opacity-10 transition"></div>
                <i class="fas fa-money-bill-wave text-white text-6xl icon-glow relative z-10 transform group-hover:scale-110 transition"></i>
                <div class="absolute top-4 right-4 w-20 h-20 bg-white opacity-10 rounded-full"></div>
                <div class="absolute bottom-4 left-4 w-16 h-16 bg-white opacity-10 rounded-full"></div>
            </div>
            <div class="p-6">
                <h3 class="text-xl font-bold text-gray-800 mb-2 flex items-center">
                    Payments Management
                    <span class="ml-2 text-xs bg-green-100 text-green-600 px-2 py-1 rounded-full">Active</span>
                </h3>
                <p class="text-gray-600 text-sm mb-6">Approve or reject payment transactions</p>
                <a href="/payments/admin/all" class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-green-600 to-green-700 text-white rounded-xl hover:from-green-700 hover:to-green-800 transition font-semibold shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                    Manage Payments
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>


        <!-- Products Management -->
        <div class="bg-white rounded-2xl shadow-xl overflow-hidden card-hover group">
            <div class="h-48 bg-gradient-to-br from-pink-400 via-pink-500 to-rose-600 flex items-center justify-center relative overflow-hidden">
                <div class="absolute inset-0 bg-black opacity-0 group-hover:opacity-10 transition"></div>
                <i class="fas fa-seedling text-white text-6xl icon-glow relative z-10 transform group-hover:scale-110 transition"></i>
                <div class="absolute top-4 right-4 w-20 h-20 bg-white opacity-10 rounded-full"></div>
                <div class="absolute bottom-4 left-4 w-16 h-16 bg-white opacity-10 rounded-full"></div>
            </div>
            <div class="p-6">
                <h3 class="text-xl font-bold text-gray-800 mb-2 flex items-center">
                    Products Management
                    <span class="ml-2 text-xs bg-pink-100 text-pink-600 px-2 py-1 rounded-full">Active</span>
                </h3>
                <p class="text-gray-600 text-sm mb-6">Add, edit, and manage product inventory</p>
                <a href="/products" class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-pink-600 to-rose-700 text-white rounded-xl hover:from-pink-700 hover:to-rose-800 transition font-semibold shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                    Manage Products
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>

        <!-- Users Management -->
        <div class="bg-white rounded-2xl shadow-xl overflow-hidden card-hover group">
            <div class="h-48 bg-gradient-to-br from-purple-400 via-purple-500 to-purple-600 flex items-center justify-center relative overflow-hidden">
                <div class="absolute inset-0 bg-black opacity-0 group-hover:opacity-10 transition"></div>
                <i class="fas fa-user-shield text-white text-6xl icon-glow relative z-10 transform group-hover:scale-110 transition"></i>
                <div class="absolute top-4 right-4 w-20 h-20 bg-white opacity-10 rounded-full"></div>
                <div class="absolute bottom-4 left-4 w-16 h-16 bg-white opacity-10 rounded-full"></div>
            </div>
            <div class="p-6">
                <h3 class="text-xl font-bold text-gray-800 mb-2 flex items-center">
                    Users Management
                    <span class="ml-2 text-xs bg-purple-100 text-purple-600 px-2 py-1 rounded-full">Active</span>
                </h3>
                <p class="text-gray-600 text-sm mb-6">Manage user accounts and permissions</p>
                <a href="/admin/users" class="inline-flex items-center px-6 py-3 bg-gradient-to-r from-purple-600 to-purple-700 text-white rounded-xl hover:from-purple-700 hover:to-purple-800 transition font-semibold shadow-lg hover:shadow-xl transform hover:-translate-y-0.5">
                    Manage Users
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>


    </div>

    <!-- Admin Info Section -->
    <div class="grid grid-cols-1 md:grid-cols-2 gap-6">

        <!-- Quick Actions -->
        <div class="bg-white rounded-2xl shadow-xl p-8 card-hover">
            <div class="flex items-center mb-6">
                <div class="w-12 h-12 bg-gradient-to-br from-yellow-400 to-orange-500 rounded-xl flex items-center justify-center mr-4">
                    <i class="fas fa-bolt text-white text-xl"></i>
                </div>
                <h3 class="text-2xl font-bold text-gray-800">Quick Actions</h3>
            </div>
            <div class="space-y-3">
                <a href="/products/add" class="block bg-gradient-to-r from-blue-50 to-blue-100 hover:from-blue-100 hover:to-blue-200 text-blue-700 rounded-xl p-4 transition transform hover:scale-105 shadow-sm hover:shadow-md">
                    <div class="flex items-center">
                        <div class="w-10 h-10 bg-blue-600 rounded-lg flex items-center justify-center mr-3">
                            <i class="fas fa-plus-circle text-white"></i>
                        </div>
                        <div>
                            <p class="font-semibold">Add New Product</p>
                            <p class="text-xs text-blue-600">Expand your inventory</p>
                        </div>
                    </div>
                </a>
                <a href="/payments/admin/all" class="block bg-gradient-to-r from-green-50 to-green-100 hover:from-green-100 hover:to-green-200 text-green-700 rounded-xl p-4 transition transform hover:scale-105 shadow-sm hover:shadow-md">
                    <div class="flex items-center">
                        <div class="w-10 h-10 bg-green-600 rounded-lg flex items-center justify-center mr-3">
                            <i class="fas fa-check-circle text-white"></i>
                        </div>
                        <div>
                            <p class="font-semibold">Review Pending Payments</p>
                            <p class="text-xs text-green-600">Process transactions</p>
                        </div>
                    </div>
                </a>

                <a href="/orders/admin/all" class="block bg-gradient-to-r from-purple-50 to-purple-100 hover:from-purple-100 hover:to-purple-200 text-purple-700 rounded-xl p-4 transition transform hover:scale-105 shadow-sm hover:shadow-md">
                    <div class="flex items-center">
                        <div class="w-10 h-10 bg-purple-600 rounded-lg flex items-center justify-center mr-3">
                            <i class="fas fa-truck text-white"></i>
                        </div>
                        <div>
                            <p class="font-semibold">Update Order Status</p>
                            <p class="text-xs text-purple-600">Track deliveries</p>
                        </div>
                    </div>
                </a>
            </div>
        </div>

        <!-- System Info -->
        <div class="bg-white rounded-2xl shadow-xl p-8 card-hover">
            <div class="flex items-center mb-6">
                <div class="w-12 h-12 bg-gradient-to-br from-blue-400 to-indigo-500 rounded-xl flex items-center justify-center mr-4">
                    <i class="fas fa-info-circle text-white text-xl"></i>
                </div>
                <h3 class="text-2xl font-bold text-gray-800">System Information</h3>
            </div>
            <div class="space-y-4">
                <div class="flex justify-between items-center p-4 bg-gradient-to-r from-gray-50 to-gray-100 rounded-xl">
                    <div class="flex items-center">
                        <div class="w-2 h-2 bg-green-500 rounded-full mr-3 animate-pulse"></div>
                        <span class="font-semibold text-gray-700">Admin Status</span>
                    </div>
                    <span class="text-green-600 font-bold bg-green-100 px-3 py-1 rounded-full text-sm">Active</span>
                </div>
                <div class="flex justify-between items-center p-4 bg-gradient-to-r from-gray-50 to-gray-100 rounded-xl">
                    <div class="flex items-center">
                        <div class="w-2 h-2 bg-blue-500 rounded-full mr-3"></div>
                        <span class="font-semibold text-gray-700">Access Level</span>
                    </div>
                    <span class="text-blue-600 font-bold bg-blue-100 px-3 py-1 rounded-full text-sm">Full Control</span>
                </div>
                <div class="flex justify-between items-center p-4 bg-gradient-to-r from-gray-50 to-gray-100 rounded-xl">
                    <div class="flex items-center">
                        <div class="w-2 h-2 bg-purple-500 rounded-full mr-3"></div>
                        <span class="font-semibold text-gray-700">Last Login</span>
                    </div>
                    <span class="text-gray-600 font-medium">Today</span>
                </div>
                <div class="flex justify-between items-center p-4 bg-gradient-to-r from-gray-50 to-gray-100 rounded-xl">
                    <div class="flex items-center">
                        <div class="w-2 h-2 bg-indigo-500 rounded-full mr-3"></div>
                        <span class="font-semibold text-gray-700">Profile</span>
                    </div>
                    <a href="/profile" class="text-blue-600 hover:text-blue-700 font-semibold hover:underline flex items-center">
                        View Profile
                        <i class="fas fa-external-link-alt ml-2 text-xs"></i>
                    </a>
                </div>
            </div>
        </div>

    </div>

</div>

<script>
    document.getElementById("logoutBtn").addEventListener("click", async () => {
        if (confirm("Are you sure you want to logout?")) {
            try {
                const response = await fetch('/api/auth/logout', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' }
                });

                if (response.ok) {
                    window.location.href = '/login';
                } else {
                    alert('Logout failed!');
                }
            } catch (error) {
                console.error('Logout error:', error);
                alert('Logout failed!');
            }
        }
    });
</script>

</body>
<%@ include file="footer.jsp" %>
</html>