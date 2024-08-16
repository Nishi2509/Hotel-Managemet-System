
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package hotel;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class contact extends HttpServlet {
    
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher rd;
        PrintWriter out = response.getWriter();
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        HttpSession session= request.getSession();
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "1234");
            PreparedStatement ps = con.prepareStatement("INSERT INTO user_queries(name, email, subject, message, regdate) VALUES (?, ?, ?, ?, CURDATE())");
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, subject);
            ps.setString(4, message);
            
        int i = ps.executeUpdate();
        if (i > 0) {
            session.setAttribute("SentMsg", "Message Sent Successfully!");
            rd = request.getRequestDispatcher("contact.jsp");
            rd.include(request, response);
        } else {
            session.setAttribute("Msgfailed", "Message not sended! Please Try Again...");
            rd=request.getRequestDispatcher("contact.jsp");
            rd.include(request, response);
        }
        ps.close();
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Database error: " + e.getMessage());
    } catch (ClassNotFoundException ex) {
        Logger.getLogger(registration.class.getName()).log(Level.SEVERE, null, ex);
    }
}
}
