package hotel;

import java.io.*;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet("/DeleteRoomServlet")
public class DeleteRoomServlet extends HttpServlet {
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check admin authentication here if required
        
        int roomId = Integer.parseInt(request.getParameter("roomId"));

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel", "root", "1234");
            PreparedStatement pstmt = con.prepareStatement("DELETE FROM rooms WHERE id=?");
            pstmt.setInt(1, roomId);
            pstmt.executeUpdate();
            pstmt.close();
            con.close();
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
