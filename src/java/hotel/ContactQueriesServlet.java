package hotel;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/contactQueries")
public class ContactQueriesServlet extends HttpServlet {
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/hotel_db";
    private static final String JDBC_USERNAME = "root";
    private static final String JDBC_PASSWORD = "1234";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("markAsRead".equals(action)) {
            int queryId = Integer.parseInt(request.getParameter("queryId"));
            markQueryAsRead(queryId);
        } else if ("deleteQuery".equals(action)) {
            int queryId = Integer.parseInt(request.getParameter("queryId"));
            deleteQuery(queryId);
        }

        // Fetch contact queries from the database
        List<ContactQuery> queries = getAllQueries();

        // Set the queries as an attribute in the request
        request.setAttribute("queries", queries);

        // Forward the request to the JSP page for display
        request.getRequestDispatcher("/contact_queries.jsp").forward(request, response);
    }

    private void markQueryAsRead(int queryId) {
        // Update the 'seen' status of the query in the database
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement("UPDATE contact_queries SET seen = true WHERE sr_no = ?")) {
            statement.setInt(1, queryId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private void deleteQuery(int queryId) {
        // Delete the query from the database
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement("DELETE FROM contact_queries WHERE sr_no = ?")) {
            statement.setInt(1, queryId);
            statement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private List<ContactQuery> getAllQueries() {
        List<ContactQuery> queries = new ArrayList<>();
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USERNAME, JDBC_PASSWORD);
             PreparedStatement statement = connection.prepareStatement("SELECT sr_no, name, email, subject, message, date, seen FROM contact_queries");
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                int srNo = resultSet.getInt("sr_no");
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String subject = resultSet.getString("subject");
                String message = resultSet.getString("message");
                String date = resultSet.getString("date");
                boolean seen = resultSet.getBoolean("seen");

                ContactQuery queryObj = new ContactQuery(srNo, name, email, subject, message, date, seen);
                queries.add(queryObj);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return queries;
    }
}
