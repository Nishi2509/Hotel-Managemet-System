<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <!-- CSS styles -->
    <style>
        /* Dropdown container */
        .dropdown {
            position: relative;
            display: inline-block;
            margin-right: 20px; /* Add some spacing between the button and other elements */
        }

        /* Dropdown button */
        .dropbtn {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }

        /* Dropdown content (hidden by default) */
        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
            border-radius: 4px;
        }

        /* Links inside the dropdown */
        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
        }

        /* Change color of dropdown links on hover */
        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        /* Show the dropdown menu when the dropdown button is clicked */
        .dropdown.active .dropdown-content {
            display: block;
        }
    </style>
    <!-- JavaScript to toggle dropdown menu -->
    <script>
        // Function to toggle active class on dropdown container
        function toggleDropdown() {
            var dropdown = document.getElementById("settingsDropdown");
            dropdown.classList.toggle("active");
        }
    </script>
</head>
<body>

<!-- Dropdown container -->
<div class="dropdown" id="settingsDropdown">
    <!-- Dropdown button -->
    <button class="dropbtn" onclick="toggleDropdown()">Settings</button>
    <!-- Dropdown content -->
    <div class="dropdown-content">
        <!-- Link to logout page -->
        <a href="logout.jsp">Logout</a>
        <!-- Link to invoice page -->
        <a href="invoice.jsp">Invoice</a>
        <!-- You can add more options as needed -->
    </div>
</div>

</body>
</html>
