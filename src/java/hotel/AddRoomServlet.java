package hotel;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.sql.*;
import java.util.*;

public class AddRoomServlet extends HttpServlet {
    static {
        // Static block to load the MySQL JDBC driver
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError("Failed to load MySQL JDBC driver");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String message = "";

        // Retrieve form parameters
        String name = request.getParameter("name");
        String areaParam = request.getParameter("area");
        int area = 0;
        if (areaParam != null && !areaParam.isEmpty()) {
            area = Integer.parseInt(areaParam);
        }

        String priceParam = request.getParameter("price");
        int price = 0;
        if (priceParam != null && !priceParam.isEmpty()) {
            price = Integer.parseInt(priceParam);
        }

        String quantityParam = request.getParameter("quantity");
        int quantity = 0;
        if (quantityParam != null && !quantityParam.isEmpty()) {
            quantity = Integer.parseInt(quantityParam);
        }

        String adultParam = request.getParameter("adult");
        int adult = 0;
        if (adultParam != null && !adultParam.isEmpty()) {
            adult = Integer.parseInt(adultParam);
        }

        String childrenParam = request.getParameter("children");
        int children = 0;
        if (childrenParam != null && !childrenParam.isEmpty()) {
            children = Integer.parseInt(childrenParam);
        }

        String description = request.getParameter("description");
        String status = request.getParameter("status");
        String[] features = request.getParameterValues("features");
        String[] facilities = request.getParameterValues("facilities");

        // Get the image file from the request
        Part imagePart = request.getPart("image");
        byte[] imageData = null;

        if (imagePart != null) {
            // Read image data
            try (InputStream inputStream = imagePart.getInputStream()) {
                ByteArrayOutputStream buffer = new ByteArrayOutputStream();
                int nRead;
                byte[] data = new byte[16384];
                while ((nRead = inputStream.read(data, 0, data.length)) != -1) {
                    buffer.write(data, 0, nRead);
                }
                buffer.flush();
                imageData = buffer.toByteArray();
            } catch (IOException e) {
                e.printStackTrace();
                message = "Failed to read image data!";
            }
            // Define database connection parameters
            String url = "jdbc:mysql://localhost:3306/hotel_db";
            String username = "root";
            String password = "1234";

            try {
                // Establish database connection
                try (Connection con = DriverManager.getConnection(url, username, password)) {
                    // Prepare SQL statement to insert room details into database
                    String sql = "INSERT INTO rooms (name, area, price, quantity, adult, children, description, status, image_data) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
                    try (PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                        ps.setString(1, name);
                        ps.setInt(2, area);
                        ps.setInt(3, price);
                        ps.setInt(4, quantity);
                        ps.setInt(5, adult);
                        ps.setInt(6, children);
                        ps.setString(7, description);
                        ps.setString(8, status);
                        ps.setBytes(9, imageData);

                        // Execute SQL statement to insert room details and retrieve auto-generated keys
                        int rowsAffected = ps.executeUpdate();
                        if (rowsAffected > 0) {
                            // Retrieve the auto-generated keys
                            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                                if (generatedKeys.next()) {
                                    int roomId = generatedKeys.getInt(1); // Retrieve the auto-generated room ID
                                    // Insert room features into room_features table
                                    if (features != null) {
                                        for (String featureName : features) {
                                            try {
                                                int featureId = getOrCreateFeatureId(con, featureName);
                                                insertRoomFeature(con, roomId, featureId);
                                            } catch (SQLException e) {
                                                // Handle SQL exception
                                                e.printStackTrace();
                                                System.err.println("Error processing feature: " + featureName);
                                            }
                                        }
                                    }

                                    // Similarly for facilities
                                    if (facilities != null) {
                                        for (String facilityName : facilities) {
                                            try {
                                                int facilityId = getOrCreateFacilityId(con, facilityName);
                                                insertRoomFacility(con, roomId, facilityId);
                                            } catch (SQLException e) {
                                                // Handle SQL exception
                                                e.printStackTrace();
                                                System.err.println("Error processing facility: " + facilityName);
                                            }
                                        }
                                    }
                                    message = "Room added successfully!";
                                }
                            }
                        } else {
                            message = "Failed to add room!";
                        }
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
                message = "Database error: " + e.getMessage();
            }
        } else {
            message = "Image upload failed!";
        }

        // Redirect back to the add room page with a message
        response.sendRedirect("admin/rooms.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
    }

    // Method to insert room feature into the database
    private void insertRoomFeature(Connection con, int roomId, int featureId) throws SQLException {
        String sql = "INSERT INTO room_features (room_id, feature_id) VALUES (?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setInt(2, featureId);
            ps.executeUpdate();
        }
    }

    // Method to insert room facility into the database
    private void insertRoomFacility(Connection con, int roomId, int facilityId) throws SQLException {
        String sql = "INSERT INTO room_facilities (room_id, facility_id) VALUES (?, ?)";
        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roomId);
            ps.setInt(2, facilityId);
            ps.executeUpdate();
        }
    }

    // Method to get or create a feature and return its ID
    private int getOrCreateFeatureId(Connection con, String featureName) throws SQLException {
        // Check if the feature exists
        String query = "SELECT id FROM features WHERE name = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, featureName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Feature exists, return its ID
                    return rs.getInt("id");
                } else {
                    // Feature does not exist, insert it and return its auto-generated ID
                    String insertQuery = "INSERT INTO features (name) VALUES (?)";
                    try (PreparedStatement insertPs = con.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS)) {
                        insertPs.setString(1, featureName);
                        insertPs.executeUpdate();
                        try (ResultSet generatedKeys = insertPs.getGeneratedKeys()) {
                            if (generatedKeys.next()) {
                                return generatedKeys.getInt(1);
                            } else {
                                throw new SQLException("Failed to retrieve auto-generated feature ID");
                            }
                        }
                    }
                }
            }
        }
    }

    // Method to get or create a facility and return its ID
    private int getOrCreateFacilityId(Connection con, String facilityName) throws SQLException {
        // Check if the facility exists
        String query = "SELECT id FROM facilities WHERE name = ?";
        try (PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, facilityName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Facility exists, return its ID
                    return rs.getInt("id");
                } else {
                    // Facility does not exist, insert it and return its auto-generated ID
                    String insertQuery = "INSERT INTO facilities (name) VALUES (?)";
                    try (PreparedStatement insertPs = con.prepareStatement(insertQuery, Statement.RETURN_GENERATED_KEYS)) {
                        insertPs.setString(1, facilityName);
                        insertPs.executeUpdate();
                        try (ResultSet generatedKeys = insertPs.getGeneratedKeys()) {
                            if (generatedKeys.next()) {
                                return generatedKeys.getInt(1);
                            } else {
                                throw new SQLException("Failed to retrieve auto-generated facility ID");
                            }
                        }
                    }
                }
            }
        }
    }
}
