
<div class="container-fluid" 
     style="height: 10px; background-color: #303f9f"></div>

<div class="container-fluid p-3">
    <div class="row">
        <div class="col-md-3 text-success">
            <h2>Hotel Royal Palace</h2>
        </div>
        <div class="col-md-6">
           
        </div>
        
        <div class="col-md-3">
            <a href="login.jsp" class="btn btn-success">Login</a>
            <a href="register.jsp" class="btn btn-primary text-white">Register</a>
        </div>
    </div>  
</div>



<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
    <a class="navbar-brand" href="#"><i class="fa fa-home"></i></a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item active">
                <a class="nav-link" href="index.jsp">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="rooms.jsp">Rooms</a>
            </li>

            <li class="nav-item active">
                <a class="nav-link" href="services.jsp">Services</a>
            </li>
            <li class="nav-item active">
                <a class="nav-link" href="about.jsp">About</a>
            </li>
        </ul>
        <div class="dropdown">
            <button class="btn btn-light dropdown-toggle" type="button" id="settingsDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                <i class="fa fa-cog"></i> Settings
            </button>
            <div class="dropdown-menu" aria-labelledby="settingsDropdown">
                <a class="dropdown-item" href="LogoutServlet">Logout</a>
                <a class="dropdown-item" href="Invoice.jsp">Invoice</a>
                <!-- Add more dropdown items as needed -->
            </div>
        </div>
        <form class="form-inline my-2 my-lg-0" action="contact.jsp">
            <button class="btn btn-light my-2 my-sm-0 ml-1" type="submit"><i class="fa fa-phone-square"></i> Contact us</button>
        </form>
    </div>
</nav>
