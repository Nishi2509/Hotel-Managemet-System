package hotel;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FilterRoomsServlet")
public class FilterRoomsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve filter parameters from the request
        String checkInDate = request.getParameter("checkInDate");
        String checkOutDate = request.getParameter("checkOutDate");

        // Implement your filtering logic here
        // For this example, let's assume we retrieve all rooms from the database
        // You would replace this with your actual filtering logic
        String htmlResponse = retrieveFilteredRoomsFromDatabase(checkInDate, checkOutDate);

        // Set response content type
        response.setContentType("text/html");

        // Write filtered room data as HTML response
        PrintWriter out = response.getWriter();
        out.println(htmlResponse);
    }

    // Method to retrieve filtered rooms from the database
    private String retrieveFilteredRoomsFromDatabase(String checkInDate, String checkOutDate) {
        StringBuilder htmlResponse = new StringBuilder();

        // Establish database connection
        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "1234")) {
            // Execute SQL query to retrieve filtered rooms based on check-in and check-out dates
            String sql = "SELECT * FROM rooms";
            PreparedStatement pstmt = con.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();

            // Loop through the result set and generate HTML for each room
            while (rs.next()) {
                int roomId = rs.getInt("id");
                String name = rs.getString("name");
                int price = rs.getInt("price");
                byte[] imageData = rs.getBytes("image_data");

                // Encode image data in Base64 format
                String pictureBase64 = "";
                if (imageData != null && imageData.length > 0) {
                    pictureBase64 = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imageData);
                }

                // Append room HTML to the response
                htmlResponse.append("<div class=\"card mb-4 border-0 shadow\">");
                htmlResponse.append("<div class=\"row g-0 p-3 align-items-center\">");
                htmlResponse.append("<div class=\"col-md-5\">");
                htmlResponse.append("<img src=\"" + pictureBase64 + "\" class=\"img-fluid rounded\" alt=\"Room Image\">");
                htmlResponse.append("</div>");
                htmlResponse.append("<div class=\"col-md-5\">");
                htmlResponse.append("<h5 class=\"mb-3\">" + name + "</h5>");
                htmlResponse.append("<h6>Rs " + price + "/night</h6>");
                htmlResponse.append("<a href=\"booking?id=" + roomId + "\" class=\"btn btn-primary btn-sm w-100 mb-2\">Book Now</a>");
                htmlResponse.append("</div>");
                htmlResponse.append("</div>");
                htmlResponse.append("</div>");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return htmlResponse.toString();
    }
}
