<%-- 
    Document   : index
    Created on : 11-Apr-2024, 12:51:21 am
    Author     : admin
--%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Royal Hotel</title>
  <%@include file="all_components/allcss.jsp"%>
  <link
  rel="stylesheet"
  href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"/>
  
  <style type="text/css">
      .back-img{
          background: url("img/banner-2.png");
          height: 80vh;
          width: 100%;
          background-repeat: no-repeat;
          background-size: cover;
      }
  </style>
</head>
 <%
                    Class.forName("com.mysql.jdbc.Driver");
                    String url = "jdbc:mysql://localhost:3306/hotel_db";
                    String username = "root";
                    String password = "1234";
                    Connection con = DriverManager.getConnection(url, username, password);
                    Statement stmt = con.createStatement();
%>
<body class="bg-light">
  <%@include file="all_components/navbar.jsp"%>
  <div class="conatainer-fluid back-img">
      <h1 class="text-center text-white text">Welcome to Hotel Royal Palace</h1>
      <h2 class="text-center text-white"> ${sessionScope.username}</h2>
  </div>
  
  <section class="book">
    <div class="container flex_space">
      <div class="text">
        <h1> <span>Book </span> Your Rooms </h1>
      </div>
      <div class="form" action="RoomAvailability" method="post">
          <form class="grid" action="rooms.jsp" method="get">
          <input type="date" name="arrivalDate" placeholder="Araival Date">
          <input type="date" name="departureDate" placeholder="Departure Date">
          <input type="number" name="adults" placeholder="Adults">
          <input type="number" name="children" placeholder="Childern">
          <input type="submit" value="CHECK AVAILABILITY">
        </form>
      </div>
    </div>
  </section>
  
  <!-- Our rooms -->
 
  <section class="rooms">
      <h2 class="mt-5 pt-4 mb-4 text-center fw-bold h-font">Our Rooms</h2>
      
      <div class="container">
          <div class="row">
              <div class="col-lg-4 col-md-6 my-3">
                  <% 
                      String sql = "SELECT r.*, " +
                                 "GROUP_CONCAT(DISTINCT rf.feature_id) AS features, " +
                                 "GROUP_CONCAT(DISTINCT rf2.facility_id) AS facilities, " +
                                 "GROUP_CONCAT(DISTINCT f.name) AS feature_names, " +
                                 "GROUP_CONCAT(DISTINCT f2.name) AS facility_names " +
                                 "FROM rooms r " +
                                 "LEFT JOIN room_features rf ON r.id = rf.room_id " +
                                 "LEFT JOIN room_facilities rf2 ON r.id = rf2.room_id " +
                                 "LEFT JOIN features f ON rf.feature_id = f.id " +
                                 "LEFT JOIN facilities f2 ON rf2.facility_id = f2.id " +
                                 "GROUP BY r.id" ;
                    ResultSet rset = stmt.executeQuery(sql);

                    while (rset.next()) {
                       int roomId = rset.getInt("id");
            String name = rset.getString("name");
            int price = rset.getInt("price");
            String featureNames = rset.getString("feature_names");
            String facilityNames = rset.getString("facility_names");
            Blob image = rset.getBlob("image_data");
            
            String pictureBase64 = "";
            List<String> featuresList = new ArrayList<>();
            List<String> facilitiesList = new ArrayList<>();

            if (featureNames != null) {
                featuresList = Arrays.asList(featureNames.split(","));
            }

            if (facilityNames != null) {
                facilitiesList = Arrays.asList(facilityNames.split(","));
            }

            if (image != null) {
                byte[] pictureBytes = image.getBytes(1, (int) image.length());
                pictureBase64 = new String(Base64.getEncoder().encode(pictureBytes));
            }

                        %>
                  <div class="card border-0 shadow" style="max-width: 350px; margin: auto;">
                     <img src="<%= pictureBase64 %>" class="card-img-top" alt="...">
                     <div class="card-body">
                       <h5><%=name%></h5>
                       <h6 class="mb-4">Rs. <%=price%> per night</h6>
                       <div class="features mb-4">
                           <h6 class="mb-1">Features</h6>
                           <% 
                               for (String feature : featuresList) { 
                           %>
                           <span class="badge rounded-pill bg-light text-dark text-wrap">
                               <%=feature%>
                           </span>
                           <% 
                                } 
                           %>
                       </div>
                       <div class="facilities mb-4">
                           <h6 class="mb-1">Facilities</h6>
                           <% 
                                for (String facility : facilitiesList) { 
                            %>
                           <span class="badge rounded-pill bg-light text-dark text-wrap">
                               Wifi
                           </span>
                           <% 
                                } 
                           %>
                       </div>
                       <div class="text-center mb-2">
                           <a href="booking?id=<%= roomId %>" class="btn btn-primary btn-sm">Book Now</a>
                       </div>
                       
                   </div>
               </div>
              </div>
              <%
                    }

                    rset.close();
                    stmt.close();
                    con.close();
                %>  
               
              <div class="col-lg-12 text-center mt-5">
                  <a href="rooms.jsp" class="btn btn-sm btn-outline-dark rounded-0 fw-bold shadow-none">More Rooms >>></a>
              </div>
          </div>
      </div>
  </section>
     
    <!-- Facilites -->
    <h2 class="mt-5 pt-4 mb-4 text-center fw-bold h-font">Facilites</h2> 
    
    <div class="container">
        <div class="row justify-content-evenly px-lg-0 px-md-0 px-5">
            <%
                        
                        PreparedStatement ps = null;
                       

                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "1234");
                            String selectQuery = "SELECT * FROM facilities LIMIT 5";
                            ps = con.prepareStatement(selectQuery);

                            rset = ps.executeQuery();
                           while (rset.next()) {
                                    String name = rset.getString("name");
                                    String icon = rset.getString("icon");
                    %>
            <div class="col-lg-2 col-md-2 text-center bg-white rounded shadow py-4 my-3">
                <img src="<%= rset.getString("icon") %>" width="80px" alt="alt"/>
                <h5 class="mt-3"><%= rset.getString("name") %></h5>
            </div>
            <%
             }
                        } catch (SQLException e) {
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
    </div>
    
    <!-- Testimonials -->
    <h2 class="mt-5 pt-4 mb-4 text-center fw-bold h-font">Testimonials</h2> 
    
    <div class="container">
        <div class="swiper swiper-testimonials">
    <div class="swiper-wrapper mb-5">
      <div class="swiper-slide bg-white p-4">
          <div class="profile d-flex align-items-center mb-3">
              <img src="img/wifi.svg" width="30px" alt="alt"/>
              <h6 class="m-0 ms-2">Random user1</h6>
          </div>
          <p>
              abgddan ax bhggabs nhbadjn,jdgykmms.
              susansamjy jshahs  miyqrsx  hsfqhsjk mhsay. 
          </p>
          <div class="rating">
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
          </div>
      </div>
      <div class="swiper-slide bg-white p-4">
          <div class="profile d-flex align-items-center mb-3">
              <img src="img/wifi.svg" width="30px" alt="alt"/>
              <h6 class="m-0 ms-2">Random user1</h6>
          </div>
          <p>
              abgddan ax bhggabs nhbadjn,jdgykmms.
              susansamjy jshahs  miyqrsx  hsfqhsjk mhsay. 
          </p>
          <div class="rating">
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
          </div>
      </div>
        <div class="swiper-slide bg-white p-4">
          <div class="profile d-flex align-items-center mb-3">
              <img src="img/wifi.svg" width="30px" alt="alt"/>
              <h6 class="m-0 ms-2">Random user1</h6>
          </div>
          <p>
              abgddan ax bhggabs nhbadjn,jdgykmms.
              susansamjy jshahs  miyqrsx  hsfqhsjk mhsay. 
          </p>
          <div class="rating">
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
          </div>
      </div>
        <div class="swiper-slide bg-white p-4">
          <div class="profile d-flex align-items-center mb-3">
              <img src="img/wifi.svg" width="30px" alt="alt"/>
              <h6 class="m-0 ms-2">Random user1</h6>
          </div>
          <p>
              abgddan ax bhggabs nhbadjn,jdgykmms.
              susansamjy jshahs  miyqrsx  hsfqhsjk mhsay. 
          </p>
          <div class="rating">
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
              <i class="fa-sharp fa-solid fa-star text-warning"></i>
          </div>
      </div>
    </div>
    <div class="swiper-pagination"></div>
  </div>

    </div>
  <br><br><br>
  
  
 <script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script> 
 
 <script>
    var swiper = new Swiper(".swiper-testimonials", {
      effect: "coverflow",
      grabCursor: true,
      centeredSlides: true,
      slidesPerView: "auto",
      slidesPerView: "3",
      loop: true,
      coverflowEffect: {
        rotate: 50,
        stretch: 0,
        depth: 100,
        modifier: 1,
        slideShadows: false,
      },
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
              slidesPerView: 2,
          },
          1024: {
              slidesPerView: 3,
          }
      }
    });
  </script>
  <%@include file="all_components/footer.jsp" %>
</body>

</html>
