package hotel ;// Update with your package name

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout") // URL mapping for the servlet
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false); // Retrieve the session, don't create if it doesn't exist
        if (session != null) {
            session.invalidate(); // Invalidate the session
        }
        response.sendRedirect("index.jsp"); // Redirect to login page after logout
    }
}
