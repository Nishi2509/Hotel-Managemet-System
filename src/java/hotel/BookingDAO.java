/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package hotel;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

public class BookingDAO {
    private String url = "jdbc:mysql://localhost:3306/hotel_db";
    private String username = "root";
    private String password = "root";

    public int getBookingId(int roomId, Date checkInDate, Date checkOutDate) {
        try (Connection con = DriverManager.getConnection(url, username, password)) {
            String sql = "SELECT id FROM bookings WHERE room_id = ? AND checkin = ? AND checkout = ?";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setInt(1, roomId);
                stmt.setDate(2, checkInDate);
                stmt.setDate(3, checkOutDate);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt("id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if booking ID not found
    }
}
