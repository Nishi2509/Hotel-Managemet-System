package hotel;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetFacilitiesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve facilities from the database
        List<String> facilities = DatabaseHelper.getAllFacilities();
        
        // Output the facilities as HTML options
        PrintWriter out = response.getWriter();
        for (String facility : facilities) {
            // Output each facility as an option
            out.println("<option value='" + facility + "'>" + facility + "</option>");
        }
    }
}
