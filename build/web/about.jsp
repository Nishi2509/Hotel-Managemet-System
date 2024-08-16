<%-- 
    Document   : about
    Created on : 16-Apr-2024, 1:48:59 am
    Author     : admin
--%>
<%@page import="java.util.Base64"%>
<%@ page import="java.sql.*, java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>hotel-about</title>
        <%@include file="all_components/allcss.jsp"%>
        <link
         rel="stylesheet"
         href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
    </head>
    <body>
       <%@include file="all_components/navbar.jsp"%>
       <section class="about top">
    <div class="container flex p-4">
        <div class="heading text-center mb-4">
          <h1 class="fw-bold">About Us</h1>
          <p>Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt
        </div>
        
       <div class="row mt-5 justify-content-between align-items-center"> 
           <div class="col-lg-6 mb-4">
               <h3 class="mb-3">Lorem ispium dolor sit</h3>
        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis
          aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.</p>
      </div>
           <div class="col-lg-5 mb-4">
        <img src="img/about.jpg" alt="" class="w-100">
      </div>
           </div>
      
    </div>
    </section>
       
       <div class="container mt-5">
           <div class="row">
               <div class="col-lg-3 col-md-6 mb-4 px-4">
                   <div class="bg-white rounded shadow p-4 border-top border-4 text-center box">
                       <img src="img/hotel.svg" width="70px" alt="alt"/>
                       <h4>150+ Rooms</h4>
                   </div>
               </div>
               <div class="col-lg-3 col-md-6 mb-4 px-4">
                   <div class="bg-white rounded shadow p-4 border-top border-4 text-center box">
                       <img src="img/customers.svg" width="70px" alt="alt"/>
                       <h4>500+ Customers</h4>
                   </div>
               </div>
               <div class="col-lg-3 col-md-6 mb-4 px-4">
                   <div class="bg-white rounded shadow p-4 border-top border-4 text-center box">
                       <img src="img/rating.svg" width="70px" alt="alt"/>
                       <h4>300+ Reviews</h4>
                   </div>
               </div>
               <div class="col-lg-3 col-md-6 mb-4 px-4">
                   <div class="bg-white rounded shadow p-4 border-top border-4 text-center box">
                       <img src="img/staff.svg" width="70px" alt="alt"/>
                       <h4>200+ Staffs</h4>
                   </div>
               </div>
           </div>
       </div>

       <h3 class="my-5 fw-bold h-font text-center">Management Team</h3>
       
       <div class="container px-4">
           <div class="swiper mySwiper">
    <div class="swiper-wrapper mb-5">
        <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rset = null;

                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "1234");

                    String selectQuery = "SELECT * FROM team_details";
                    ps = con.prepareStatement(selectQuery);

                    rset = ps.executeQuery();
                    while (rset.next()) {
                        String name = rset.getString("name");
                        Blob pictureBlob = rset.getBlob("picture");
                        byte[] pictureBytes = pictureBlob.getBytes(1, (int) pictureBlob.length());
                        String pictureBase64 = new String(Base64.getEncoder().encode(pictureBytes));
            %>

      <div class="swiper-slide bg-white text-center overflow-hidden rounded">
          <img src="data:image/jpeg;base64,<%= pictureBase64 %>" class="w-100"/>
          <h5 class="mt-2"><%= name %></h5>
      </div>
        <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } catch (ClassNotFoundException e) {
                    e.printStackTrace();
                } finally {
                    try {
                        if (rset != null) rset.close();
                        if (ps != null) ps.close();
                        if (con != null) con.close();
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
            %>
    </div>
    <div class="swiper-pagination"></div>
  </div>
       </div>
       
       
       <%@include file="all_components/footer.jsp"%>
       
       <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

  <!-- Initialize Swiper -->
  <script>
    var swiper = new Swiper(".mySwiper", {
      slidePerView: 4,
      spaceBetween: 40,
      pagination: {
        el: ".swiper-pagination",
      },
      breakpoints: {
          320: {
              slidesPerView: 1,
          },
          640: {
              slidesPerView: 1,
          },
          768: {
              slidesPerView: 3,
          },
          1024: {
              slidesPerView: 3,
          },
      }
    });
  </script>
    </body>
</html>
