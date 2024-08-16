/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package hotel;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
public class ProcessPayment extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hotel_db";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "1234";

    // JDBC variables for opening, closing and managing connection
    private Connection connection;

    public void init() throws ServletException {
        try {
            // Establish a connection to MySQL database
            Class.forName("com.mysql.jdbc.Driver");
            connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookingid = request.getIntHeader("bookingid");
        int roomId = request.getIntHeader("roomId");
        int totalPrice = request.getIntHeader("totalPrice");
        String paymentMethod = request.getParameter("paymentMethod");
        String phoneNo = request.getParameter("phoneNo");
        String amount = request.getParameter("amount");
        String gPayId = request.getParameter("gPayId");
        String cardNumber = request.getParameter("cardNumber");
        String expiryDate = request.getParameter("expiryDate");
        String cvv = request.getParameter("cvv");
        String cardholderName = request.getParameter("cardholderName");

        // Insert the payment details into the database based on the payment method
        try {
            PreparedStatement statement;
            if (paymentMethod.equals("phonePe")) {
                statement = connection.prepareStatement("INSERT INTO phonepe_payments (bookingid, room_id, phone_no, amount, paydate) VALUES (?, ?, ?, ?, NOW())");
                statement.setInt(1, bookingid);
                statement.setInt(2, roomId);
                statement.setString(3, phoneNo);
                statement.setString(4, amount);
                        
            } else if (paymentMethod.equals("gPay")) {
                statement = connection.prepareStatement("INSERT INTO gpay_payments (bookingid, room_id, gpay_id, amount, paydate) VALUES (?, ?, ?, ?, NOW())");
                statement.setInt(1, bookingid);
                statement.setInt(2, roomId);
                statement.setString(3, gPayId);
                statement.setString(4, amount);
            } else {
                statement = connection.prepareStatement("INSERT INTO card_payments (bookingid, room_id, card_number, expiry_date, cvv, cardholder_name, paydate) VALUES (?, ?, ?, ?, ?, ?, NOW())");
                statement.setInt(1, bookingid);
                statement.setInt(2, roomId);
                statement.setString(3, cardNumber);
                statement.setString(4, expiryDate);
                statement.setString(5, cvv);
                statement.setString(6, cardholderName);
                statement.setString(7, amount);
            }
            // Execute the query
            statement.executeUpdate();
        } catch (SQLException e) {
            throw new ServletException(e);
        } 

        // Pass payment details to the invoice generation JSP
        request.setAttribute("bookingid", bookingid);
        request.setAttribute("roomId", roomId);
        request.setAttribute("paymentMethod", paymentMethod);
        request.setAttribute("phoneNo", phoneNo);
        request.setAttribute("amount", amount);
        request.setAttribute("gPayId", gPayId);
        request.setAttribute("cardNumber", cardNumber);
        request.setAttribute("expiryDate", expiryDate);
        request.setAttribute("cvv", cvv);
        request.setAttribute("cardholderName", cardholderName);

        // Forward the request to the invoice generation JSP
        request.getRequestDispatcher("Invoice.jsp").forward(request, response);
    }

    public void destroy() {
        try {
            // Close the connection
            if (connection != null && !connection.isClosed()) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
