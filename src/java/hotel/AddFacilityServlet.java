 package hotel;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
@WebServlet("/AddFeatureOrFacilityServlet")
public class AddFacilityServlet extends HttpServlet {
    
    private static final Logger logger = Logger.getLogger(AddFacilityServlet.class.getName());
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String name = request.getParameter("name");

        String url = "jdbc:mysql://localhost:3306/hotel_db";
        String username = "root";
        String password = "1234";

        Connection con = null;
        PreparedStatement pstmt = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(url, username, password);

            String query;
            if ("feature".equals(type)) {
                query = "INSERT INTO features (name) VALUES (?)";
            } else if ("facility".equals(type)) {
                query = "INSERT INTO facilities (name) VALUES (?)";
            } else {
                throw new IllegalArgumentException("Invalid type: " + type);
            }

            pstmt = con.prepareStatement(query);
            pstmt.setString(1, name);
            pstmt.executeUpdate();

            response.sendRedirect("admin/FeaturesAndFacilities.jsp");
        } catch (SQLException | ClassNotFoundException | IllegalArgumentException e) {
            logger.log(Level.SEVERE, "Error in AddFacilityServlet", e);
            response.sendRedirect("error.jsp");
        } finally {
            // Close resources in a finally block
            try {
                if (pstmt != null) pstmt.close();
                if (con != null) con.close();
            } catch (SQLException ex) {
                logger.log(Level.SEVERE, "Error closing resources", ex);
            }
        }
    }
}