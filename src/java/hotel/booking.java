/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package hotel;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author admin
 */
public class booking extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get room ID from request parameter
        int roomId = Integer.parseInt(request.getParameter("id"));

    // Set room ID in session attribute
    request.getSession().setAttribute("roomId", roomId);
         
    // Forward to the booking form JSP
    request.getRequestDispatcher("booking.jsp").forward(request, response);    }

    
}
