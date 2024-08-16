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
import javax.servlet.http.*;
import java.sql.ResultSet;


public class checkAvailability extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd;
        PrintWriter out = response.getWriter();
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        int price = Integer.parseInt(request.getParameter("price"));
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phoneno");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        Date checkInDate = Date.valueOf(request.getParameter("checkIn"));
        Date checkOutDate = Date.valueOf(request.getParameter("checkOut"));
        HttpSession session = request.getSession();

        // Check if check-in date is before check-out date
        if (checkInDate.compareTo(checkOutDate) >= 0) {
            session.setAttribute("regfailed", "Check-out date must be after check-in date.");
            rd = request.getRequestDispatcher("booking.jsp");
            rd.include(request, response);
            return;
        }

        // Check if check-in date is equal to or after today's date
        Date currentDate = new Date(System.currentTimeMillis());
        if (checkInDate.compareTo(currentDate) < 0) {
            session.setAttribute("regfailed", "Check-in date must be today or after today.");
            rd = request.getRequestDispatcher("booking.jsp");
            rd.include(request, response);
            return;
        }

        // Perform the availability check using roomId, checkInDate, and checkOutDate
        boolean isAvailable = CheckAvailability(roomId, checkInDate, checkOutDate);

        if (isAvailable) {
            // Room is available, insert booking details into the database
            int totalPrice = calculateTotalPrice(price, checkInDate, checkOutDate);
            if (insertBooking(roomId, price, name, phoneNumber, email, address, checkInDate, checkOutDate, totalPrice)) {
                BookingDAO bookingDAO = new BookingDAO();
                int bookingId = bookingDAO.getBookingId(roomId, checkInDate, checkOutDate);
        // Set bookingId in session
                session.setAttribute("bookingId", bookingId);
                response.sendRedirect("confirmBooking.jsp");
            } else {
                // Failed to insert booking, show error message
                session.setAttribute("regfailed", "Room is not available on this date");
                rd = request.getRequestDispatcher("booking.jsp");
                rd.include(request, response);
            }
        } else {
            // Room is not available, display a message
            session.setAttribute("regfailed", "This room is not available on the selected dates.");
            rd = request.getRequestDispatcher("booking.jsp");
            rd.include(request, response);
        }
    }

    private boolean CheckAvailability(int roomId, Date checkInDate, Date checkOutDate) {
        String url = "jdbc:mysql://localhost:3306/hotel_db";
        String username = "root";
        String password = "root";

        try (Connection con = DriverManager.getConnection(url, username, password)) {
            String sql = "SELECT * FROM bookings WHERE room_id = ? AND ((checkIn <= ? AND checkOut >= ?) OR (checkIn <= ? AND checkOut >= ?))";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setInt(1, roomId);
                stmt.setDate(2, checkInDate);
                stmt.setDate(3, checkOutDate);
                stmt.setDate(4, checkInDate);
                stmt.setDate(5, checkOutDate);
                ResultSet rs = stmt.executeQuery();
                return !rs.next(); // Room is available if no overlapping bookings found
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    private int calculateTotalPrice(int pricePerDay, Date checkInDate, Date checkOutDate) {
        long diff = checkOutDate.getTime() - checkInDate.getTime();
        int numberOfDays = (int) (diff / (1000 * 60 * 60 * 24)); // Adding 1 to include the check-out date
        return pricePerDay * numberOfDays;
    }
    
    

    private boolean insertBooking(int roomId, int price, String name, String phoneNumber, String email, String address, Date checkInDate, Date checkOutDate, int totalPrice) {
        String url = "jdbc:mysql://localhost:3306/hotel_db";
        String username = "root";
        String password = "1234";

        try (Connection con = DriverManager.getConnection(url, username, password)) {
            String sql = "INSERT INTO bookings(room_id, price, name, phnno, email, address, checkin, checkout, totalPrice, regdate) VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, CURDATE())";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setInt(1, roomId);
                stmt.setInt(2, price);
                stmt.setString(3, name);
                stmt.setString(4, phoneNumber);
                stmt.setString(5, email);
                stmt.setString(6, address);
                stmt.setDate(7, checkInDate);
                stmt.setDate(8, checkOutDate);
                stmt.setInt(9, totalPrice);
                int rowsAffected = stmt.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
 
}
