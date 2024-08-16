package hotel;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

public class RoomFacilityServices {

    // Insert room facilities into the database
    public void insertRoomFacilities(int roomId, List<Integer> facilityIds) {
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "1234")) {
            String insertQuery = "INSERT INTO room_facilities (room_id, facility_id) VALUES (?, ?)";
            try (PreparedStatement pstmt = con.prepareStatement(insertQuery)) {
                for (int facilityId : facilityIds) {
                    pstmt.setInt(1, roomId);
                    pstmt.setInt(2, facilityId);
                    pstmt.addBatch();
                }
                pstmt.executeBatch();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Main method for testing
    public static void main(String[] args) {
        RoomFacilityServices roomFacilityServices = new RoomFacilityServices();
        int roomId = 1;
        List<Integer> facilityIds = Arrays.asList(1, 2, 3);
        roomFacilityServices.insertRoomFacilities(roomId, facilityIds);
    }
}
