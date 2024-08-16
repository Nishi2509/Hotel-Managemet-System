<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="admin/dashboard.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>/* Global styles */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
}

.container {
    display: flex;
}

/* Header styles */
.header {
    background-color: #333;
    color: #fff;
    padding: 10px;
}

.header h1 {
    margin: 0;
}

.header-buttons {
    display: flex;
    align-items: center;
}

.logout-button,
.shutdown-button {
    background-color: #dc3545;
    color: #fff;
    border: none;
    padding: 5px 10px;
    margin-left: 10px;
    cursor: pointer;
}

/* Sidebar styles */
.sidebar {
    background-color: #333;
    color: #fff;
    width: 200px;
    padding: 20px;
}

.sidebar ul {
    list-style-type: none;
    padding: 0;
}

.sidebar li {
    margin-bottom: 10px;
}

.sidebar a {
    text-decoration: none;
    color: #fff;
}

.sidebar a:hover {
    color: #ffc107;
}

/* Main content styles */
.main-content {
    padding: 20px;
    flex: 1;
    background-color: #fff;
}

.section {
    margin-bottom: 30px;
}

/* About Us section styles */
#about-us textarea {
    width: 100%;
    height: 150px;
    resize: vertical;
}

#about-us input[type="submit"] {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 8px 16px;
    cursor: pointer;
}

#about-us input[type="submit"]:hover {
    background-color: #0056b3;
}

/* Contact Settings section styles */
#contact-settings .icon-input {
    display: flex;
    align-items: center;
}

#contact-settings .icon-input i {
    margin-right: 10px;
}

#contact-settings input[type="text"],
#contact-settings input[type="email"],
#contact-settings textarea {
    width: 100%;
    padding: 8px;
    margin-bottom: 10px;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
}

#contact-settings input[type="submit"] {
    background-color: #28a745;
    color: #fff;
    border: none;
    padding: 8px 16px;
    cursor: pointer;
}

#contact-settings input[type="submit"]:hover {
    background-color: #218838;
}</style>
</head>
<body>
    <header class="header">
        <h1>Admin Dashboard</h1>
        <div class="header-buttons">
            <form action="logout" method="post">
                <button class="logout-button" type="submit">Logout</button>
            </form>
            <form action="shutdown" method="post">
                <button class="shutdown-button" type="submit">Shutdown</button>
            </form>
        </div>
    </header>
    <div class="container">
        <aside class="sidebar">
            <ul>
                <li><a href="admin/admin_dashboard">Dashboard</a></li>
                <li><a href="admin/rooms.jsp">Rooms Management</a></li>
                <li><a href="admin/FeaturesAndFacilities.jsp">Features And Facilities</a></li>
                <li><a href="admin/ConfrimbookingDetails.jsp">Bookings Management</a></li>
                <li><a href="admin/contact.jsp">queries</a></li>

                <li><a href="#settings">Settings</a></li>
            </ul>
        </aside>
        <main class="main-content">
            <section class="section" id="dashboard">
                <h2>Dashboard</h2>
                <p>Welcome to the admin dashboard! Here, you can view statistics and manage various aspects of your hotel.</p>
                <!-- Add more dashboard content as needed -->
            </section>
          <section class="section" id="about-us">
               <h2>About Us</h2>
<button id="editBtn" onclick="toggleEdit()">Edit</button>
<form action="UpdateAboutUs" method="post">
    <label for="site_about">About Us:</label><br>
    <textarea id="site_about" name="site_about">${aboutUs}</textarea><br>
    <input type="submit" value="Save">
</form>

            </section>

         <!-- Update the contact settings section -->
<section class="section" id="contact-settings">
    <h2>Contact Settings</h2>
    <button id="editContactBtn" onclick="toggleContactEdit()">Edit</button>
    <!-- Display editable form for updating contact information -->
    <form id="contactForm" action="ContactDetailsServlet" method="post" style="display: none;">
         <label for="contact_id">id:</label>
        <input type="text" id="address" name="sr_no" required><br> 
        <label for="address">Address:</label>
        <input type="text" id="address" name="address" required><br>
        <label for="gmap">Google Maps Location:</label>
        <input type="text" id="gmap" name="gmap" required><br>
        <label for="pn1">Phone Number 1:</label>
        <input type="text" id="pn1" name="pn1" required><br>
        <label for="pn2">Phone Number 2:</label>
        <input type="text" id="pn2" name="pn2"><br>
        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required><br>
        <label for="fb">Facebook:</label>
        <div class="icon-input">
            <i class="fab fa-facebook-f"></i>
            <input type="text" id="fb" name="fb">
        </div><br>
        <label for="insta">Instagram:</label>
        <div class="icon-input">
            <i class="fab fa-instagram"></i>
            <input type="text" id="insta" name="insta">
        </div><br>
        <label for="twitter">Twitter:</label>
        <div class="icon-input">
            <i class="fab fa-twitter"></i>
            <input type="text" id="twitter" name="tw">
        </div><br>
        <label for="iframe">Embed iframe:</label>
        <textarea id="iframe" name="iframe"></textarea><br>
        <input type="submit" value="Save">
    </form>
    <!-- Display current contact details with icons -->
 
    <div class="contact-details">
        <h3>Current Contact Details:</h3>
        <div class="contact-item">
            <i class="fas fa-map-marker-alt"></i>
            <p><strong>Address:</strong> ${contact.address}</p>
        </div>
        <div class="contact-item">
            <i class="fab fa-google"></i>
            <p><strong>Google Maps Location:</strong> ${contact.gmap}</p>
        </div>
        <div class="contact-item">
            <i class="fas fa-phone-alt"></i>
            <p><strong>Phone Number 1:</strong> ${contact.pn1}</p>
        </div>
        <div class="contact-item">
            <i class="fas fa-phone-alt"></i>
            <p><strong>Phone Number 2:</strong> ${contact.pn2}</p>
        </div>
        <div class="contact-item">
            <i class="far fa-envelope"></i>
            <p><strong>Email:</strong> ${contact.email}</p>
        </div>
        <div class="contact-item">
            <i class="fab fa-facebook-f"></i>
            <p><strong>Facebook:</strong> ${contact.fb}</p>
        </div>
        <div class="contact-item">
            <i class="fab fa-instagram"></i>
            <p><strong>Instagram:</strong> ${contact.insta}</p>
        </div>
        <div class="contact-item">
            <i class="fab fa-twitter"></i>
            <p><strong>Twitter:</strong> ${contact.tw}</p>
        </div>
        <div class="contact-item">
            <i class="fas fa-code"></i>
            <p><strong>Embed iframe:</strong> ${contact.iframe}</p>
        </div>
    </div>
  
</section>
    

                 </main>
    
    <script>
        
          // JavaScript to populate form fields
       document.addEventListener('DOMContentLoaded', function() {
    var settings = {
        site_title: 'Your Site Title',
        site_about: 'About your site...'
    };

    document.getElementById('site_title').value = settings.site_title;
    document.getElementById('site_about').value = settings.site_about;
});


        function toggleEdit() {
            var editBtn = document.getElementById("editBtn");
            var siteTitleInput = document.getElementById("site_title");
            var siteAboutTextarea = document.getElementById("site_about");

            if (editBtn.innerHTML === "Edit") {
                editBtn.innerHTML = "Cancel";
                siteTitleInput.removeAttribute("readonly");
                siteAboutTextarea.removeAttribute("readonly");
            } else {
                editBtn.innerHTML = "Edit";
                siteTitleInput.setAttribute("readonly", true);
                siteAboutTextarea.setAttribute("readonly", true);
            }
        }
        
function toggleContactEdit() {
    var editBtn = document.getElementById("editContactBtn");
    var contactForm = document.getElementById("contactForm");

    if (editBtn.innerHTML === "Edit") {
        editBtn.innerHTML = "Cancel";
        contactForm.style.display = "block"; // Show the contact form
    } else {
        editBtn.innerHTML = "Edit";
        contactForm.style.display = "none"; // Hide the contact form
    }
}

        

      

    </script>
</body>
</html>
