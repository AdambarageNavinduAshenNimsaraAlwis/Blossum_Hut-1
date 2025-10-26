<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment - Order ${order.orderNumber}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#6366f1',
                        secondary: '#8b5cf6',
                    }
                }
            }
        }
    </script>
    <script>
        // Luhn Algorithm for credit card validation
        function luhnCheck(cardNumber) {
            let sum = 0;
            let isEven = false;
            for (let i = cardNumber.length - 1; i >= 0; i--) {
                let digit = parseInt(cardNumber[i], 10);
                if (isEven) {
                    digit *= 2;
                    if (digit > 9) {
                        digit -= 9;
                    }
                }
                sum += digit;
                isEven = !isEven;
            }
            return sum % 10 === 0;
        }

        // Validate card number format and length
        function validateCardNumber(cardNumber) {
            const cleaned = cardNumber.replace(/\s/g, '');

            if (!/^\d+$/.test(cleaned)) {
                return { valid: false, message: "Card number must contain only digits" };
            }

            if (cleaned.length < 13 || cleaned.length > 19) {
                return { valid: false, message: "Card number must be between 13 and 19 digits" };
            }

            if (!luhnCheck(cleaned)) {
                return { valid: false, message: "Invalid card number (failed Luhn check)" };
            }

            return { valid: true, message: "Valid card number" };
        }

        // Validate CVV
        function validateCVV(cvv) {
            const cleaned = cvv.trim();

            if (!/^\d{3,4}$/.test(cleaned)) {
                return { valid: false, message: "CVV must be 3 or 4 digits" };
            }

            return { valid: true, message: "Valid CVV" };
        }

        // Validate expiry date
        function validateExpiryDate(expiryDate) {
            const cleaned = expiryDate.trim();

            if (!/^\d{2}\/\d{2}$/.test(cleaned)) {
                return { valid: false, message: "Expiry date must be in MM/YY format" };
            }

            const [month, year] = cleaned.split('/');
            const monthNum = parseInt(month, 10);

            if (monthNum < 1 || monthNum > 12) {
                return { valid: false, message: "Month must be between 01 and 12" };
            }

            const currentDate = new Date();
            const currentYear = currentDate.getFullYear() % 100;
            const currentMonth = currentDate.getMonth() + 1;
            const yearNum = parseInt(year, 10);

            if (yearNum < currentYear || (yearNum === currentYear && monthNum < currentMonth)) {
                return { valid: false, message: "Card has expired" };
            }

            return { valid: true, message: "Valid expiry date" };
        }

        // Validate card holder name
        function validateCardHolderName(name) {
            const cleaned = name.trim();

            if (cleaned.length < 3) {
                return { valid: false, message: "Card holder name must be at least 3 characters" };
            }

            if (!/^[a-zA-Z\s]+$/.test(cleaned)) {
                return { valid: false, message: "Card holder name can only contain letters and spaces" };
            }

            if (cleaned.split(' ').length < 2) {
                return { valid: false, message: "Card holder name must include first and last name" };
            }

            return { valid: true, message: "Valid card holder name" };
        }

        // Format card number with spaces
        function formatCardNumber(input) {
            let value = input.value.replace(/\s/g, '');
            let formattedValue = '';
            for (let i = 0; i < value.length; i++) {
                if (i > 0 && i % 4 === 0) {
                    formattedValue += ' ';
                }
                formattedValue += value[i];
            }
            input.value = formattedValue;
        }

        // Format expiry date
        function formatExpiryDate(input) {
            let value = input.value.replace(/\D/g, '');
            if (value.length >= 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }
            input.value = value;
        }

        // Toggle payment fields based on method
        function togglePaymentFields() {
            var method = document.getElementById("paymentMethod").value;
            var cardFields = document.getElementById("cardFields");

            if (method === "CREDIT" || method === "DEBIT") {
                cardFields.style.display = "table-row-group";
                setCardFieldsRequired(true);
            } else {
                cardFields.style.display = "none";
                setCardFieldsRequired(false);
            }
        }

        function setCardFieldsRequired(required) {
            document.getElementById("cardHolderName").required = required;
            document.getElementById("cardNumber").required = required;
            document.getElementById("cvv").required = required;
            document.getElementById("expiryDate").required = required;
        }

        // Comprehensive form validation
        function validatePaymentForm() {
            var paymentMethod = document.getElementById("paymentMethod").value;

            if (!paymentMethod) {
                alert("Please select a payment method");
                return false;
            }

            if (paymentMethod === "CREDIT" || paymentMethod === "DEBIT") {
                return validateCardPayment();
            }

            return false;
        }

        function validateCardPayment() {
            var cardHolderName = document.getElementById("cardHolderName").value;
            var cardNumber = document.getElementById("cardNumber").value;
            var expiryDate = document.getElementById("expiryDate").value;
            var cvv = document.getElementById("cvv").value;

            // Validate card holder name
            var nameValidation = validateCardHolderName(cardHolderName);
            if (!nameValidation.valid) {
                alert("Card Holder Name: " + nameValidation.message);
                document.getElementById("cardHolderName").focus();
                return false;
            }

            // Validate card number
            var cardValidation = validateCardNumber(cardNumber);
            if (!cardValidation.valid) {
                alert("Card Number: " + cardValidation.message);
                document.getElementById("cardNumber").focus();
                return false;
            }

            // Validate expiry date
            var expiryValidation = validateExpiryDate(expiryDate);
            if (!expiryValidation.valid) {
                alert("Expiry Date: " + expiryValidation.message);
                document.getElementById("expiryDate").focus();
                return false;
            }

            // Validate CVV
            var cvvValidation = validateCVV(cvv);
            if (!cvvValidation.valid) {
                alert("CVV: " + cvvValidation.message);
                document.getElementById("cvv").focus();
                return false;
            }

            return true;
        }

        // Clear all form fields
        function clearPaymentForm() {
            document.getElementById("paymentMethod").value = "";
            document.getElementById("cardHolderName").value = "";
            document.getElementById("cardNumber").value = "";
            document.getElementById("expiryDate").value = "";
            document.getElementById("cvv").value = "";

            // Clear all feedback messages
            document.querySelectorAll("[id$='Feedback']").forEach(feedback => {
                feedback.textContent = "";
            });

            // Hide all payment fields
            document.getElementById("cardFields").style.display = "none";
        }

        // Real-time validation feedback
        function validateFieldOnChange(fieldId) {
            var field = document.getElementById(fieldId);
            var feedback = document.getElementById(fieldId + "Feedback");
            var value = field.value;

            if (!feedback) {
                feedback = document.createElement("span");
                feedback.id = fieldId + "Feedback";
                field.parentNode.appendChild(feedback);
            }

            let validation = { valid: false, message: "" };

            switch (fieldId) {
                case "cardNumber":
                    validation = validateCardNumber(value);
                    break;
                case "expiryDate":
                    validation = validateExpiryDate(value);
                    break;
                case "cvv":
                    validation = validateCVV(value);
                    break;
                case "cardHolderName":
                    validation = validateCardHolderName(value);
                    break;
            }

            if (value.trim() === "") {
                feedback.textContent = "";
                feedback.style.color = "gray";
            } else if (validation.valid) {
                feedback.textContent = "✓ " + validation.message;
                feedback.style.color = "green";
            } else {
                feedback.textContent = "✗ " + validation.message;
                feedback.style.color = "red";
            }
        }
    </script>
</head>
<body class="bg-gradient-to-br from-indigo-50 via-white to-purple-50 min-h-screen">
<!-- Include Header -->
    <jsp:include page="/WEB-INF/jsp/header.jsp" />
    <div class="max-w-4xl mx-auto px-4 py-8">
        <!-- Header -->
        <div class="mb-8">
            <h1 class="text-4xl font-bold text-gray-800 mb-2 bg-clip-text text-transparent bg-gradient-to-r from-indigo-600 to-purple-600">
                Payment Gateway
            </h1>
            <p class="text-gray-600">Complete your order securely</p>
        </div>

        <!-- Messages -->
        <c:if test="${not empty message}">
            <div class="mb-6 p-4 bg-green-50 border-l-4 border-green-500 rounded-lg shadow-sm animate-pulse">
                <p class="text-green-800 font-medium flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                    </svg>
                    ${message}
                </p>
            </div>
        </c:if>

        <c:if test="${not empty error}">
            <div class="mb-6 p-4 bg-red-50 border-l-4 border-red-500 rounded-lg shadow-sm animate-pulse">
                <p class="text-red-800 font-medium flex items-center">
                    <svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"/>
                    </svg>
                    ${error}
                </p>
            </div>
        </c:if>

        <!-- Navigation -->
        <div class="mb-6 flex gap-3">
            <a href="${pageContext.request.contextPath}/orders/${order.id}"
               class="inline-flex items-center px-4 py-2 bg-white border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 hover:shadow-md transition-all duration-200">
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 19l-7-7m0 0l7-7m-7 7h18"/>
                </svg>
                Back to Order
            </a>
            <a href="${pageContext.request.contextPath}/orders"
               class="inline-flex items-center px-4 py-2 bg-white border border-gray-300 rounded-lg text-gray-700 hover:bg-gray-50 hover:shadow-md transition-all duration-200">
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2"/>
                </svg>
                My Orders
            </a>
        </div>

        <!-- Order Summary Card -->
        <div class="bg-white rounded-xl shadow-lg overflow-hidden mb-8 border border-gray-100">
            <div class="bg-gradient-to-r from-pink-600 to-purple-600 px-6 py-4">
                <h2 class="text-2xl font-bold text-white flex items-center">
                    <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"/>
                    </svg>
                    Order Summary
                </h2>
            </div>
            <div class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div class="space-y-4">
                        <div class="flex items-start">
                            <div class="w-32 text-gray-600 font-medium">Order Number:</div>
                            <div class="flex-1 text-gray-900 font-semibold">${order.orderNumber}</div>
                        </div>
                        <div class="flex items-start">
                            <div class="w-32 text-gray-600 font-medium">Order Date:</div>
                            <div class="flex-1 text-gray-900">${order.createdAt}</div>
                        </div>
                    </div>
                    <div class="space-y-4">
                        <div class="flex items-start">
                            <div class="w-32 text-gray-600 font-medium">Total Amount:</div>
                            <div class="flex-1">
                                <span class="text-3xl font-bold text-indigo-600">
                                    $<fmt:formatNumber value="${order.totalAmount}" pattern="#,##0.00"/>
                                </span>
                            </div>
                        </div>
                        <div class="flex items-start">
                            <div class="w-32 text-gray-600 font-medium">Delivery Address:</div>
                            <div class="flex-1 text-gray-900">${order.deliveryAddress}</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Payment Form Card -->
        <div class="bg-white rounded-xl shadow-lg overflow-hidden border border-gray-100">
            <div class="bg-gradient-to-r from-pink-600 to-purple-600 px-6 py-4">
                <h2 class="text-2xl font-bold text-white flex items-center">
                    <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                    </svg>
                    Payment Details
                </h2>
            </div>

            <form action="${pageContext.request.contextPath}/payments/process" method="post" onsubmit="return validatePaymentForm()" class="p-6">
                <input type="hidden" name="orderId" value="${order.id}">

                <!-- Payment Method Selection -->
                <div class="mb-6">
                    <label for="paymentMethod" class="block text-sm font-semibold text-gray-700 mb-2">
                        Payment Method <span class="text-red-500">*</span>
                    </label>
                    <select id="paymentMethod" name="paymentMethod" required onchange="togglePaymentFields()"
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition-all duration-200 bg-white">
                        <option value="">-- Select Payment Method --</option>
                        <option value="CREDIT">Credit Card</option>
                        <option value="DEBIT">Debit Card</option>
                    </select>
                </div>

                <!-- Card Payment Fields -->
                <tbody id="cardFields" style="display: none;">
                    <div class="bg-gradient-to-r from-indigo-50 to-purple-50 rounded-lg p-6 mb-6 border border-indigo-200">
                        <h3 class="text-lg font-bold text-gray-800 mb-4 flex items-center">
                            <svg class="w-5 h-5 mr-2 text-indigo-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"/>
                            </svg>
                            Card Payment Details
                        </h3>

                        <div class="space-y-4">
                            <div>
                                <label for="cardHolderName" class="block text-sm font-semibold text-gray-700 mb-2">
                                    Card Holder Name <span class="text-red-500">*</span>
                                </label>
                                <input type="text" id="cardHolderName" name="cardHolderName"
                                       placeholder="John Doe"
                                       onchange="validateFieldOnChange('cardHolderName')"
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition-all duration-200">
                                <span id="cardHolderNameFeedback" class="text-sm mt-1 block"></span>
                            </div>

                            <div>
                                <label for="cardNumber" class="block text-sm font-semibold text-gray-700 mb-2">
                                    Card Number <span class="text-red-500">*</span>
                                </label>
                                <input type="text" id="cardNumber" name="cardNumber"
                                       placeholder="1234 5678 9012 3456" maxlength="23"
                                       oninput="formatCardNumber(this); validateFieldOnChange('cardNumber')"
                                       class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition-all duration-200">
                                <span id="cardNumberFeedback" class="text-sm mt-1 block"></span>
                            </div>

                            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                                <div>
                                    <label for="expiryDate" class="block text-sm font-semibold text-gray-700 mb-2">
                                        Expiry Date (MM/YY) <span class="text-red-500">*</span>
                                    </label>
                                    <input type="text" id="expiryDate" name="expiryDate"
                                           placeholder="12/25" maxlength="5"
                                           oninput="formatExpiryDate(this); validateFieldOnChange('expiryDate')"
                                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition-all duration-200">
                                    <span id="expiryDateFeedback" class="text-sm mt-1 block"></span>
                                </div>

                                <div>
                                    <label for="cvv" class="block text-sm font-semibold text-gray-700 mb-2">
                                        CVV (3-4 digits) <span class="text-red-500">*</span>
                                    </label>
                                    <input type="password" id="cvv" name="cvv"
                                           placeholder="123" maxlength="4"
                                           oninput="validateFieldOnChange('cvv')"
                                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent transition-all duration-200">
                                    <span id="cvvFeedback" class="text-sm mt-1 block"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </tbody>

                <!-- Form Actions -->
                <div class="flex gap-4 pt-4">
                    <button type="submit"
                            class="flex-1 bg-gradient-to-r from-pink-600 to-pink-600 text-white px-8 py-4 rounded-lg font-semibold hover:from-pink-700 hover:to-pink-700 transform hover:scale-[1.02] active:scale-[0.98] transition-all duration-200 shadow-lg hover:shadow-xl">
                        <span class="flex items-center justify-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
                            </svg>
                            Submit Payment
                        </span>
                    </button>
                    <button type="button"
                            onclick="window.location.href='${pageContext.request.contextPath}/orders/${order.id}'"
                            class="flex-1 bg-gray-200 text-gray-700 px-8 py-4 rounded-lg font-semibold hover:bg-gray-300 transform hover:scale-[1.02] active:scale-[0.98] transition-all duration-200 shadow-md hover:shadow-lg">
                        <span class="flex items-center justify-center">
                            <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
                            </svg>
                            Cancel
                        </span>
                    </button>
                </div>
            </form>
        </div>

        <!-- Security Information -->
        <div class="mt-8 bg-gradient-to-r from-blue-50 to-indigo-50 rounded-xl p-6 border border-blue-200">
            <div class="flex items-start space-x-4">
                <div class="flex-shrink-0">
                    <svg class="w-8 h-8 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                    </svg>
                </div>
                <div class="flex-1">
                    <h3 class="text-lg font-bold text-gray-800 mb-2">Important Information</h3>
                    <div class="space-y-2 text-gray-700">
                        <p class="flex items-start">
                            <svg class="w-5 h-5 mr-2 mt-0.5 text-blue-600 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clip-rule="evenodd"/>
                            </svg>
                            <span><strong>Note:</strong> Your payment will be reviewed and approved by our team. You will be notified once the payment is processed.</span>
                        </p>
                        <p class="flex items-start">
                            <svg class="w-5 h-5 mr-2 mt-0.5 text-green-600 flex-shrink-0" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M2.166 4.999A11.954 11.954 0 0010 1.944 11.954 11.954 0 0017.834 5c.11.65.166 1.32.166 2.001 0 5.225-3.34 9.67-8 11.317C5.34 16.67 2 12.225 2 7c0-.682.057-1.35.166-2.001zm11.541 3.708a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"/>
                            </svg>
                            <span><strong>Security:</strong> All payment information is encrypted and secure. We use industry-standard SSL encryption to protect your data.</span>
                        </p>
                    </div>
                </div>
            </div>
        </div>


    </div>
</body>
<%@ include file="footer.jsp" %>
</html>