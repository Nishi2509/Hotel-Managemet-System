 <%--
    Document   : rooms
    Created on : 16-Apr-2024, 1:03:50 am
    Author     : admin
--%>
<%@ page import="java.sql.*, javax.sql.*" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="java.net.URLEncoder" %>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hotel-Rooms</title>
        <%@include file="all_components/allcss.jsp"%>
    </head>
    <body>
        <%@include file="all_components/navbar.jsp"%>
        <div class="container p-3">
               <div class="heading text-center mb-4">
                    <h1 class="fw-bold">Our Rooms</h1>
                </div>
            </div>
           
        <div class="container p-4">
            <div class="row">
                <div class="col-lg-3 col-md-12 mb-4 mb-lg-0 px-0">
                    <nav class="navbar navbar-expand-lg navbar-light bg-white rounded shadow">
                        <div class="container-fluid flex-lg-column align-items-stretch">
                            <h4 class="mt-2">FILTERS</h4>
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#filterDropdown" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                         </button>
                        <div class="collapse navbar-collapse flex-column align-items-stretch mt-2" id="filterDropdown">
                            <div class="border bg-light p-3 rounded mb-3">
                                <h5 class="mb-3" style="font-size: 18px;">CHECK AVAILABILITY</h5>
                                <label class="form-label">Check-in</label>
                                <input type="date" class="form-control shadow-none mb-3">
                                <label class="form-label">Check-out</label>
                                <input type="date" class="form-control shadow-none">
                            </div>
                            <div class="border bg-light p-3 rounded mb-3">
                                <h5 class="mb-3" style="font-size: 18px;">FACILITIES</h5>
                                <div class="mb-2 ml-3">
                                    <input type="checkbox" id="f1" class="form-check-input shadow-none me-1">
                                    <label class="form-check-label" for="f1">Facility one</label>
                                </div>
                                <div class="mb-2 ml-3">
                                    <input type="checkbox" id="f2" class="form-check-input shadow-none me-1">
                                    <label class="form-check-label" for="f2">Facility two</label>
                                </div>
                                <div class="mb-2 ml-3">
                                    <input type="checkbox" id="f3" class="form-check-input shadow-none me-1">
                                    <label class="form-check-label" for="f3">Facility three</label>
                                </div>
                            </div>
                            <div class="border bg-light p-3 rounded mb-3">
                                <h5 class="mb-3" style="font-size: 18px;">GUESTS</h5>
                                <div class="d-flex">
                                    <div class="me-3">
                                      <label class="form-label">Adults</label>
                                      <input type="number" class="form-control shadow-none">
                                    </div>
                                    <div>
                                       <label class="form-label">Childrens</label>
                                       <input type="number" class="form-control shadow-none">
                                    </div>
                                </div>
                               
                            </div>
                        </div>
                        </div>
                        </nav>
                </div>
                                   
                <div class="col-lg-9 col-md-12 px-4">
                    <%
                     try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/hotel_db";
                String username = "root";
                String password = "1234";
                Connection con = DriverManager.getConnection(url, username, password);
                Statement stmt = con.createStatement();

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
                             "GROUP BY r.id";
                ResultSet rset = stmt.executeQuery(sql);
                List<String> featuresList = new ArrayList<>();
                List<String> facilitiesList = new ArrayList<>();

                while (rset.next()) {
                    // Fetch room details
                    int roomId = rset.getInt("id");
                    String name = rset.getString("name");
                    int price = rset.getInt("price");
                    int adult = rset.getInt("adult");
                    int children = rset.getInt("children");
                    byte[] imageData = rset.getBytes("image_data");
                    String pictureBase64 = null;
                    if (imageData != null && imageData.length > 0) {
                        pictureBase64 = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imageData);
                    }

                    // Fetch features and facilities
                    String featureNames = rset.getString("feature_names");
                    String facilityNames = rset.getString("facility_names");
                    if (featureNames != null && facilityNames != null) {
                        featuresList = Arrays.asList(featureNames.split(","));
                        facilitiesList = Arrays.asList(facilityNames.split(","));
                    }

                    // Set session attributes
                    session.setAttribute("roomId_" + roomId, roomId);
                    session.setAttribute("roomName_" + roomId, name);
                    session.setAttribute("roomPrice_" + roomId, price);
                    session.setAttribute("roomImage_" + roomId, pictureBase64);
                    %>
                    <!-- Card for each room -->
                    <div class="card mb-4 border-0 shadow">
                        <div class="row g-0 p-3 align-items-center">
                            <div class="col-md-5">
                                <img src="<%= pictureBase64 %>" class="img-fluid rounded" alt="...">
                            </div>
                            <div class="col-md-5">
                                <h5 class="mb-3"><%=name%></h5>
                                <div class="features mb-3">
                                    <h6 class="mb-1">Features</h6>
                                    <% for (String feature : featuresList) { %>
                                        <span class="badge rounded-pill bg-light text-dark text-wrap">
                                            <%=feature%>
                                        </span>
                                    <% } %>
                                </div>
                                <div class="facilities mb-2">
                                    <h6 class="mb-1">Facilities</h6>
                                    <% for (String facility : facilitiesList) { %>
                                        <span class="badge rounded-pill bg-light text-dark text-wrap">
                                            <%=facility%>
                                        </span>
                                    <% } %>
                                </div>
                                <div class="guests mb-3">
                                    <h6 class="mb-1">Guests</h6>
                                    <span class="badge rounded-pill bg-light text-dark text-wrap">
                                        <%=adult%> Adults
                                    </span>
                                    <span class="badge rounded-pill bg-light text-dark text-wrap">
                                        <%=children%> Childrens
                                    </span>
                                </div>
                            </div>
                            <div class="col-md-2 text-center">
                                <h6>Rs <%=price%>/night</h6>
                                <a href="booking.jsp?id=<%= roomId %>" class="btn btn-primary btn-sm w-100 mb-2">Book Now</a>
                                <a href="#" class="btn btn-sm btn-outline-dark w-100 shadow-none">More details</a>
                            </div>
                        </div>
                    </div>
                    <%
                } // End while
                rset.close();
                stmt.close();
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
            %>
        </div>
    </div>
</div>

<%@include file="all_components/footer.jsp"%>
<script>
// Function to apply filters when the user clicks the "Apply" button
function applyFilters() {
    // Get filter values
    var checkInDate = document.getElementById("checkInDate").value;
    var checkOutDate = document.getElementById("checkOutDate").value;
    var facilityOne = document.getElementById("f1").checked;
    var facilityTwo = document.getElementById("f2").checked;
    var facilityThree = document.getElementById("f3").checked;
    var adultsCount = document.getElementById("adultsCount").value;
    var childrenCount = document.getElementById("childrenCount").value;

    // Construct the request URL with query parameters
    var url = "../FilterRoomsServlet?checkInDate=" + checkInDate + "&checkOutDate=" + checkOutDate +
              "&facilityOne=" + facilityOne + "&facilityTwo=" + facilityTwo + "&facilityThree=" + facilityThree +
              "&adultsCount=" + adultsCount + "&childrenCount=" + childrenCount;

    // Send AJAX request to fetch available rooms
    fetch(url)
        .then(response => response.json())
        .then(data => {
            // Update room display with available rooms
            displayAvailableRooms(data);
        })
        .catch(error => console.error('Error:', error));
}

// Function to display available rooms
function displayAvailableRooms(data) {
    // Clear existing room display
    var roomBox = document.getElementById("roomBox");
    roomBox.innerHTML = "";

    // Loop through available rooms and display each one
    data.forEach(room => {
        // Create HTML elements to display room details
        var roomElement = document.createElement("div");
        roomElement.classList.add("room");
        // Add room details to room element
        roomElement.innerHTML = `
            <!-- Room details here -->
        `;
        // Append room element to room box
        roomBox.appendChild(roomElement);
    });
}
    </script>

</body>
</html>