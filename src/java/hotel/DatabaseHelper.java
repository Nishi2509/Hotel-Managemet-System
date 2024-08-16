package hotel;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DatabaseHelper {
    
    static {
        // Static block to load the MySQL JDBC driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError("Failed to load MySQL JDBC driver");
        }
    }
    
    // Method to get all features from the database
    public static List<String> getAllFeatures() {
        List<String> featuresList = new ArrayList<>();
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "1234")) {
            String featureQuery = "SELECT name FROM features";
            try (PreparedStatement pstmt = con.prepareStatement(featureQuery);
                 ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    featuresList.add(rs.getString("name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return featuresList;
    }

    // Method to get all facilities from the database
    public static List<String> getAllFacilities() {
        List<String> facilitiesList = new ArrayList<>();
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "root")) {
            String facilityQuery = "SELECT name FROM facilities";
            try (PreparedStatement pstmt = con.prepareStatement(facilityQuery);
                 ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    facilitiesList.add(rs.getString("name"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return facilitiesList;
    }
}