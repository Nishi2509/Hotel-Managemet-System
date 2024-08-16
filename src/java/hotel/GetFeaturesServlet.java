package hotel;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetFeaturesServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve features from the database
        List<String> features = DatabaseHelper.getAllFeatures();
        
        // Output the features as HTML options
        PrintWriter out = response.getWriter();
        for (String feature : features) {
            out.println("<option value='" + feature + "'>" + feature + "</option>");
        }
    }
}
