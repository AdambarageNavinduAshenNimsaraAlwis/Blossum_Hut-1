<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Login</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        .animated-gradient {
            background: linear-gradient(-45deg, #fce7f3, #fbcfe8, #f9a8d4, #f472b6);
            background-size: 400% 400%;
            animation: gradient 15s ease infinite;
        }
        .glass-morphism {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 192, 203, 0.3);
        }
        .input-focus:focus {
            transform: translateY(-2px);
            transition: all 0.3s ease;
        }
        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-20px); }
        }
        .float-animation {
            animation: float 6s ease-in-out infinite;
        }
        body {
            background-image: url('https://images.unsplash.com/photo-1490750967868-88aa4486c946?w=1920&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            position: relative;
        }
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(135deg, rgba(252, 231, 243, 0.9), rgba(251, 207, 232, 0.85), rgba(249, 168, 212, 0.9));
            z-index: 0;
        }
        .content-wrapper {
            position: relative;
            z-index: 1;
        }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen p-4">

<div class="content-wrapper w-full flex items-center justify-center min-h-screen">
    <!-- Decorative floating elements -->
    <div class="absolute top-20 left-10 w-72 h-72 bg-pink-300 rounded-full mix-blend-multiply filter blur-xl opacity-70 float-animation"></div>
    <div class="absolute top-40 right-10 w-72 h-72 bg-rose-300 rounded-full mix-blend-multiply filter blur-xl opacity-70 float-animation" style="animation-delay: 2s;"></div>
    <div class="absolute bottom-20 left-1/2 w-72 h-72 bg-fuchsia-300 rounded-full mix-blend-multiply filter blur-xl opacity-70 float-animation" style="animation-delay: 4s;"></div>

    <div class="glass-morphism p-10 rounded-3xl shadow-2xl w-full max-w-md relative z-10 transform hover:scale-[1.02] transition-transform duration-300">
        <!-- Logo/Icon -->
        <div class="flex justify-center mb-6">
            <div class="w-20 h-20 bg-gradient-to-br from-pink-500 to-rose-500 rounded-2xl flex items-center justify-center shadow-lg transform rotate-3 hover:rotate-6 transition-transform">
                <svg class="w-12 h-12 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                </svg>
            </div>
        </div>

        <h1 class="text-4xl font-bold mb-2 text-center bg-gradient-to-r from-pink-600 to-rose-500 bg-clip-text text-transparent">Welcome Back</h1>
        <p class="text-gray-600 text-center mb-8">Sign in to continue your journey</p>

        <div id="message" class="mb-4 text-center text-sm rounded-xl p-3 transition-all duration-300"></div>

        <form id="loginForm" class="space-y-6">
            <div class="relative">
                <label for="username" class="block mb-2 font-semibold text-gray-700 text-sm">Email Address</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-pink-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 12a4 4 0 10-8 0 4 4 0 008 0zm0 0v1.5a2.5 2.5 0 005 0V12a9 9 0 10-9 9m4.5-1.206a8.959 8.959 0 01-4.5 1.207"></path>
                        </svg>
                    </div>
                    <input type="email" id="username" required
                           class="input-focus w-full pl-12 pr-4 py-3.5 border-2 border-pink-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-500 focus:border-transparent transition-all duration-300 bg-pink-50"
                           placeholder="you@example.com" />
                </div>
            </div>

            <div class="relative">
                <label for="password" class="block mb-2 font-semibold text-gray-700 text-sm">Password</label>
                <div class="relative">
                    <div class="absolute inset-y-0 left-0 pl-4 flex items-center pointer-events-none">
                        <svg class="w-5 h-5 text-pink-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"></path>
                        </svg>
                    </div>
                    <input type="password" id="password" required
                           class="input-focus w-full pl-12 pr-4 py-3.5 border-2 border-pink-200 rounded-xl focus:outline-none focus:ring-2 focus:ring-pink-500 focus:border-transparent transition-all duration-300 bg-pink-50"
                           placeholder="••••••••" />
                </div>
            </div>

            <button type="submit" class="w-full bg-gradient-to-r from-pink-500 to-rose-500 text-white py-4 rounded-xl hover:from-pink-600 hover:to-rose-600 transition-all duration-300 font-semibold text-lg shadow-lg hover:shadow-xl transform hover:-translate-y-0.5 active:scale-[0.98]">
                Sign In
            </button>
        </form>

        <div class="mt-6 text-center">
            <p class="text-gray-600">
                Don't have an account?
                <a href="/register" class="text-transparent bg-clip-text bg-gradient-to-r from-pink-600 to-rose-500 hover:from-pink-700 hover:to-rose-600 font-semibold transition-all duration-300 hover:underline">Create Account</a>
            </p>
        </div>

        <!-- Divider with social login hint -->
        <div class="mt-8 flex items-center">
            <div class="flex-1 border-t border-pink-300"></div>
            <span class="px-4 text-sm text-gray-500">Secure Login</span>
            <div class="flex-1 border-t border-pink-300"></div>
        </div>
    </div>
</div>

<script>
    const loginForm = document.getElementById('loginForm');
    const messageDiv = document.getElementById('message');

    loginForm.addEventListener('submit', async (e) => {
        e.preventDefault();

        // Clear previous message
        messageDiv.textContent = '';
        messageDiv.className = 'mb-4 text-center text-sm rounded-xl p-3 transition-all duration-300';

        const payload = {
            email: document.getElementById('username').value,
            password: document.getElementById('password').value
        };

        try {
            const response = await fetch('/api/auth/login', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(payload)
            });

            const data = await response.json();

            if (response.ok) {
                messageDiv.textContent = "Login successful! Redirecting...";
                messageDiv.classList.add('text-green-500', 'bg-green-50', 'border', 'border-green-200');

                // Redirect based on role
                if (data.role && data.role.toLowerCase() === 'admin') {
                    setTimeout(() => window.location.href = '/admin/dashboard', 1000);
                } else {
                    setTimeout(() => window.location.href = '/home', 1000);
                }
            } else {
                messageDiv.textContent = data.error || "Login failed!";
                messageDiv.classList.add('text-red-500', 'bg-red-50', 'border', 'border-red-200');
            }
        } catch (err) {
            console.error(err);
            messageDiv.textContent = "Something went wrong!";
            messageDiv.classList.add('text-red-500', 'bg-red-50', 'border', 'border-red-200');
        }
    });
</script>

</body>
</html>