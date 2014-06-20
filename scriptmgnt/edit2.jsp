<%-- 
    Document   : edit2
    Created on : May 11, 2011, 4:27:31 PM
    Author     : root
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.sql.connection.*,java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.Date"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page= "menu.jsp" flush="true" />

        <%
            Statement st = null;
            Connection con = null;
            int nIns = 0;
            int id = 0;
            if (request.getParameter("userId") != null) {

                id = Integer.parseInt(request.getParameter("userId"));
                String mobileno = request.getParameter("mobno");
                String mailId = request.getParameter("email");
                String strvalidity = request.getParameter("sdate");
                String strQry = "";

                try {
                    con = SQLManager.getConnection();
                   
                    st = con.createStatement();
                    

                    System.out.println(strvalidity + "....................valdi");
                    strQry = "update user_master set mobno='" + mobileno + "',email='" + mailId + "', validity='" + strvalidity + "' where user_id=" + id + "";
                    nIns = st.executeUpdate(strQry);%>


        <%
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (con != null) {

                        try {
                            con.close();
                            st.close();
                            if (nIns >= 1) {
                                System.out.println("nINs enterd is value(nIns)");
                                response.sendRedirect("viewUser.jsp?sts=User Successfully Updated");
                                 System.out.println("chk(nIns)");
                            } else {
                                response.sendRedirect("viewUser.jsp?sts=User Not Updated");
                            }
                        } catch (Exception e) {
                        }
                    }
                }
            }
        %>
        <div class="rightColumn_dw"></div>
    </body>
</html>
