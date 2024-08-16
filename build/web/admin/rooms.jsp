<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Base64"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="hotel.DatabaseHelper"%> 
<%@page import="java.util.List"%>
<!-- Import DatabaseHelper -->

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rooms</title>
    <style>
        .room {
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 8px;
    padding: 20px;
    margin-bottom: 20px;
}

.room img {
    max-width: 100%;
    height: auto;
    border-radius: 8px;
    margin-bottom: 10px;
}

.room h3 {
    margin-top: 0;
    color: #333;
}

.room p {
    margin: 5px 0;
}

.room button {
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 4px;
    padding: 10px 20px;
    cursor: pointer;
    margin-right: 10px;
    transition: background-color 0.3s ease;
}

.room button:hover {
    background-color: #45a049;
}

        /* CSS for Add Room form */
        #roomForm {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }

        #roomForm label {
            font-weight: bold;
            color: #333;
        }

        #roomForm input[type="text"],
        #roomForm input[type="number"],
        #roomForm textarea,
        #roomForm select {
            width: calc(100% - 22px); /* Adjust for padding and border */
            padding: 12px;
            margin: 8px 0;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
        }

        #roomForm input[type="file"] {
            margin-top: 10px;
        }

        #roomForm select {
            appearance: none;
            background: #f9f9f9 url('down-arrow.svg') no-repeat right 12px center; /* Custom select arrow */
            background-size: 16px; /* Adjust arrow size */
            padding-right: 40px; /* Ensure space for arrow */
        }

        #roomForm input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.3s ease;
        }

        #roomForm input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Rooms</h2>

    <button onclick="toggleForm()">Add Room</button>

    <form id="roomForm" action="../AddRoomServlet" method="post" style="display: none; " enctype="multipart/form-data" >
        <label for="roomName">Room Name:</label>
        <input type="text" id="roomName" name="name" required><br>
        <label for="roomArea">Room Area:</label>
        <input type="text" id="roomArea" name="area" required><br>
        <label for="roomPrice">Room Price:</label>
        <input type="number" id="roomPrice" name="price" required><br>
        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" required><br>
        <label for="guestCapacity">Guest Capacity:</label>
        <input type="number" id="guestCapacity" name="adult" required><br>
        <label for="childrenCapacity">Children Capacity:</label>
        <input type="number" id="childrenCapacity" name="children" required><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" cols="50"></textarea><br>
        <label for="status">Status:</label>
        <select id="status" name="status">
            <option value="Available">Available</option>
            <option value="Booked">Booked</option>
            <option value="Maintenance">Maintenance</option>
        </select>
        <br>

        <!-- Select dropdown for features -->
        <label for="features">Select Features:</label>
        <select id="features" name="features" multiple required>
            <!-- Features will be populated dynamically using JavaScript -->
        </select>

        <!-- Select dropdown for facilities -->
        <label for="facilities">Select Facilities:</label>
        <select id="facilities" name="facilities" multiple required>
            <!-- Facilities will be populated dynamically using JavaScript -->
        </select>

        <!-- Add input field for image upload -->
        <label for="image">Room Image:</label>
        <input type="file" id="image" name="image" required><br>
    
        <input type="submit" value="Add Room">
    </form>

    <hr>
    <div class="room-box">
        <h2>Room Details</h2>
      <% try 
      {
  Class.forName("com.mysql.cj.jdbc.Driver");
            // Establish database connection
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_db", "root", "root");
            Statement stmt = con.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM rooms");

            // Iterate through the result set and display room details
            while (rs.next()) {
                int roomId = rs.getInt("id");
        %>
        <div class="room" id="room_<%= roomId %>">
            <% 
                byte[] imageData = rs.getBytes("image_data");
                if (imageData != null && imageData.length > 0) {
                    String base64Image = "data:image/jpeg;base64," + Base64.getEncoder().encodeToString(imageData);
            %>
            <img src="<%= base64Image %>" alt="Room Image">
            <% } else { %>
            <p>No Image Available</p>
            <% } %>
            <!-- Display room details -->
            <!-- You can customize this part according to your database schema -->
            <h3><%= rs.getString("name") %></h3>
            <p>Price: <%= rs.getInt("price") %></p>
            <p>Guest Capacity: <%= rs.getInt("adult") %></p>
            <p>Children Capacity: <%= rs.getInt("children") %></p>
            <p>Description: <%= rs.getString("description") %></p>
            <p>Status: <%= rs.getString("status") %></p>
            
            <!-- Add buttons for editing, deleting, and booking -->
            <!-- JavaScript functions for these buttons remain unchanged -->
            <button onclick="populateEditForm('<%= roomId %>')">Edit Room</button>
            <button onclick="deleteRoom('<%= roomId %>')">Delete Room</button>
            <button onclick="bookNow('<%= roomId %>', <%= rs.getInt("price") %>)">Book Now</button>
        </div>
        <% 
            }
            // Close database resources
            rs.close();
            stmt.close();
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        } %>
    </div>
</div>

    </div>
</div>

<div id="roomFormContainer" style="display: none;"></div>

<script>
    // Function to fetch and populate features select box
    function populateFeatures() {
        fetch("../GetFeaturesServlet")
            .then(response => response.text())
            .then(htmlResponse => {
                document.getElementById("features").innerHTML = htmlResponse;
            })
            .catch(error => console.error('Error:', error));
    }

    // Function to fetch and populate facilities select box
    function populateFacilities() {
        fetch("../GetFacilitiesServlet")
            .then(response => response.text())
            .then(htmlResponse => {
                document.getElementById("facilities").innerHTML = htmlResponse;
            })
            .catch(error => console.error('Error:', error));
    }

    // Call the populate functions when the page loads
    window.onload = function() {
        populateFeatures();
        populateFacilities();
    };

    function toggleForm() {
        var form = document.getElementById("roomForm");
        form.style.display = (form.style.display === "none") ? "block" : "none";
        if (form.style.display === "block") {
            // Populate features and facilities select boxes
            populateFeatures();
            populateFacilities();
        }
    }

      function toggleForm() {
        var form = document.getElementById("roomForm");
        form.style.display = (form.style.display === "none") ? "block" : "none";
    }
    function populateEditForm(roomId) {
        
    window.location.href = "../UpdateRoomServlet?roomId=" + roomId ;
   
}
   

    function deleteRoom(roomId) {
        // Confirm deletion before proceeding
        if (confirm("Are you sure you want to delete this room?")) {
            // Send AJAX request to delete the room
            fetch("../DeleteRoomServlet?roomId=" + roomId, {
                method: "DELETE"
            })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('Failed to delete room');
                    }
                    // Remove the room element from the UI
                    var roomElement = document.getElementById("room_" + roomId);
                    roomElement.parentNode.removeChild(roomElement);
                })
                .catch(error => console.error('Error:', error));
        }
    }

    function bookNow(roomId, roomPrice) {
        window.location.href = "BookingPage.jsp?roomId=" + roomId + "&roomPrice=" + roomPrice;
    }
</script>
</body>
</html>
