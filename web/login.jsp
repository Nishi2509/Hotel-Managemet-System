<%-- 
    Document   : login.jsp
    Created on : 12-Apr-2024, 3:07:35 am
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <%@include file="all_components/allcss.jsp"%>
    </head>
    <body style="background-color: #f0f1f2">
        <%@include file="all_components/navbar.jsp"%>
        <% if (session.getAttribute("registrationSuccessMsg") != null) { %>
    <div class="alert alert-success" role="alert">
        <%-- Display the success message --%>
        <%= session.getAttribute("registrationSuccessMsg") %>
    </div>
    <%-- Remove the session attribute to avoid displaying the message again --%>
    <% session.removeAttribute("registrationSuccessMsg"); %>
<% } %>
<div class="text-center">
         <% if (session.getAttribute("loginfailed") != null) { %>
    <div class="alert alert-success" role="alert">
        <%-- Display the success message --%>
        <%= session.getAttribute("loginfailed") %>
    </div>
    <%-- Remove the session attribute to avoid displaying the message again --%>
    <% session.removeAttribute("loginfailed"); %>
<% } %>
</div>
        <div class="container p-5" >
            <div class="row">
                <div class="col-md-4 offset-md-4">
                    <div class="card">
                        <div class="card-body">
                            <h3 class="text-center">Login</h3>
                           <form action="Login" method="post">
                              <div class="form-group">
                                <p>Email </p>
                                <input type="email" name="email" class="form-control" value="" required/>
                              </div>
                              <div class="form-group">
                                <p>Password </p>
                                <input type="password" name="pass" class="form-control" value="" required/>
                             </div>
                             <div class="text-center">
                               <button type="submit" class="btn btn-primary">Login</button><br>
                               <a href="register.jsp">Create Account</a>
                             </div>
                            </form>
                     
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
