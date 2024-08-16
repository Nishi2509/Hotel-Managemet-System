package hotel;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateRoomServlet")
public class UpdateRoomServlet extends HttpServlet {

    static {
        // Static block to load the MySQL JDBC driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError("Failed to load MySQL JDBC driver");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String roomIdStr = request.getParameter("roomId");

        if (roomIdStr == null || roomIdStr.isEmpty()) {
            // Handle the case where roomId is null or empty
            // For example, you can redirect the user to an error page or display an error message
            return;
        }

        int roomId = Integer.parseInt(roomIdStr);

        // Fetch room details from the database
        Room room = fetchRoomDetails(roomId);

        if (room == null) {
            // Handle the case where room details are not found
            // For example, you can redirect the user to an error page or display an error message
            return;
        }

        // Fetch facilities and features from the database
        List<String> facilities = fetchFacilitiesFromDatabase();
        List<String> features = fetchFeaturesFromDatabase();

        // Pass room details, facilities, and features to the JSP page
        request.setAttribute("room", room);
        request.setAttribute("facilities", facilities);
        request.setAttribute("features", features);

        // Forward the request to your JSP page for updating the room details
        request.getRequestDispatcher("/admin/UpdateRoom.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Your doPost method implementation remains unchanged
    }

    private Room fetchRoomDetails(int roomId) {
        Room room = null;

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "1234")) {
            String sql = "SELECT * FROM rooms WHERE id = ?";
            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                pstmt.setInt(1, roomId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    room = new Room();
                    room.setId(rs.getInt("id"));
                    room.setName(rs.getString("name"));
                    room.setArea(rs.getInt("area"));
                    room.setPrice(rs.getInt("price"));
                    room.setQuantity(rs.getInt("quantity"));
                    room.setAdultCapacity(rs.getInt("adult"));
                    room.setChildrenCapacity(rs.getInt("children"));
                    room.setDescription(rs.getString("description"));
                    room.setStatus(rs.getString("status"));
                    room.setFeatures(rs.getString("features"));
                    room.setFacilities(rs.getString("facilities"));
                    // You may need to adjust this based on your database schema
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database error
        }

        return room;
    }

    private List<String> fetchFacilitiesFromDatabase() {
        List<String> facilities = new ArrayList<>();

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "root")) {
            String sql = "SELECT name FROM facilities";
            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    facilities.add(rs.getString("name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database error
        }

        return facilities;
    }

    private List<String> fetchFeaturesFromDatabase() {
        List<String> features = new ArrayList<>();

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "root")) {
            String sql = "SELECT name FROM features";
            try (PreparedStatement pstmt = con.prepareStatement(sql)) {
                ResultSet rs = pstmt.executeQuery();
                while (rs.next()) {
                    features.add(rs.getString("name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database error
        }

        return features;
    }
}
