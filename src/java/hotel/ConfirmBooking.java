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
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.ResultSet;

/**
 *
 * @author admin
 */
public class ConfirmBooking extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        int bookingId = (int) session.getAttribute("bookingId");

        Booked booking = getBookingDetails(bookingId);

        request.setAttribute("booking", booking);
        RequestDispatcher dispatcher = request.getRequestDispatcher("confirmBooking.jsp");
        dispatcher.forward(request, response);
    }

    private Booked getBookingDetails(int bookingId) {
        String url = "jdbc:mysql://localhost:3306/hotel_db";
        String username = "root";
        String password = "root";

        try (Connection con = DriverManager.getConnection(url, username, password)) {
            String sql = "SELECT * FROM bookings WHERE id = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setInt(1, bookingId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    Booked booking = new Booked();
                    booking.setId(rs.getInt("id"));
                    booking.setRoomId(rs.getInt("room_id"));
                    booking.setPrice(rs.getInt("price"));
                    booking.setName(rs.getString("name"));
                    booking.setPhoneNumber(rs.getString("phnno"));
                    booking.setEmail(rs.getString("email"));
                    booking.setAddress(rs.getString("address"));
                    booking.setCheckInDate(rs.getDate("checkin"));
                    booking.setCheckOutDate(rs.getDate("checkout"));
                    booking.setTotalPrice(rs.getInt("totalPrice"));
                    return booking;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

