package hotel;

import hotel.Room;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.*;
import java.sql.Connection;

public class ShowRooms {
    private static final String url = "jdbc:mysql://localhost:3306/hotel_db";
    private static final String username = "root";
    private static final String password = "1234";

    public static Room getRoomById(int roomId) {
        Room room = null;
        try (Connection con = DriverManager.getConnection(url, username, password)) {
            String sql = "SELECT r.*, " +
                         "GROUP_CONCAT(DISTINCT rf.feature_id) AS features, " +
                         "GROUP_CONCAT(DISTINCT rf2.facility_id) AS facilities, " +
                         "GROUP_CONCAT(DISTINCT f.name) AS feature_names, " +
                         "GROUP_CONCAT(DISTINCT f2.name) AS facility_names, " +
                         "r.image_data AS image_data " +
                         "FROM rooms r " +
                         "LEFT JOIN room_features rf ON r.id = rf.room_id " +
                         "LEFT JOIN room_facilities rf2 ON r.id = rf2.room_id " +
                         "LEFT JOIN features f ON rf.feature_id = f.id " +
                         "LEFT JOIN facilities f2 ON rf2.facility_id = f2.id " +
                         "WHERE r.id = ? " +
                         "GROUP BY r.id";
            try (PreparedStatement stmt = con.prepareStatement(sql)) {
                stmt.setInt(1, roomId);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        room = new Room();
                        room.setId(rs.getInt("id"));
                        room.setName(rs.getString("name"));
                        room.setArea(rs.getInt("area"));
                        room.setPrice(rs.getInt("price"));
                        room.setQuantity(rs.getInt("quantity"));
                        room.setAdult(rs.getInt("adult"));
                        room.setChildren(rs.getInt("children"));
                        room.setDescription(rs.getString("description"));
                        room.setStatus(rs.getString("status"));

                        // Features and facilities
                        String featureNames = rs.getString("feature_names");
                        String facilityNames = rs.getString("facility_names");
                     
                        // Image data
                        Blob imageBlob = rs.getBlob("image_data");
                        if (imageBlob != null) {
                            room.setImageData(imageBlob.getBytes(1, (int) imageBlob.length()));
                        }
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return room;
    }

    static List<Room> getAllRooms() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
