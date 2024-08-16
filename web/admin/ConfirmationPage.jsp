<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment Details</title>
    <style>
        /* Add your CSS styles here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            margin: 0;
            padding: 0;
        }
        
        .container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        
        h1, h2 {
            color: #333;
            text-align: center;
        }
        
        .payment-form {
            margin-top: 20px;
        }
        
        label {
            display: block;
            margin-bottom: 5px;
            color: #666;
        }
        
        input[type="text"],
        input[type="submit"],
        input[type="radio"] {
            padding: 10px;
            width: 100%;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        
        input[type="submit"] {
            background-color: #4CAF50;
            color: #fff;
            cursor: pointer;
        }
        
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        
        #cardDetails,
        #phonePeDetails,
        #gPayDetails {
            display: none;
        }
    </style>
    <script>
        function showPaymentForm(paymentMethod) {
            var cardDetails = document.getElementById("cardDetails");
            var phonePeDetails = document.getElementById("phonePeDetails");
            var gPayDetails = document.getElementById("gPayDetails");
            var phoneNo = document.getElementById("phoneNo");
            var gPayId = document.getElementById("gPayId");
            var cardNumber = document.getElementById("cardNumber");
            var expiryDate = document.getElementById("expiryDate");
            var cvv = document.getElementById("cvv");
            var cardholderName = document.getElementById("cardholderName");
            
            // Hide all payment method details initially
            cardDetails.style.display = "none";
            phonePeDetails.style.display = "none";
            gPayDetails.style.display = "none";
            
            // Unset required attribute for all fields
            phoneNo.removeAttribute("required");
            gPayId.removeAttribute("required");
            cardNumber.removeAttribute("required");
            expiryDate.removeAttribute("required");
            cvv.removeAttribute("required");
            cardholderName.removeAttribute("required");
            
            // Show the selected payment method details and set required attribute for relevant fields
            if (paymentMethod === "creditCard") {
                cardDetails.style.display = "block";
                cardNumber.setAttribute("required", "true");
                expiryDate.setAttribute("required", "true");
                cvv.setAttribute("required", "true");
                cardholderName.setAttribute("required", "true");
            } else if (paymentMethod === "phonePe") {
                phonePeDetails.style.display = "block";
                phoneNo.setAttribute("required", "true");
            } else if (paymentMethod === "gPay") {
                gPayDetails.style.display = "block";
                gPayId.setAttribute("required", "true");
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Payment Details</h1>
        <div class="payment-form">
            <form action="ProcessPaymentServlet" method="post"> <!-- Added action attribute -->
                <h2>Select Payment Method</h2>
                <label>
                    <input type="radio" name="paymentMethod" value="phonePe" onclick="showPaymentForm('phonePe')"> PhonePe
                </label>
                <div id="phonePeDetails">
                    <label for="phoneNo">Phone Number:</label>
                    <input type="text" id="phoneNo" name="phoneNo">
                    <label for="amount">Amount:</label>
                    <input type="text" id="amount" name="amount">
                </div>
                <label>
                    <input type="radio" name="paymentMethod" value="gPay" onclick="showPaymentForm('gPay')"> Google Pay
                </label>
                <div id="gPayDetails">
                    <label for="gPayId">Google Pay ID:</label>
                    <input type="text" id="gPayId" name="gPayId">
                    <label for="amount">Amount:</label>
                    <input type="text" id="amount" name="amount">
                </div>
                <label>
                    <input type="radio" name="paymentMethod" value="creditCard" onclick="showPaymentForm('creditCard')"> Credit/Debit Card
                </label>
                <div id="cardDetails">
                    <label for="cardNumber">Card Number:</label>
                    <input type="text" id="cardNumber" name="cardNumber">
                    <label for="expiryDate">Expiry Date:</label>
                    <input type="text" id="expiryDate" name="expiryDate" placeholder="MM/YYYY">
                    <label for="cvv">CVV:</label>
                    <input type="text" id="cvv" name="cvv">
                    <label for="cardholderName">Cardholder Name:</label>
                    <input type="text" id="cardholderName" name="cardholderName">
                </div>
                
                <input type="submit" value="Pay Now">
            </form>
        </div>
    </div>
</body>
</html>
