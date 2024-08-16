<%@page import="java.util.Base64"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.ServletException" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Check if userId is present in the session
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        // User is not logged in, redirect to login page
        response.sendRedirect("login.jsp");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Booking</title>
    <%@include file="all_components/allcss.jsp"%>
</head>
<body>
    <%@include file="all_components/navbar.jsp"%>
   
    <section class="booking"> 
        <div class="container p-3">
            <div class="heading text-center mb-4">
                <h1 class="fw-bold">Booking Details</h1>
            </div>
        </div>
        <%
            // Check if roomId is present in the session
            Integer roomId = (Integer) session.getAttribute("roomId");
            if (roomId != null) {
                try {
                    // Load database driver and establish connection
                    Class.forName("com.mysql.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/hotel_db";
                    String username = "root";
                    String password = "1234";
                    Connection con = DriverManager.getConnection(url, username, password);
                    Statement stmt = con.createStatement();

                    // Retrieve room details from the database based on roomId
                    String sql = "SELECT * FROM rooms WHERE id = " + roomId;
                    ResultSet rset = stmt.executeQuery(sql);

                    if (rset.next()) {
                        int rid = rset.getInt("id");
                        String name = rset.getString("name");
                        int price = rset.getInt("price");
                        byte[] imagedata = rset.getBytes("image_data");
                        String pictureBase64 = null;
                        if (imagedata != null && imagedata.length > 0) {
                            pictureBase64 = "data:image/jpeg:base64," + Base64.getEncoder().encodeToString(imagedata);
                        }
        %>
        <div class="container">
            <div class="row ">
                <div class="col-lg-6 col-md-8 mb-5 px-4 ">
                    <div class="card border-0 shadow" style="max-width: 350px; margin: auto;">
                        <img src="<%= pictureBase64 %>" class="card-img-top" alt="...">
                    </div>
                    <div class="text-center">
                        <div class="mt-3">
                            <h5>Name: <%= name %>  </h5> 
                        </div>
                        <div class="mt-3">
                            <h5>Price:  Rs <%= price %> per night</h5> 
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-8 mb-5 px-4 text-center">
                    <div class="bg-white rounded shadow p-4">
                        <form action="checkAvailability" method="post">
                            <input type="hidden" name="roomId" value="<%= rid %>">
                            <input type="hidden" name="price" value="<%= price %>">
                            <h5>Fill Details Here </h5>
                            <div class="mt-3">
                                <label class="form-label" style="font-weight: 500;">Name</label>
                                <input type="text" name="name" class="form-control shadow-none">  
                            </div>
                            <div>
                                <label class="form-label" style="font-weight: 500;">Phone Number</label>
                                <input type="text" name="phoneno" class="form-control shadow-none">
                            </div>
                            <div>
                                <label class="form-label" style="font-weight: 500;">Email</label>
                                <input type="email" name="email" class="form-control shadow-none">
                            </div>
                            <div>
                                <label class="form-label" style="font-weight: 500;">Address</label>
                                <textarea name="address" class="form-control shadow-none" rows="1" style="resize: none;"></textarea>
                            </div>
                            <div>
                                <label class="form-label" style="font-weight: 500;">Check-in</label>
                                <input type="date" name="checkIn" class="form-control shadow-none mb-1">
                                <label class="form-label" style="font-weight: 500;">Check-out</label>
                                <input type="date" name="checkOut" class="form-control shadow-none mb-1">
                            </div>
                            <button type="submit" class="btn text-white custom-bg mt-3">Payment Processed</button>
                        </form>
                        <div class="mb-3 mt-2 text-danger">
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
            </div>
        </div>
        <%
                    }
                    rset.close();
                    stmt.close();
                    con.close();
                } catch (ClassNotFoundException | SQLException e) {
                    // Handle database errors
                    out.println("An error occurred while processing your request. Please try again later.");
                    e.printStackTrace();
                }
            } else {
                // Room ID not found in session
                out.println("Room ID not found in session.");
            }
        %>
    </section>
    
    <%@include file="all_components/footer.jsp"%>
</body>
</html>
