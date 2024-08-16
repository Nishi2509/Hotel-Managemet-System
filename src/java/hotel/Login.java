/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package hotel;

import javax.servlet.*;
import java.sql.*;
import java.io.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.RequestDispatcher;
import java.sql.DriverManager;

public class Login extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    PrintWriter out = response.getWriter();
    String email = request.getParameter("email");
    String pass = request.getParameter("pass");

    try  {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(Login.class.getName()).log(Level.SEVERE, null, ex);
        }
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "1234");
        try (PreparedStatement psAdmin = con.prepareStatement("SELECT * FROM admin WHERE email=? AND pass=?")) {
            psAdmin.setString(1, email);
            psAdmin.setString(2, pass);
            try (ResultSet rsAdmin = psAdmin.executeQuery()) {
                if (rsAdmin.next()) {
                    // Admin login successful
                    request.getSession().setAttribute("isAdmin", true);
                    request.getRequestDispatcher("admin/admin_dashboard.jsp").forward(request, response);
                } else {
                    PreparedStatement psUser = con.prepareStatement("SELECT id,uname FROM users WHERE email=? AND pass=?");
                    psUser.setString(1, email);
                    psUser.setString(2, pass);
                    ResultSet rsUser = psUser.executeQuery();
                    
                    if (rsUser.next()) {
                        // User login successful
                        int userId = rsUser.getInt("id");
                        String username = rsUser.getString("uname");
                        request.getSession().setAttribute("isAdmin", false);
                        request.getSession().setAttribute("username", username);
                        request.getSession().setAttribute("userId", userId);
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    } else {
                        // Neither admin nor user found, show error message
                        request.getSession().setAttribute("loginfailed", "Email or Password Invalid");
                        request.getRequestDispatcher("login.jsp").include(request, response);
                    }
                    
                    rsUser.close();
                    psUser.close();
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Database error: " + e.getMessage());
    }
}

}