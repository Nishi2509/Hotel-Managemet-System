<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Booking Page</title>
</head>
<body>
    <h2>Book Your Room</h2>
    <form action="ConfirmBookingServlet" method="post">
        <input type="hidden" name="roomId" value="<%= request.getParameter("roomId") %>">
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br>
        <label for="phoneNo">Phone No:</label>
        <input type="text" id="phoneNo" name="phoneNo" required><br>
        <label for="address">Address:</label>
        <input type="text" id="address" name="address" required><br>
        <label for="checkinDate">Check-in Date:</label>
        <input type="date" id="checkinDate" name="checkinDate" required><br>
        <label for="checkoutDate">Check-out Date:</label>
        <input type="date" id="checkoutDate" name="checkoutDate" required><br>
        <button id="confirmBookingBtn">Confirm Booking</button>

    </form>
 <script>
    // Wait for the DOM to be loaded
    document.addEventListener('DOMContentLoaded', function() {
        // Select the "Confirm Booking" button by its id
        var confirmBookingBtn = document.getElementById('confirmBookingBtn');
        
        // Attach an event listener to listen for clicks on the button
        confirmBookingBtn.addEventListener('click', function() {
            // Retrieve booking details from the form
            var name = document.getElementById('name').value;
            var phoneNo = document.getElementById('phoneNo').value;
            var address = document.getElementById('address').value;
            var checkinDate = document.getElementById('checkinDate').value;
            var checkoutDate = document.getElementById('checkoutDate').value;
            var roomId = document.getElementById('roomId').value; // Assuming you have a hidden input field with id="roomId"
            
            // Create a FormData object to send the data to the servlet
            var formData = new FormData();
            formData.append('name', name);
            formData.append('phoneNo', phoneNo);
            formData.append('address', address);
            formData.append('checkinDate', checkinDate);
            formData.append('checkoutDate', checkoutDate);
            formData.append('roomId', roomId);
            
            // Make an AJAX request to the ConfirmBookingServlet
            var xhr = new XMLHttpRequest();
            xhr.open('POST', 'ConfirmBookingServlet', true);
            xhr.onload = function() {
                if (xhr.status >= 200 && xhr.status < 300) {
                    // Success
                    if (xhr.responseText.trim() === 'success') {
                        // Booking confirmation was successful
                        alert('Booking confirmed successfully!');
                        // Optionally, redirect the user to a confirmation page
                        window.location.href = 'confirmationPage.jsp';
                    } else {
                        // Booking confirmation failed
                        alert('Failed to confirm booking: ' + xhr.responseText);
                    }
                } else {
                    // Error
                    alert('Error: Unable to confirm booking. Please try again later.');
                }
            };
            xhr.onerror = function() {
                // Error
                alert('Error: Unable to confirm booking. Please try again later.');
            };
            // Send the FormData object as the request body
            xhr.send(formData);
        });
    });
</script>

</body>
</html>
