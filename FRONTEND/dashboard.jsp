<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }
        @keyframes slideIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes pulse-soft {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.8; }
        }
        .float-animation {
            animation: float 3s ease-in-out infinite;
        }
        .slide-in {
            animation: slideIn 0.6s ease-out forwards;
        }
        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }
        .gradient-border {
            position: relative;
            background: white;
            border-radius: 1rem;
        }
        .gradient-border::before {
            content: '';
            position: absolute;
            inset: 0;
            border-radius: 1rem;
            padding: 2px;
            background: linear-gradient(135deg, #ec4899 0%, #be185d 100%);
            -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
            -webkit-mask-composite: xor;
            mask-composite: exclude;
        }
        .stat-card {
            position: relative;
            overflow: hidden;
        }
        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 100px;
            height: 100px;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            border-radius: 50%;
            transform: translate(30%, -30%);
        }
        .action-card {
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .action-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }
        .icon-wrapper {
            transition: transform 0.3s ease;
        }
        .action-card:hover .icon-wrapper {
            transform: scale(1.1) rotate(5deg);
        }

        /* Floating Petal Animations */
        .petal-container {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            pointer-events: none;
            z-index: 1;
        }

        .petal {
            position: absolute;
            width: 12px;
            height: 12px;
            background: radial-gradient(ellipse at center, rgba(236, 72, 153, 0.6) 0%, rgba(236, 72, 153, 0.3) 50%, transparent 100%);
            border-radius: 50% 0 50% 0;
            opacity: 0;
            animation: fall linear infinite;
        }

        @keyframes fall {
            0% {
                opacity: 0;
                transform: translateY(-100px) translateX(0) rotate(0deg);
            }
            10% {
                opacity: 0.8;
            }
            90% {
                opacity: 0.8;
            }
            100% {
                opacity: 0;
                transform: translateY(100vh) translateX(var(--drift)) rotate(var(--rotation));
            }
        }

        .petal:nth-child(1) { left: 5%; animation-duration: 12s; animation-delay: 0s; --drift: 30px; --rotation: 180deg; }
        .petal:nth-child(2) { left: 15%; animation-duration: 15s; animation-delay: 2s; --drift: -40px; --rotation: 360deg; }
        .petal:nth-child(3) { left: 25%; animation-duration: 18s; animation-delay: 4s; --drift: 50px; --rotation: 270deg; }
        .petal:nth-child(4) { left: 35%; animation-duration: 14s; animation-delay: 1s; --drift: -30px; --rotation: 180deg; }
        .petal:nth-child(5) { left: 45%; animation-duration: 16s; animation-delay: 3s; --drift: 40px; --rotation: 360deg; }
        .petal:nth-child(6) { left: 55%; animation-duration: 13s; animation-delay: 5s; --drift: -50px; --rotation: 270deg; }
        .petal:nth-child(7) { left: 65%; animation-duration: 17s; animation-delay: 2s; --drift: 35px; --rotation: 180deg; }
        .petal:nth-child(8) { left: 75%; animation-duration: 14s; animation-delay: 4s; --drift: -45px; --rotation: 360deg; }
        .petal:nth-child(9) { left: 85%; animation-duration: 16s; animation-delay: 1s; --drift: 30px; --rotation: 270deg; }
        .petal:nth-child(10) { left: 95%; animation-duration: 15s; animation-delay: 3s; --drift: -35px; --rotation: 180deg; }
        .petal:nth-child(11) { left: 10%; animation-duration: 19s; animation-delay: 6s; --drift: 45px; --rotation: 360deg; }
        .petal:nth-child(12) { left: 20%; animation-duration: 13s; animation-delay: 2s; --drift: -40px; --rotation: 270deg; }
        .petal:nth-child(13) { left: 30%; animation-duration: 17s; animation-delay: 5s; --drift: 35px; --rotation: 180deg; }
        .petal:nth-child(14) { left: 40%; animation-duration: 14s; animation-delay: 1s; --drift: -50px; --rotation: 360deg; }
        .petal:nth-child(15) { left: 50%; animation-duration: 16s; animation-delay: 4s; --drift: 40px; --rotation: 270deg; }
        .petal:nth-child(16) { left: 60%; animation-duration: 18s; animation-delay: 3s; --drift: -30px; --rotation: 180deg; }
        .petal:nth-child(17) { left: 70%; animation-duration: 15s; animation-delay: 6s; --drift: 50px; --rotation: 360deg; }
        .petal:nth-child(18) { left: 80%; animation-duration: 13s; animation-delay: 2s; --drift: -35px; --rotation: 270deg; }
        .petal:nth-child(19) { left: 90%; animation-duration: 17s; animation-delay: 5s; --drift: 45px; --rotation: 180deg; }
        .petal:nth-child(20) { left: 8%; animation-duration: 14s; animation-delay: 1s; --drift: -40px; --rotation: 360deg; }

        /* Rose petals variation */
        .petal.rose {
            background: radial-gradient(ellipse at center, rgba(244, 63, 94, 0.6) 0%, rgba(244, 63, 94, 0.3) 50%, transparent 100%);
        }

        /* Fuchsia petals variation */
        .petal.fuchsia {
            background: radial-gradient(ellipse at center, rgba(192, 38, 211, 0.6) 0%, rgba(192, 38, 211, 0.3) 50%, transparent 100%);
        }

        /* Larger petals */
        .petal.large {
            width: 16px;
            height: 16px;
        }

        /* Content wrapper to ensure it's above petals */
        .content-wrapper {
            position: relative;
            z-index: 10;
        }
    </style>
</head>
<body class="bg-gradient-to-br from-pink-50 via-rose-50 to-pink-100 min-h-screen">

<!-- Floating Petals Background -->
<div class="petal-container">
    <div class="petal"></div>
    <div class="petal rose"></div>
    <div class="petal fuchsia"></div>
    <div class="petal large"></div>
    <div class="petal rose large"></div>
    <div class="petal"></div>
    <div class="petal fuchsia"></div>
    <div class="petal rose"></div>
    <div class="petal large"></div>
    <div class="petal"></div>
    <div class="petal fuchsia large"></div>
    <div class="petal rose"></div>
    <div class="petal"></div>
    <div class="petal large"></div>
    <div class="petal fuchsia"></div>
    <div class="petal rose large"></div>
    <div class="petal"></div>
    <div class="petal fuchsia"></div>
    <div class="petal rose"></div>
    <div class="petal large"></div>
</div>

<div class="content-wrapper">
<%@ include file="/WEB-INF/jsp/header.jsp" %>

<!-- Main Content -->
<div class="max-w-7xl mx-auto px-6 py-8">

    <!-- Welcome Section -->
    <div class="relative bg-gradient-to-r from-pink-500 via-rose-500 to-pink-600 text-white rounded-2xl p-10 mb-8 shadow-2xl overflow-hidden slide-in">
        <div class="absolute top-0 right-0 w-64 h-64 bg-white opacity-5 rounded-full -mr-32 -mt-32"></div>
        <div class="absolute bottom-0 left-0 w-48 h-48 bg-white opacity-5 rounded-full -ml-24 -mb-24"></div>
        <div class="relative z-10">
            <h2 class="text-5xl font-bold mb-3 tracking-tight">Welcome Back!</h2>
            <p class="text-pink-100 text-lg">Manage your orders, payments, and account from one place</p>
        </div>
        <div class="absolute right-8 top-1/2 transform -translate-y-1/2 opacity-20">
            <i class="fas fa-spa text-9xl float-animation"></i>
        </div>
    </div>

    <!-- Quick Stats -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <div class="stat-card bg-white rounded-2xl shadow-lg p-6 hover:shadow-2xl transition-all duration-300 transform hover:-translate-y-1 slide-in" style="animation-delay: 0.1s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-semibold uppercase tracking-wide">My Orders</p>
                    <p class="text-4xl font-bold bg-gradient-to-r from-pink-600 to-pink-400 bg-clip-text text-transparent mt-2">-</p>
                </div>
                <div class="bg-gradient-to-br from-pink-400 to-pink-600 p-4 rounded-2xl shadow-lg">
                    <i class="fas fa-box text-white text-3xl"></i>
                </div>
            </div>
            <a href="/orders" class="text-pink-600 text-sm font-bold mt-4 inline-flex items-center hover:gap-2 transition-all group">
                View Orders
                <i class="fas fa-arrow-right ml-1 group-hover:translate-x-1 transition-transform"></i>
            </a>
        </div>

        <div class="stat-card bg-white rounded-2xl shadow-lg p-6 hover:shadow-2xl transition-all duration-300 transform hover:-translate-y-1 slide-in" style="animation-delay: 0.2s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-semibold uppercase tracking-wide">Cart Items</p>
                    <p class="text-4xl font-bold bg-gradient-to-r from-rose-600 to-rose-400 bg-clip-text text-transparent mt-2">-</p>
                </div>
                <div class="bg-gradient-to-br from-rose-400 to-rose-600 p-4 rounded-2xl shadow-lg">
                    <i class="fas fa-shopping-basket text-white text-3xl"></i>
                </div>
            </div>
            <a href="/cart" class="text-rose-600 text-sm font-bold mt-4 inline-flex items-center hover:gap-2 transition-all group">
                View Cart
                <i class="fas fa-arrow-right ml-1 group-hover:translate-x-1 transition-transform"></i>
            </a>
        </div>

        <div class="stat-card bg-white rounded-2xl shadow-lg p-6 hover:shadow-2xl transition-all duration-300 transform hover:-translate-y-1 slide-in" style="animation-delay: 0.3s">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-gray-500 text-sm font-semibold uppercase tracking-wide">Payments</p>
                    <p class="text-4xl font-bold bg-gradient-to-r from-fuchsia-600 to-fuchsia-400 bg-clip-text text-transparent mt-2">-</p>
                </div>
                <div class="bg-gradient-to-br from-fuchsia-400 to-fuchsia-600 p-4 rounded-2xl shadow-lg">
                    <i class="fas fa-credit-card text-white text-3xl"></i>
                </div>
            </div>
            <a href="/payments/my" class="text-fuchsia-600 text-sm font-bold mt-4 inline-flex items-center hover:gap-2 transition-all group">
                View Payments
                <i class="fas fa-arrow-right ml-1 group-hover:translate-x-1 transition-transform"></i>
            </a>
        </div>


    </div>

    <!-- Main Actions Grid -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-8">

        <!-- Browse Products -->
        <div class="action-card bg-white rounded-2xl shadow-xl overflow-hidden slide-in" style="animation-delay: 0.5s">
            <div class="h-44 bg-gradient-to-br from-pink-400 via-pink-500 to-pink-600 flex items-center justify-center relative overflow-hidden">
                <div class="absolute inset-0 bg-white opacity-10"></div>
                <div class="icon-wrapper">
                    <i class="fas fa-seedling text-white text-6xl drop-shadow-2xl"></i>
                </div>
            </div>
            <div class="p-6">
                <h3 class="text-2xl font-bold text-gray-800 mb-2">Browse Products</h3>
                <a href="/products/user/list" class="inline-flex items-center px-5 py-2.5 bg-gradient-to-r from-pink-500 to-pink-600 text-white rounded-xl hover:from-pink-600 hover:to-pink-700 transition shadow-lg hover:shadow-xl transform hover:scale-105 font-semibold">
                    Shop Now
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>

        <!-- View Cart -->
        <div class="action-card bg-white rounded-2xl shadow-xl overflow-hidden slide-in" style="animation-delay: 0.6s">
            <div class="h-44 bg-gradient-to-br from-rose-400 via-rose-500 to-rose-600 flex items-center justify-center relative overflow-hidden">
                <div class="absolute inset-0 bg-white opacity-10"></div>
                <div class="icon-wrapper">
                    <i class="fas fa-shopping-basket text-white text-6xl drop-shadow-2xl"></i>
                </div>
            </div>
            <div class="p-6">
                <h3 class="text-2xl font-bold text-gray-800 mb-2">Your Cart</h3>
                <p class="text-gray-600 text-sm mb-5 leading-relaxed">Review items in your cart and proceed to checkout</p>
                <a href="/cart" class="inline-flex items-center px-5 py-2.5 bg-gradient-to-r from-rose-500 to-rose-600 text-white rounded-xl hover:from-rose-600 hover:to-rose-700 transition shadow-lg hover:shadow-xl transform hover:scale-105 font-semibold">
                    Open Cart
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>

        <!-- My Orders -->
        <div class="action-card bg-white rounded-2xl shadow-xl overflow-hidden slide-in" style="animation-delay: 0.7s">
            <div class="h-44 bg-gradient-to-br from-fuchsia-400 via-fuchsia-500 to-fuchsia-600 flex items-center justify-center relative overflow-hidden">
                <div class="absolute inset-0 bg-white opacity-10"></div>
                <div class="icon-wrapper">
                    <i class="fas fa-clipboard-list text-white text-6xl drop-shadow-2xl"></i>
                </div>
            </div>
            <div class="p-6">
                <h3 class="text-2xl font-bold text-gray-800 mb-2">My Orders</h3>
                <p class="text-gray-600 text-sm mb-5 leading-relaxed">Track and manage all your orders in one place</p>
                <a href="/orders" class="inline-flex items-center px-5 py-2.5 bg-gradient-to-r from-fuchsia-500 to-fuchsia-600 text-white rounded-xl hover:from-fuchsia-600 hover:to-fuchsia-700 transition shadow-lg hover:shadow-xl transform hover:scale-105 font-semibold">
                    View Orders
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>

        <!-- Payments History -->
        <div class="action-card bg-white rounded-2xl shadow-xl overflow-hidden slide-in" style="animation-delay: 0.8s">
            <div class="h-44 bg-gradient-to-br from-pink-400 via-rose-400 to-pink-500 flex items-center justify-center relative overflow-hidden">
                <div class="absolute inset-0 bg-white opacity-10"></div>
                <div class="icon-wrapper">
                    <i class="fas fa-wallet text-white text-6xl drop-shadow-2xl"></i>
                </div>
            </div>
            <div class="p-6">
                <h3 class="text-2xl font-bold text-gray-800 mb-2">Payments</h3>
                <p class="text-gray-600 text-sm mb-5 leading-relaxed">View your payment history and transaction details</p>
                <a href="/payments/my" class="inline-flex items-center px-5 py-2.5 bg-gradient-to-r from-pink-500 to-rose-500 text-white rounded-xl hover:from-pink-600 hover:to-rose-600 transition shadow-lg hover:shadow-xl transform hover:scale-105 font-semibold">
                    View Payments
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
            </div>
        </div>


        <!-- Profile Settings -->
        <div class="action-card bg-white rounded-2xl shadow-xl overflow-hidden slide-in" style="animation-delay: 1s">
            <div class="h-44 bg-gradient-to-br from-rose-400 via-pink-500 to-rose-600 flex items-center justify-center relative overflow-hidden">
                <div class="absolute inset-0 bg-white opacity-10"></div>
                <div class="icon-wrapper">
                    <i class="fas fa-user-circle text-white text-6xl drop-shadow-2xl"></i>
                </div>
            </div>
            <div class="p-6">
                <h3 class="text-2xl font-bold text-gray-800 mb-2">Profile</h3>
                <p class="text-gray-600 text-sm mb-5 leading-relaxed">Manage your account settings and profile information</p>
                <a href="/profile" class="inline-flex items-center px-5 py-2.5 bg-gradient-to-r from-rose-500 to-pink-600 text-white rounded-xl hover:from-rose-600 hover:to-pink-700 transition shadow-lg hover:shadow-xl transform hover:scale-105 font-semibold">
                    Edit Profile
                    <i class="fas fa-arrow-right ml-2"></i>
                </a>
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

</div>
</body>
<%@ include file="footer.jsp" %>
</html>