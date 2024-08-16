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

@WebServlet("/ContactDetailsServlet")
public class ContactDetailsServlet extends HttpServlet {

    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hotel_db";
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String sr_no = request.getParameter("sr_no"); // Changed parameter name to contact_id

        String address = request.getParameter("address");
        String gmap = request.getParameter("gmap");
        String pn1 = request.getParameter("pn1");
        String pn2 = request.getParameter("pn2");
        String email = request.getParameter("email");
        String fb = request.getParameter("fb");
        String insta = request.getParameter("insta");
        String tw = request.getParameter("tw");
        String iframe = request.getParameter("iframe");

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "UPDATE contact_details SET address = ?, gmap = ?, pn1 = ?, pn2 = ?, email = ?, fb = ?, insta = ?, tw = ?, iframe = ? WHERE sr_no = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, address);
                statement.setString(2, gmap);
                statement.setString(3, pn1);
                statement.setString(4, pn2);
                statement.setString(5, email);
                statement.setString(6, fb);
                statement.setString(7, insta);
                statement.setString(8, tw);
                statement.setString(9, iframe);
                statement.setString(10, sr_no);
                int rowsAffected = statement.executeUpdate();
                if (rowsAffected > 0) {
                    String selectSql = "SELECT * FROM contact_details WHERE sr_no = ?";
                    try (PreparedStatement selectStatement = connection.prepareStatement(selectSql)) {
                        selectStatement.setString(1, sr_no);
                        ResultSet resultSet = selectStatement.executeQuery();
                        if (resultSet.next()) {
                            Contact_1 contact = new Contact_1(); // Corrected class name
                            contact.setSr_no(resultSet.getString("sr_no"));
                            contact.setAddress(resultSet.getString("address"));
                            contact.setGmap(resultSet.getString("gmap"));
                            contact.setPn1(resultSet.getString("pn1"));
                            contact.setPn2(resultSet.getString("pn2"));
                            contact.setEmail(resultSet.getString("email"));
                            contact.setFb(resultSet.getString("fb"));
                            contact.setInsta(resultSet.getString("insta"));
                            contact.setTw(resultSet.getString("tw"));
                            contact.setIframe(resultSet.getString("iframe"));

                            request.setAttribute("contact", contact);

                            RequestDispatcher dispatcher = request.getRequestDispatcher("admin_dashboard.jsp");
                            dispatcher.forward(request, response);
                        } else {
                            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Contact details not found.");
                        }
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update contact details.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }
}
