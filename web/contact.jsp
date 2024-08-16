<%-- 
    Document   : contact
    Created on : 16-Apr-2024, 6:04:10 pm
    Author     : admin
--%>
<%@page import="java.sql.*"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.util.List" %>

<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact Us</title>
        <%@include file="all_components/allcss.jsp"%>
      
    </head>
    <body>
        <%@include file="all_components/navbar.jsp"%>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "1234");
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from contact_details");
                if (rs.next()) {
                    // Display user data
        %>
        <section class="about top">
            <div class="container flex p-4">
               <div class="heading text-center mb-4">
                    <h1 class="fw-bold">Contact Us</h1>
                    <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt
                </div>
            </div>
            
            <div class="container">
                <div class="row">
                    <div class="col-lg-6 col-md-6 mb-5 px-4">
                        <div class="bg-white rounded shadow p-4">
                            
                            <iframe class="w-100 rounded mb-4" height="320" src="<%= rs.getString("iframe") %>"></iframe>
                            <h5>Address</h5>
                            
                            <a href="<%= rs.getString("gmap") %>" target="_blank" class="d-inline-block text-decoration-none text-dark mb-2">
                                <i class="fa-solid fa-location-dot"></i> <%= rs.getString("address") %> 
                            </a>
                        
                            <h5 class="mt-4">Call Us</h5>
                                <a href="tel: <%= rs.getString("pn1") %>" class="d-inline-block mb-2 text-decoration-none text-dark"><i class="fa-solid fa-phone me-1"></i> <%= rs.getString("pn1") %></a><br>
                                <a href="tel: <%= rs.getString("pn2") %>" class="d-inline-block mb-2 text-decoration-none text-dark"><i class="fa-solid fa-phone me-1"></i> <%= rs.getString("pn2") %></a>
                            <h5 class="mt-4">Email</h5>
                            <a href="mailto: <%= rs.getString("email") %>" class="d-inline-block mb-2 text-decoration-none text-dark"> 
                                <i class="fa-solid fa-envelope"></i> <%= rs.getString("email") %></a>
                            <h5 class="mt-4">Follow Us</h5>
                                <a href="<%= rs.getString("tw") %>" class="d-inline-block text-dark fs-5 me-2">
                                    <i class="fa-brands fa-twitter me-1"></i>
                                </a>
                                <a href="<%= rs.getString("fb") %>" class="d-inline-block text-dark fs-5 me-2">
                                    <i class="fa-brands fa-facebook me-1"></i>
                                </a>
                                <a href="<%= rs.getString("insta") %>" class="d-inline-block text-dark fs-5">
                                    <i class="fa-brands fa-instagram me-1"></i>
                                </a>
                            <%
                                } 
                                } catch(ClassNotFoundException | SQLException e) {
                                     e.printStackTrace();
                                     out.println("Error accessing database");
                             }
                            %>
                        </div> 
                    </div>
                    
                    <div class="col-lg-6 col-md-6 mb-5 px-4">
                        <div class="bg-white rounded shadow p-4">
                            <form action="contact" method="post">
                                <h5>Send a message</h5>
                                <div class="mt-3">
                                    <label class="form-label" style="font-weight: 500;">Name</label>
                                    <input type="text" name="name" class="form-control shadow-none">  
                                </div>
                                <div>
                                    <label class="form-label" style="font-weight: 500;">Email</label>
                                    <input type="email" name="email" class="form-control shadow-none">
                                </div>
                                <div>
                                    <label class="form-label" style="font-weight: 500;">Subject</label>
                                    <input type="text" name="subject" class="form-control shadow-none">
                                </div>
                                <div>
                                    <label class="form-label" style="font-weight: 500;">Message</label>
                                    <textarea name="message" class="form-control shadow-none" rows="3" style="resize: none;"></textarea>
                                </div>
                                <button type="submit" class="btn text-white custom-bg mt-3">SEND</button>
                            </form>
                        </div>
                        <% if (session.getAttribute("SentMsg") != null) { %>
                        <div class="alert alert-success" role="alert">
                        <%-- Display the success message --%>
                        <%= session.getAttribute("SentMsg") %>
                        </div>
                        <%-- Remove the session attribute to avoid displaying the message again --%>
                        <% session.removeAttribute("SentMsg"); %>
                        <% } %>
                        
                        <% if (session.getAttribute("regfailed") != null) { %>
                        <div class="alert alert-success" role="alert">
                        <%-- Display the success message --%>
                        <%= session.getAttribute("regfailed") %>
                        </div>
                        <%-- Remove the session attribute to avoid displaying the message again --%>
                        <% session.removeAttribute("regfailed"); %>
                        <% } %>
                    </div>
                </div>
            </div>
        </section>
        
        <%@include file="all_components/footer.jsp"%>
    </body>
</html>
