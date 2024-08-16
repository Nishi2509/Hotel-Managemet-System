<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Invoice</title>
    <style>
        /* Add your CSS styles here */
        body {
            font-family: Arial, sans-serif;
        }
        .invoice {
            margin: 20px auto;
            padding: 20px;
            max-width: 600px;
            background-color: #f9f9f9;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
        .invoice-header {
            text-align: center;
            margin-bottom: 20px;
        }
        .invoice-details {
            margin-bottom: 20px;
        }
        .invoice-details table {
            width: 100%;
            border-collapse: collapse;
        }
        .invoice-details th, .invoice-details td {
            border: 1px solid #ccc;
            padding: 8px;
        }
        .invoice-details th {
            background-color: #f2f2f2;
        }
        .invoice-total {
            text-align: right;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="invoice">
        <div class="invoice-header">
            <h2>Invoice</h2>
        </div>
        <div class="invoice-details">
            <table>
                <tr>
                    <th>Payment Method</th>
                    <td><%= request.getAttribute("paymentMethod") %></td>
                </tr>
                <tr>
                    <th>Phone Number</th>
                    <td><%= request.getAttribute("phoneNo") %></td>
                </tr>
                <tr>
                    <th>Amount</th>
                    <td>$<%= request.getAttribute("amount") %></td>
                </tr>
                <!-- Add more details if needed -->
            </table>
        </div>
        <div class="invoice-total">
            Total Amount: $<%= request.getAttribute("amount") %>
        </div>
    </div>
</body>
</html>
