<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Mike
  Date: 6/29/2017
  Time: 11:36 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<table border="1">
    <tr>
        <th>First Name</th>
        <th>Last Name</th>
        <th>Address</th>
        <th>Address(2)</th>
        <th>City</th>
        <th>State</th>
        <th>Zip</th>
        <th>Country</th>
        <th>Registration Date</th>

    </tr>

    <c:forEach var="users" items="${displayUsers}">
        <tr>
            <td>${users.firstName}</td>
            <td>${users.lastName}</td>
            <td>${users.address1}</td>
            <td>${users.address2}</td>
            <td>${users.city}</td>
            <td>${users.state}</td>
            <td>${users.zip}</td>
            <td>${users.country}</td>
            <td>${users.registrationDate}</td>
        </tr>
    </c:forEach>

</table>

</body>
</html>
