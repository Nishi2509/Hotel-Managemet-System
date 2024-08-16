<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Image Upload</title>
</head>
<body>
    <h2>Upload Image</h2>
    <%-- Display message if available --%>
    <p><%= request.getParameter("message") %></p>
    <form action="UploadImageServlet" method="post" enctype="multipart/form-data">
        <input type="file" name="imageFile">
        <input type="submit" value="Upload Image">
    </form>
</body>
</html>
