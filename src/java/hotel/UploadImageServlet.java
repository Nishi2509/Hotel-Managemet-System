package hotel;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.sql.*;

public class UploadImageServlet extends HttpServlet {
     static {
        // Static block to load the MySQL JDBC driver
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            throw new ExceptionInInitializerError("Failed to load MySQL JDBC driver");
        }
    }
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String message = "";
        String imageFileName = "";

        // Get the image file from the request
        Part imagePart = request.getPart("imageFile");

        // Extract filename from content-disposition header of part
        String contentDisposition = imagePart.getHeader("content-disposition");
        String[] tokens = contentDisposition.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                imageFileName = token.substring(token.indexOf("=") + 2, token.length() - 1);
                break;
            }
        }

        // Define database connection parameters
        String url = "jdbc:mysql://localhost:3306/hotel";
        String username = "root";
        String password = "1234";

        try {
            // Establish database connection
            Connection con = DriverManager.getConnection(url, username, password);

            // Prepare SQL statement to insert image into database
            String sql = "INSERT INTO images (image_name, image_data) VALUES (?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, imageFileName);
            ps.setBlob(2, imagePart.getInputStream());

            // Execute SQL statement
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                message = "Image uploaded successfully!";
            } else {
                message = "Failed to upload image!";
            }

            // Close resources
            ps.close();
            con.close();
        } catch (SQLException e) {
            e.printStackTrace();
            message = "Database error: " + e.getMessage();
        }

        // Redirect back to the upload page with a message
        response.sendRedirect("upload.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
    }
}


