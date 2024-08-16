<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Room</title>
</head>
<body>
    <h2>Edit Room</h2>
    <form id="editRoomForm" action="UpdateRoomServlet" method="post">
        <%-- Include a hidden input field to store the roomId --%>
        <input type="hidden" id="roomId" name="roomId" value="<%= request.getParameter("roomId") %>">
        
        <%-- Include input fields for room details, prepopulated with data from the request parameters --%>
        <label for="roomName">Room Name:</label>
        <input type="text" id="roomName" name="name" value="<%= request.getParameter("name") %>"><br>
        
        <label for="roomArea">Room Area:</label>
        <input type="text" id="roomArea" name="area" value="<%= request.getParameter("area") %>"><br>
        
        <label for="roomPrice">Room Price:</label>
        <input type="number" id="roomPrice" name="price" value="<%= request.getParameter("price") %>"><br>
        
        <label for="quantity">Quantity:</label>
        <input type="number" id="quantity" name="quantity" value="<%= request.getParameter("quantity") %>"><br>
        
        <label for="guestCapacity">Guest Capacity:</label>
        <input type="number" id="guestCapacity" name="adult" value="<%= request.getParameter("adult") %>"><br>
        
        <label for="childrenCapacity">Children Capacity:</label>
        <input type="number" id="childrenCapacity" name="children" value="<%= request.getParameter("children") %>"><br>
        
        <label for="description">Description:</label>
        <textarea id="description" name="description" rows="4" cols="50"><%= request.getParameter("description") %></textarea><br>
        
        <label for="status">Status:</label>
        <select id="status" name="status">
            <option value="Available" <%= request.getParameter("status").equals("Available") ? "selected" : "" %>>Available</option>
            <option value="Booked" <%= request.getParameter("status").equals("Booked") ? "selected" : "" %>>Booked</option>
            <option value="Maintenance" <%= request.getParameter("status").equals("Maintenance") ? "selected" : "" %>>Maintenance</option>
        </select><br>
        
        <%-- Checkboxes for features --%>
        <label>Features:</label><br>
        <input type="checkbox" id="bedroom" name="features" value="Bedroom" <%= request.getParameterValues("features") != null && Arrays.asList(request.getParameterValues("features")).contains("Bedroom") ? "checked" : "" %>>
        <label for="bedroom">Bedroom</label><br>
        <input type="checkbox" id="balcony" name="features" value="Balcony" <%= request.getParameterValues("features") != null && Arrays.asList(request.getParameterValues("features")).contains("Balcony") ? "checked" : "" %>>
        <label for="balcony">Balcony</label><br>
        <!-- Add more checkboxes for other features as needed -->
        
        <%-- Include checkboxes for facilities, preselected based on room details --%>
        <label>Facilities:</label><br>
        <input type="checkbox" id="wifi" name="facilities" value="Wifi" <%= request.getParameterValues("facilities") != null && Arrays.asList(request.getParameterValues("facilities")).contains("Wifi") ? "checked" : "" %>>
        <label for="wifi">Wifi</label><br>
        <input type="checkbox" id="airConditioner" name="facilities" value="Air Conditioner" <%= request.getParameterValues("facilities") != null && Arrays.asList(request.getParameterValues("facilities")).contains("Air Conditioner") ? "checked" : "" %>>
        <label for="airConditioner">Air Conditioner</label><br>
        <!-- Add more checkboxes for other facilities as needed -->

        <input type="submit" value="Update Room">
    </form>
</body>
</html>
