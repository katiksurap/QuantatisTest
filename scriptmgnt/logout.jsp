<%-- 
    Document   : logout
    Created on : Sep 26, 2011, 9:50:53 AM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Log Out</title>
    </head>
    <body>
        <%
        session.invalidate();
        response.sendRedirect("../login.jsp?sts=you have successfully logged out");

        %>
    </body>
</html>
