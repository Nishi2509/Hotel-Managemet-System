package hotel;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/UpdateAboutUs")
public class UpdateAboutUs extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hotel";
    private static final String JDBC_USER = "root";
    private static final String JDBC_PASSWORD = "1234";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError("Failed to load MySQL JDBC driver");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String selectSql = "SELECT site_about FROM settings WHERE sr_id = ?";
            try (PreparedStatement selectStatement = connection.prepareStatement(selectSql)) {
                selectStatement.setInt(1, 1); // Assuming sr_id 1 is used for the "About Us" section
                ResultSet resultSet = selectStatement.executeQuery();
                if (resultSet.next()) {
                    String aboutUs = resultSet.getString("site_about");
                    request.setAttribute("aboutUs", aboutUs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database error
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("admin_dashboard.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Your existing doPost() method
    

 // Retrieve parameters from the request
        String siteTitle = request.getParameter("site_title");
        String siteAbout = request.getParameter("site_about");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String updateSql = "UPDATE settings SET site_title = ?, site_about = ? WHERE sr_id = ?";
            try (PreparedStatement updateStatement = connection.prepareStatement(updateSql)) {
                updateStatement.setString(1, siteTitle);
                updateStatement.setString(2, siteAbout);
                updateStatement.setInt(3, 1); // Assuming sr_id 1 is used for the "About Us" section

                int rowsAffected = updateStatement.executeUpdate();
                if (rowsAffected > 0) {
                    // Redirect to a success page or send a success response
                    response.sendRedirect("admin_dashboard.jsp");
                } else {
                    // Handle case where no rows were updated
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Settings with sr_id 1 not found");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle database error
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }
}
