<%-- 
    Document   : footer
    Created on : 11-Apr-2024, 5:42:44 pm
    Author     : admin
--%>
<%@ page import="java.sql.*, java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>footer</title>
    </head>
    <body>
        <footer class="p-2">
            
    <!-- Testimonials -->
    <h2 class="text-center fw-bold h-font mb-3">Reach Us</h2>
    
    <%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "1234");

        String selectQuery = "SELECT * FROM contact_details WHERE sr_no=?";
        pstmt = conn.prepareStatement(selectQuery);
        pstmt.setInt(1, 1); // Assuming 1 is the sr_no you want to select

        rs = pstmt.executeQuery();
        if (rs.next()) {
            String address = rs.getString("address");
            String gmap = rs.getString("gmap");
            String pn1 = rs.getString("pn1");
            String pn2 = rs.getString("pn2");
            String email = rs.getString("email");
            String fb = rs.getString("fb");
            String insta = rs.getString("insta");
            String tw = rs.getString("tw");
            String iframe = rs.getString("iframe");
    %>

    
    <div class="container">
        <div class="row">
            <div class="col-lg-6 col-md-6 p-4 mb-lg-0 mb-3 rounded">
                <iframe class="w-100 rounded" height="320" src="<%= iframe %>" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
            </div>
            <div class="col-lg-3 col-md-4">
                <div class="p-4 rounded mb-4">
                    <h5>Call Us</h5>
                    <a href="tel: <%= pn1 %>" class="d-inline-block mb-2 text text-decoration-none text-white"><i class="fa-solid fa-phone me-1"></i> <%= pn1 %></a><br>
                  <% if (!pn2.isEmpty()) { %>
                    <a href="tel: <%= pn2 %>" class="d-inline-block text text-decoration-none text-white"><i class="fa-solid fa-phone me-1"></i> <%= pn2 %></a>
                  <% } %>
                </div>
                <div class="p-4 rounded mb-4">
                    <h5>Follow Us</h5>
                    <% if (!tw.isEmpty()) { %>
                    <a href="<%= tw %>" class="d-inline-block mb-2">
                        <span class="badge text-white fs-6 p-2">
                            <i class="fa-brands fa-twitter me-1"></i> Twitter
                        </span>
                    </a><br>
                    <% } %>
                    <% if (!fb.isEmpty()) { %>
                    <a href="<%= fb %>" class="d-inline-block mb-2">
                        <span class="badge text-white fs-6 p-2">
                            <i class="fa-brands fa-facebook me-1"></i> Facebook
                        </span>
                    </a><br>
                    <% } %>
                    <% if (!insta.isEmpty()) { %>
                    <a href="<%= insta %>" class="d-inline-block mb-2">
                        <span class="badge text-white fs-6 p-2">
                            <i class="fa-brands fa-instagram me-1"></i> Instagram
                        </span>
                    </a>
                    <% } %>
                </div>   
            </div>
            <div class="col-lg-2 col-md-2">
                <div class="p-4 rounded mb-4">
                    <h5>Links</h5>
                    <a href="index.jsp" class="d-inline-block mb-2">
                        <span class="badge text-white fs-6 p-2">
                             Home
                        </span>
                    </a><br>
                    <a href="rooms.jsp" class="d-inline-block mb-2">
                        <span class="badge text-white fs-6 p-2">
                             Rooms
                        </span>
                    </a><br>
                    <a href="services.jsp" class="d-inline-block mb-2">
                        <span class="badge text-white fs-6 p-2">
                             Services
                        </span>
                    </a><br>
                    <a href="about.jsp" class="d-inline-block mb-2">
                        <span class="badge text-white fs-6 p-2">
                             About Us
                        </span>
                    </a>
                </div>   
            </div>
        </div>
    </div>

    <%
        } else {
            out.println("No contact details found");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } finally {
        try {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
   %>

  <div class="legal">
    <p class="container">Copyright (c) 2022 Copyright Holder All Rights Reserved.</p>
  </div>

   <script src="https://kit.fontawesome.com/032d11eac3.js" crossorigin="anonymous"></script>
        </footer>
    </body>
</html>