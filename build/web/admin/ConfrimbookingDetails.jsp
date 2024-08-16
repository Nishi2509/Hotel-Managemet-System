<%@page import="java.sql.ResultSet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Confirmed Bookings</title>
    <style>
        /* Add your CSS styles here */
        /* Example CSS for table formatting */
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2>Confirmed Bookings</h2>
    <table>
        <thead>
            <tr>
                <th>Booking ID</th>
                <th>User ID</th>
                <th>Room ID</th>
                <th>Check-in Date</th>
                <th>Check-out Date</th>
                <th>Total Price</th>
            </tr>
        </thead>
        <tbody>
            <% 
                ResultSet confirmedBookings = (ResultSet) request.getAttribute("confirmedBookings");
                while (confirmedBookings.next()) {
            %>
            <tr>
                <td><%= confirmedBookings.getInt("id") %></td>
                <td><%= confirmedBookings.getInt("user_id") %></td>
                <td><%= confirmedBookings.getInt("room_id") %></td>
                <td><%= confirmedBookings.getDate("check_in_date") %></td>
                <td><%= confirmedBookings.getDate("check_out_date") %></td>
                <td>$<%= confirmedBookings.getBigDecimal("total_price") %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</body>
</html>
