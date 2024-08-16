 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Feature or Facility</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        h2 {
            color: #333;
        }
        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
            margin: 0 auto;
        }
        label {
            font-weight: bold;
            margin-bottom: 8px;
            display: block;
        }
        select, input[type="text"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h2>Add Feature or Facility</h2>
    <form action="../AddFacilityServlet" method="post">
        <label for="type">Select Type:</label>
        <select id="type" name="type">
            <option value="feature">Feature</option>
            <option value="facility">Facility</option>
        </select><br>
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" required><br>
        <input type="submit" value="Add">
    </form>
</body>
</html>

