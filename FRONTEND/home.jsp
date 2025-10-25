<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Fresh Flowers - Home</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(100%);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes slideOut {
            from {
                opacity: 1;
                transform: translateX(0);
            }
            to {
                opacity: 0;
                transform: translateX(-100%);
            }
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-20px);
            }
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        @keyframes floatPetal {
            0% {
                transform: translateY(0) translateX(0) rotate(0deg);
                opacity: 0;
            }
            10% {
                opacity: 1;
            }
            90% {
                opacity: 1;
            }
            100% {
                transform: translateY(-100vh) translateX(50px) rotate(360deg);
                opacity: 0;
            }
        }

        @keyframes floatIcon {
            0%, 100% {
                transform: translateY(0px) rotate(0deg);
            }
            25% {
                transform: translateY(-15px) rotate(5deg);
            }
            50% {
                transform: translateY(-25px) rotate(0deg);
            }
            75% {
                transform: translateY(-15px) rotate(-5deg);
            }
        }

        .slide-in {
            animation: slideIn 1s ease-out;
        }

        .slide-out {
            animation: slideOut 1s ease-out;
        }

        .fade-in {
            animation: fadeIn 0.8s ease-out forwards;
            opacity: 0;
        }

        .float {
            animation: float 3s ease-in-out infinite;
        }

        .pulse-card {
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .pulse-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(236, 72, 153, 0.3);
        }

        .gradient-bg {
            background: linear-gradient(135deg, #fce7f3 0%, #fbcfe8 50%, #f9a8d4 100%);
        }

        .card-gradient {
            background: linear-gradient(135deg, #ffffff 0%, #fce7f3 100%);
        }

        .btn-gradient {
            background: linear-gradient(135deg, #ec4899 0%, #db2777 100%);
        }

        .btn-gradient:hover {
            background: linear-gradient(135deg, #db2777 0%, #be185d 100%);
        }

        * {
            scroll-behavior: smooth;
        }

        .petal {
            position: absolute;
            width: 10px;
            height: 10px;
            background: radial-gradient(ellipse at center, #fda4af 0%, #fb7185 100%);
            border-radius: 50% 0 50% 0;
            animation: floatPetal linear infinite;
            pointer-events: none;
        }

        .floating-icon {
            animation: floatIcon 4s ease-in-out infinite;
        }

        .glassmorphism {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
    </style>
</head>
<body class="gradient-bg min-h-screen relative overflow-x-hidden">
    <!-- Floating Petals Background -->
    <div id="petals-container" class="fixed inset-0 pointer-events-none z-0" style="overflow: hidden;"></div>

    <%@ include file="/WEB-INF/jsp/header.jsp" %>

    <!-- Full Screen Banner Slideshow -->
    <section id="banner" class="relative h-screen w-full overflow-hidden">
        <div id="slideshow" class="absolute inset-0">
            <!-- Slide 1 -->
            <div class="slide absolute inset-0 slide-in">
                <img src="https://images.unsplash.com/photo-1490750967868-88aa4486c946?q=80&w=2070"
                     alt="Fresh Flowers"
                     class="w-full h-full object-cover">
                <div class="absolute inset-0 bg-black bg-opacity-40"></div>
            </div>
            <!-- Slide 2 -->
            <div class="slide absolute inset-0 hidden">
                <img src="https://images.unsplash.com/photo-1563241527-3004b7be0ffd?q=80&w=2070"
                     alt="Flower Bouquet"
                     class="w-full h-full object-cover">
                <div class="absolute inset-0 bg-black bg-opacity-40"></div>
            </div>
            <!-- Slide 3 -->
            <div class="slide absolute inset-0 hidden">
                <img src="https://images.unsplash.com/photo-1487070183336-b863922373d4?q=80&w=2070"
                     alt="Flower Arrangement"
                     class="w-full h-full object-cover">
                <div class="absolute inset-0 bg-black bg-opacity-40"></div>
            </div>
            <!-- Slide 4 -->
            <div class="slide absolute inset-0 hidden">
                <img src="https://cdn.pixabay.com/photo/2017/04/28/10/19/flowers-2268013_1280.jpg"
                     alt="Beautiful Flowers"
                     class="w-full h-full object-cover">
                <div class="absolute inset-0 bg-black bg-opacity-40"></div>
            </div>
        </div>

        <!-- Banner Content -->
        <div class="relative z-10 h-full flex flex-col items-center justify-center text-white px-4">
            <h1 class="text-6xl md:text-8xl font-bold mb-6 text-center fade-in" style="animation-delay: 0.2s;">
                Blossom Hut
            </h1>
            <p class="text-2xl md:text-3xl mb-12 text-center fade-in" style="animation-delay: 0.4s;">
                Bringing Nature's Beauty to Your Doorstep
            </p>
            <button onclick="scrollToContent()"
                    class="btn-gradient text-white px-12 py-4 rounded-full text-xl font-semibold shadow-2xl hover:shadow-pink-500/50 transition-all duration-300 transform hover:scale-110 fade-in"
                    style="animation-delay: 0.6s;">
                Get Started
            </button>

            <!-- Scroll Indicator -->
            <div class="absolute bottom-10 float">
                <svg class="w-8 h-8 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 14l-7 7m0 0l-7-7m7 7V3"></path>
                </svg>
            </div>
        </div>
    </section>

    <!-- Main Content Section -->
    <section id="content" class="py-20 px-4 relative z-10">
        <div class="max-w-7xl mx-auto">
            <!-- Floating Icons Section -->
            <div class="relative mb-20">
                <div class="absolute -top-10 left-10 floating-icon" style="animation-delay: 0s;">
                    <svg class="w-16 h-16 text-pink-400 opacity-60" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10 3.5a1.5 1.5 0 013 0V4a1 1 0 001 1h3a1 1 0 011 1v3a1 1 0 01-1 1h-.5a1.5 1.5 0 000 3h.5a1 1 0 011 1v3a1 1 0 01-1 1h-3a1 1 0 01-1-1v-.5a1.5 1.5 0 00-3 0v.5a1 1 0 01-1 1H6a1 1 0 01-1-1v-3a1 1 0 00-1-1h-.5a1.5 1.5 0 010-3H4a1 1 0 001-1V6a1 1 0 011-1h3a1 1 0 001-1v-.5z"></path>
                    </svg>
                </div>
                <div class="absolute -top-5 right-20 floating-icon" style="animation-delay: 1s;">
                    <svg class="w-12 h-12 text-pink-500 opacity-50" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd"></path>
                    </svg>
                </div>
                <div class="absolute top-20 right-10 floating-icon" style="animation-delay: 2s;">
                    <svg class="w-14 h-14 text-pink-300 opacity-70" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                    </svg>
                </div>
            </div>

            <!-- Navigation Cards -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-20">
                <!-- Flower Items Card -->
                <div onclick="window.location.href='/products/user/list'"
                     class="pulse-card card-gradient rounded-3xl p-8 shadow-xl cursor-pointer border-2 border-pink-200">
                    <div class="flex flex-col items-center">
                        <div class="w-24 h-24 bg-pink-500 rounded-full flex items-center justify-center mb-6 shadow-lg">
                            <svg class="w-12 h-12 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4"></path>
                            </svg>
                        </div>
                        <h3 class="text-3xl font-bold text-pink-900 mb-4">Flower Items</h3>
                        <p class="text-center text-pink-700 text-lg">Browse our exquisite collection of fresh flowers and arrangements</p>
                    </div>
                </div>

                <!-- My Cart Card -->
                <div onclick="window.location.href='/cart'"
                     class="pulse-card card-gradient rounded-3xl p-8 shadow-xl cursor-pointer border-2 border-pink-200">
                    <div class="flex flex-col items-center">
                        <div class="w-24 h-24 bg-pink-500 rounded-full flex items-center justify-center mb-6 shadow-lg">
                            <svg class="w-12 h-12 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 3h2l.4 2M7 13h10l4-8H5.4M7 13L5.4 5M7 13l-2.293 2.293c-.63.63-.184 1.707.707 1.707H17m0 0a2 2 0 100 4 2 2 0 000-4zm-8 2a2 2 0 11-4 0 2 2 0 014 0z"></path>
                            </svg>
                        </div>
                        <h3 class="text-3xl font-bold text-pink-900 mb-4">My Cart</h3>
                        <p class="text-center text-pink-700 text-lg">View and manage your selected flower arrangements</p>
                    </div>
                </div>

                <!-- My Orders Card -->
                <div onclick="window.location.href='/orders'"
                     class="pulse-card card-gradient rounded-3xl p-8 shadow-xl cursor-pointer border-2 border-pink-200">
                    <div class="flex flex-col items-center">
                        <div class="w-24 h-24 bg-pink-500 rounded-full flex items-center justify-center mb-6 shadow-lg">
                            <svg class="w-12 h-12 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path>
                            </svg>
                        </div>
                        <h3 class="text-3xl font-bold text-pink-900 mb-4">My Orders</h3>
                        <p class="text-center text-pink-700 text-lg">Track your flower deliveries and order history</p>
                    </div>
                </div>
            </div>

            <!-- Why Choose Us Section -->
            <div class="bg-white rounded-3xl p-12 shadow-2xl mb-20 relative">
                <div class="absolute top-10 right-10 floating-icon" style="animation-delay: 0.5s;">
                    <svg class="w-20 h-20 text-pink-200 opacity-40" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10 3.5a1.5 1.5 0 013 0V4a1 1 0 001 1h3a1 1 0 011 1v3a1 1 0 01-1 1h-.5a1.5 1.5 0 000 3h.5a1 1 0 011 1v3a1 1 0 01-1 1h-3a1 1 0 01-1-1v-.5a1.5 1.5 0 00-3 0v.5a1 1 0 01-1 1H6a1 1 0 01-1-1v-3a1 1 0 00-1-1h-.5a1.5 1.5 0 010-3H4a1 1 0 001-1V6a1 1 0 011-1h3a1 1 0 001-1v-.5z"></path>
                    </svg>
                </div>
                <h2 class="text-5xl font-bold text-center text-pink-900 mb-16">Why Choose Our Flowers?</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
                    <div class="text-center">
                        <div class="w-20 h-20 bg-pink-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <svg class="w-10 h-10 text-pink-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
                            </svg>
                        </div>
                        <h4 class="text-xl font-bold text-pink-900 mb-2">Farm Fresh</h4>
                        <p class="text-pink-700">Directly sourced from premium flower farms</p>
                    </div>

                    <div class="text-center">
                        <div class="w-20 h-20 bg-pink-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <svg class="w-10 h-10 text-pink-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <h4 class="text-xl font-bold text-pink-900 mb-2">Same Day Delivery</h4>
                        <p class="text-pink-700">Fast and reliable delivery service</p>
                    </div>

                    <div class="text-center">
                        <div class="w-20 h-20 bg-pink-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <svg class="w-10 h-10 text-pink-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4.318 6.318a4.5 4.5 0 000 6.364L12 20.364l7.682-7.682a4.5 4.5 0 00-6.364-6.364L12 7.636l-1.318-1.318a4.5 4.5 0 00-6.364 0z"></path>
                            </svg>
                        </div>
                        <h4 class="text-xl font-bold text-pink-900 mb-2">Handcrafted</h4>
                        <p class="text-pink-700">Expertly arranged by skilled florists</p>
                    </div>

                    <div class="text-center">
                        <div class="w-20 h-20 bg-pink-100 rounded-full flex items-center justify-center mx-auto mb-4">
                            <svg class="w-10 h-10 text-pink-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8c-1.657 0-3 .895-3 2s1.343 2 3 2 3 .895 3 2-1.343 2-3 2m0-8c1.11 0 2.08.402 2.599 1M12 8V7m0 1v8m0 0v1m0-1c-1.11 0-2.08-.402-2.599-1M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                            </svg>
                        </div>
                        <h4 class="text-xl font-bold text-pink-900 mb-2">Best Prices</h4>
                        <p class="text-pink-700">Quality flowers at affordable rates</p>
                    </div>
                </div>
            </div>

            <!-- Customer Testimonials Section with Glassmorphism -->
            <div class="mb-20">
                <h2 class="text-5xl font-bold text-center text-pink-900 mb-16">What Our Customers Say</h2>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <div class="glassmorphism rounded-3xl p-8 shadow-xl transform hover:scale-105 transition-all duration-300">
                        <div class="flex items-center mb-4">
                            <div class="w-16 h-16 bg-gradient-to-br from-pink-400 to-pink-600 rounded-full flex items-center justify-center text-white text-2xl font-bold">
                                S
                            </div>
                            <div class="ml-4">
                                <h4 class="text-xl font-bold text-pink-900">Sarah Johnson</h4>
                                <div class="flex text-yellow-400">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                </div>
                            </div>
                        </div>
                        <p class="text-pink-800 text-lg leading-relaxed">"Absolutely stunning flowers! The bouquet was even more beautiful than the pictures. Delivery was prompt and the flowers stayed fresh for over a week."</p>
                    </div>

                    <div class="glassmorphism rounded-3xl p-8 shadow-xl transform hover:scale-105 transition-all duration-300">
                        <div class="flex items-center mb-4">
                            <div class="w-16 h-16 bg-gradient-to-br from-pink-400 to-pink-600 rounded-full flex items-center justify-center text-white text-2xl font-bold">
                                M
                            </div>
                            <div class="ml-4">
                                <h4 class="text-xl font-bold text-pink-900">Michael Chen</h4>
                                <div class="flex text-yellow-400">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                </div>
                            </div>
                        </div>
                        <p class="text-pink-800 text-lg leading-relaxed">"Best flower delivery service I've used! The arrangements are always creative and the customer service is exceptional. Highly recommended for special occasions."</p>
                    </div>

                    <div class="glassmorphism rounded-3xl p-8 shadow-xl transform hover:scale-105 transition-all duration-300">
                        <div class="flex items-center mb-4">
                            <div class="w-16 h-16 bg-gradient-to-br from-pink-400 to-pink-600 rounded-full flex items-center justify-center text-white text-2xl font-bold">
                                E
                            </div>
                            <div class="ml-4">
                                <h4 class="text-xl font-bold text-pink-900">Emma Williams</h4>
                                <div class="flex text-yellow-400">
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                    <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20">
                                        <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                    </svg>
                                </div>
                            </div>
                        </div>
                        <p class="text-pink-800 text-lg leading-relaxed">"I order flowers regularly for my office and they never disappoint. The quality is consistent and prices are very reasonable. My go-to flower shop!"</p>
                    </div>
                </div>
            </div>

            <!-- Featured Collections -->
            <div class="mb-20">
                <h2 class="text-5xl font-bold text-center text-pink-900 mb-16">Featured Collections</h2>
                <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                    <div class="card-gradient rounded-3xl overflow-hidden shadow-xl transform hover:scale-105 transition-all duration-300">
                        <div class="h-64 bg-pink-200 flex items-center justify-center relative">
                            <div class="absolute top-5 right-5 floating-icon" style="animation-delay: 0.3s;">
                                <svg class="w-10 h-10 text-pink-400 opacity-50" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd"></path>
                                </svg>
                            </div>
                            <svg class="w-32 h-32 text-pink-500" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M10 3.5a1.5 1.5 0 013 0V4a1 1 0 001 1h3a1 1 0 011 1v3a1 1 0 01-1 1h-.5a1.5 1.5 0 000 3h.5a1 1 0 011 1v3a1 1 0 01-1 1h-3a1 1 0 01-1-1v-.5a1.5 1.5 0 00-3 0v.5a1 1 0 01-1 1H6a1 1 0 01-1-1v-3a1 1 0 00-1-1h-.5a1.5 1.5 0 010-3H4a1 1 0 001-1V6a1 1 0 011-1h3a1 1 0 001-1v-.5z"></path>
                            </svg>
                        </div>
                        <div class="p-6">
                            <h3 class="text-2xl font-bold text-pink-900 mb-2">Romantic Roses</h3>
                            <p class="text-pink-700 mb-4">Express your love with our stunning rose collections</p>
                            <button class="text-pink-600 font-semibold hover:text-pink-800">Explore →</button>
                        </div>
                    </div>

                    <div class="card-gradient rounded-3xl overflow-hidden shadow-xl transform hover:scale-105 transition-all duration-300">
                        <div class="h-64 bg-pink-200 flex items-center justify-center relative">
                            <div class="absolute top-5 left-5 floating-icon" style="animation-delay: 0.7s;">
                                <svg class="w-10 h-10 text-pink-400 opacity-50" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.07 3.292a1 1 0 00.95.69h3.462c.969 0 1.371 1.24.588 1.81l-2.8 2.034a1 1 0 00-.364 1.118l1.07 3.292c.3.921-.755 1.688-1.54 1.118l-2.8-2.034a1 1 0 00-1.175 0l-2.8 2.034c-.784.57-1.838-.197-1.539-1.118l1.07-3.292a1 1 0 00-.364-1.118L2.98 8.72c-.783-.57-.38-1.81.588-1.81h3.461a1 1 0 00.951-.69l1.07-3.292z"></path>
                                </svg>
                            </div>
                            <svg class="w-32 h-32 text-pink-500" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd"></path>
                            </svg>
                        </div>
                        <div class="p-6">
                            <h3 class="text-2xl font-bold text-pink-900 mb-2">Special Occasions</h3>
                            <p class="text-pink-700 mb-4">Perfect arrangements for every celebration</p>
                            <button class="text-pink-600 font-semibold hover:text-pink-800">Explore →</button>
                        </div>
                    </div>

                    <div class="card-gradient rounded-3xl overflow-hidden shadow-xl transform hover:scale-105 transition-all duration-300">
                        <div class="h-64 bg-pink-200 flex items-center justify-center relative">
                            <div class="absolute bottom-5 right-5 floating-icon" style="animation-delay: 1.1s;">
                                <svg class="w-10 h-10 text-pink-400 opacity-50" fill="currentColor" viewBox="0 0 20 20">
                                    <path d="M10 3.5a1.5 1.5 0 013 0V4a1 1 0 001 1h3a1 1 0 011 1v3a1 1 0 01-1 1h-.5a1.5 1.5 0 000 3h.5a1 1 0 011 1v3a1 1 0 01-1 1h-3a1 1 0 01-1-1v-.5a1.5 1.5 0 00-3 0v.5a1 1 0 01-1 1H6a1 1 0 01-1-1v-3a1 1 0 00-1-1h-.5a1.5 1.5 0 010-3H4a1 1 0 001-1V6a1 1 0 011-1h3a1 1 0 001-1v-.5z"></path>
                                </svg>
                            </div>
                            <svg class="w-32 h-32 text-pink-500" fill="currentColor" viewBox="0 0 20 20">
                                <path d="M2 6a2 2 0 012-2h6a2 2 0 012 2v8a2 2 0 01-2 2H4a2 2 0 01-2-2V6zM14.553 7.106A1 1 0 0014 8v4a1 1 0 00.553.894l2 1A1 1 0 0018 13V7a1 1 0 00-1.447-.894l-2 1z"></path>
                            </svg>
                        </div>
                        <div class="p-6">
                            <h3 class="text-2xl font-bold text-pink-900 mb-2">Seasonal Blooms</h3>
                            <p class="text-pink-700 mb-4">Discover the beauty of seasonal flowers</p>
                            <button class="text-pink-600 font-semibold hover:text-pink-800">Explore →</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Call to Action -->
            <div class="bg-gradient-to-r from-pink-500 to-pink-600 rounded-3xl p-16 text-center shadow-2xl relative overflow-hidden">
                <div class="absolute top-10 left-10 floating-icon" style="animation-delay: 0s;">
                    <svg class="w-16 h-16 text-white opacity-20" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M3.172 5.172a4 4 0 015.656 0L10 6.343l1.172-1.171a4 4 0 115.656 5.656L10 17.657l-6.828-6.829a4 4 0 010-5.656z" clip-rule="evenodd"></path>
                    </svg>
                </div>
                <div class="absolute bottom-10 right-10 floating-icon" style="animation-delay: 1.5s;">
                    <svg class="w-20 h-20 text-white opacity-20" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M10 3.5a1.5 1.5 0 013 0V4a1 1 0 001 1h3a1 1 0 011 1v3a1 1 0 01-1 1h-.5a1.5 1.5 0 000 3h.5a1 1 0 011 1v3a1 1 0 01-1 1h-3a1 1 0 01-1-1v-.5a1.5 1.5 0 00-3 0v.5a1 1 0 01-1 1H6a1 1 0 01-1-1v-3a1 1 0 00-1-1h-.5a1.5 1.5 0 010-3H4a1 1 0 001-1V6a1 1 0 011-1h3a1 1 0 001-1v-.5z"></path>
                    </svg>
                </div>
                <h2 class="text-4xl md:text-5xl font-bold text-white mb-6 relative z-10">Ready to Brighten Someone's Day?</h2>
                <p class="text-xl text-pink-100 mb-8 relative z-10">Order now and enjoy same-day delivery on fresh flowers</p>
                <button onclick="window.location.href='/products/user/list'"
                        class="bg-white text-pink-600 px-12 py-4 rounded-full text-xl font-semibold shadow-xl hover:shadow-2xl transform hover:scale-110 transition-all duration-300 relative z-10">
                    Shop Now
                </button>
            </div>
        </div>
    </section>

    <script>
        // Floating Petals Creation
        function createPetal() {
            const petalsContainer = document.getElementById('petals-container');
            const petal = document.createElement('div');
            petal.classList.add('petal');

            // Random horizontal position
            const randomX = Math.random() * window.innerWidth;
            petal.style.left = randomX + 'px';

            // Random size
            const randomSize = Math.random() * 8 + 6;
            petal.style.width = randomSize + 'px';
            petal.style.height = randomSize + 'px';

            // Random animation duration
            const randomDuration = Math.random() * 10 + 10;
            petal.style.animationDuration = randomDuration + 's';

            // Random delay
            const randomDelay = Math.random() * 5;
            petal.style.animationDelay = randomDelay + 's';

            // Random colors
            const colors = [
                'radial-gradient(ellipse at center, #fda4af 0%, #fb7185 100%)',
                'radial-gradient(ellipse at center, #fbb6ce 0%, #f687b3 100%)',
                'radial-gradient(ellipse at center, #fecdd3 0%, #fda4af 100%)',
                'radial-gradient(ellipse at center, #fbcfe8 0%, #f9a8d4 100%)'
            ];
            petal.style.background = colors[Math.floor(Math.random() * colors.length)];

            petalsContainer.appendChild(petal);

            // Remove petal after animation completes
            setTimeout(() => {
                petal.remove();
            }, (randomDuration + randomDelay) * 1000);
        }

        // Create petals at intervals
        setInterval(createPetal, 800);

        // Create initial batch of petals
        for (let i = 0; i < 15; i++) {
            setTimeout(createPetal, i * 200);
        }

        // Slideshow functionality
        let currentSlide = 0;
        const slides = document.querySelectorAll('.slide');
        const totalSlides = slides.length;

        function showSlide(index) {
            slides.forEach((slide, i) => {
                if (i === index) {
                    slide.classList.remove('hidden');
                    slide.classList.remove('slide-out');
                    slide.classList.add('slide-in');
                } else {
                    if (!slide.classList.contains('hidden')) {
                        slide.classList.remove('slide-in');
                        slide.classList.add('slide-out');
                        setTimeout(() => {
                            slide.classList.add('hidden');
                        }, 1000);
                    }
                }
            });
        }

        function nextSlide() {
            currentSlide = (currentSlide + 1) % totalSlides;
            showSlide(currentSlide);
        }

        // Change slide every 4 seconds
        setInterval(nextSlide, 4000);

        // Smooth scroll to content
        function scrollToContent() {
            document.getElementById('content').scrollIntoView({ behavior: 'smooth' });
        }

        // Fade in elements on scroll
        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, observerOptions);

        // Observe all cards and sections
        document.addEventListener('DOMContentLoaded', function() {
            const cards = document.querySelectorAll('.pulse-card');
            cards.forEach(card => {
                observer.observe(card);
            });
        });
    </script>
</body>
<%@ include file="footer.jsp" %>
</html>