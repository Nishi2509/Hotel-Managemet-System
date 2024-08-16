<%-- 
    Document   : register
    Created on : 11-Apr-2024, 6:58:16 pm
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Registration Page</title>
        <%@include file="all_components/allcss.jsp"%>
    </head>
    <body>
        <% if (session.getAttribute("regfailed") != null) { %>
    <div class="alert alert-success" role="alert">
        <%-- Display the success message --%>
        <%= session.getAttribute("regfailed") %>
    </div>
    <%-- Remove the session attribute to avoid displaying the message again --%>
    <% session.removeAttribute("regfailed"); %>
<% } %>
        <div class="container p-4">
            <div class="row">
                <div class="col-md-4 offset-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="text-centre">Registration</h3>
                            <form action="/hotel_managment/registration" method="post">
                                <div class="form-group">
                                   <p>Name </p>
                                   <input type="text" class="form-control"  name="name" value="" aria-describedby="emailHelp" ">
                                </div>
                                <div class="form-group">
                                   <p>Email </p>
                                   <input type="email" name="email" class="form-control" value="" ">
                                </div> 
                                <div class="form-group">
                                    <p>Phone number </p>
                                    <input type="text" name="phonenum" class="form-control" value="" ">
                                </div>
                                <div class="form-group">
                                    <p>Password </p>
                                    <input type="password" name="pass" class="form-control" value="" ">
                                </div>
                                <div class="form-check">
                                    <label class="form-check-label" for="exampleCheck1">Check me out</label>
                                    <input type="checkbox" class="form-check-input" id="exampleCheck1">
                                </div>
                                <button type="submit" class="btn btn-primary">Submit</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>  
        
    </body>
</html>
