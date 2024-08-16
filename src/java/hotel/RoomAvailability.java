/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package hotel;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.RequestDispatcher;
/**
 *
 * @author admin
 */
public class RoomAvailability extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String arrivalDateParam = request.getParameter("arrivalDate");
        String departureDateParam = request.getParameter("departureDate");
        List<Integer> availableRoomIds = new ArrayList<>();

        if (arrivalDateParam != null && departureDateParam != null) {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date arrivalDate = null;
            Date departureDate = null;
            try {
                arrivalDate = sdf.parse(arrivalDateParam);
                departureDate = sdf.parse(departureDateParam);
            } catch (ParseException e) {
                e.printStackTrace();
            }

            if (arrivalDate != null && departureDate != null) {
                try {
                    Connection con = null;
                    try {
                        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "1234");
                    } catch (SQLException ex) {
                        Logger.getLogger(RoomAvailability.class.getName()).log(Level.SEVERE, null, ex);
                    }
                    PreparedStatement availabilityStmt = con.prepareStatement("SELECT room_id FROM booking WHERE check_in <= ? AND check_out >= ?");
                    availabilityStmt.setDate(1, new java.sql.Date(departureDate.getTime()));
                    availabilityStmt.setDate(2, new java.sql.Date(arrivalDate.getTime()));
                    ResultSet availabilityResultSet = availabilityStmt.executeQuery();
                    Set<Integer> bookedRoomIds = new HashSet<>();
                    while (availabilityResultSet.next()) {
                        bookedRoomIds.add(availabilityResultSet.getInt("room_id"));
                    }

                    // Get all room IDs from the database
                    Statement stmt = con.createStatement();
                    ResultSet allRoomsResultSet = stmt.executeQuery("SELECT id FROM rooms");
                    Set<Integer> allRoomIds = new HashSet<>();
                    while (allRoomsResultSet.next()) {
                        allRoomIds.add(allRoomsResultSet.getInt("id"));
                    }

                    // Find available room IDs
                    allRoomIds.removeAll(bookedRoomIds); // Remove booked rooms
                    availableRoomIds.addAll(allRoomIds);

                    availabilityStmt.close();
                    stmt.close();
                    con.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        request.setAttribute("availableRoomIds", availableRoomIds);
        RequestDispatcher dispatcher = request.getRequestDispatcher("rooms.jsp");
        dispatcher.forward(request, response);
    }
}


