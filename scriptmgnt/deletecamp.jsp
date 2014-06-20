<%-- 
    Document   : approvereject
    Created on : Mar 13, 2012, 3:03:10 PM
    Author     : wifibharathi
--%>

<%@page import="com.logic.mail"%>
<%@page import="com.sql.connection.HardcodedValues"%>
<%@page import="com.sql.connection.SQLManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Approve/Reject</title>
    </head>
    <body>
        <%
            PreparedStatement scriptpst = null;
            Connection scriptconn = null;
            ResultSet rs = null;

            try {
                SQLManager sm = new SQLManager();
                scriptconn = sm.getConnection();
                String userid = request.getParameter("userid");
                String cname = request.getParameter("cname");
                String status = request.getParameter("status");
                System.out.println("In approvereject val's---" + status);
                String qry = "Update scripts set status=5 where script_id=? and campaignname=?";

                scriptpst = scriptconn.prepareStatement(qry);

                scriptpst.setString(1, userid);
                scriptpst.setString(2, cname);
                int i = scriptpst.executeUpdate();
                System.out.println("Boolen val---" + i);
                if (i>0) {
                    
  
                    response.sendRedirect("existingscripts.jsp?sts=script with campagin name "+cname+". and script ID: "+userid+" Deleted successfully.");
                } else {
                    response.sendRedirect("existingscripts.jsp?sts=script with campagin name "+cname+".Not Deleted Try again.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                scriptconn.close();
            }
        %>
    </body>
</html>

