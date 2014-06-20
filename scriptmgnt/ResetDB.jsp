<%@page import="com.sql.connection.SQLManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset </title>
    </head>
    <body>

        <%

        Connection con=null;
        Statement stmt = null;

        ResultSet rs=null;
        long user_id=Integer.parseInt(request.getParameter("selpassword"));
       // String user_id = request.getParameter("user_id");
        System.out.println("User id----"+user_id);

        String name = request.getParameter("name");
        
        try {
           
            SQLManager sq = new SQLManager();
            
            con = sq.getConnection();
            stmt = con.createStatement();
                 
            String sql = "update user_master set password='script123',first_login=1 where user_id="+user_id;
            System.out.println("query----"+sql);
           int c=stmt.executeUpdate(sql);
        

            if (c > 0) {
                response.sendRedirect("Reset.jsp?sts=User Reset pwd successfully");
            } else {
                response.sendRedirect("Reset.jsp");
            }
    
            stmt.close();
        } catch (Exception e) {
            System.out.println(e);
        }

        %>





    </body>
</html>
