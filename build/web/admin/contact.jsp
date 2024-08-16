<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Contact Queries</title>
<link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h1>Contact Queries</h1>
    <table>
        <tr>
            <th>Name</th>
            <th>Email</th>
            <th>Subject</th>
            <th>Message</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>
        <c:forEach items="${queries}" var="query">
            <tr>
                <td>${query.name}</td>
                <td>${query.email}</td>
                <td>${query.subject}</td>
                <td>${query.message}</td>
                <td>${query.date}</td>
                <td>
                    <form action="contactQueries" method="get">
                        <input type="hidden" name="action" value="markAsRead">
                        <input type="hidden" name="queryId" value="${query.srNo}">
                        <button type="submit">Mark as Read</button>
                    </form>
                    <form action="contactQueries" method="get">
                        <input type="hidden" name="action" value="deleteQuery">
                        <input type="hidden" name="queryId" value="${query.srNo}">
                        <button type="submit">Delete</button>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>
