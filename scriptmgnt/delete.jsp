<%-- 
    Document   : delete
    Created on : May 11, 2011, 7:03:36 PM
    Author     : root
--%>

<%@page import="com.sql.connection.SQLManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <script type="text/javascript">

 
            function uwanttodelete(){

                if(confirm("Do U Want to Delete User")){
                    //alert("id--------"+<%=request.getParameter("cpcode")%>);

                    document.frm.action='confirDeleteUser.jsp?cpcode=<%=request.getParameter("cpcode")%>';
                    document.frm.submit();
                }else{

                    document.frm.action='viewUser.jsp';
                    document.frm.submit();
                }
            }

        </script>
    </head>
    <body>

        <%
            Statement st = null;
            Connection con = null;
            int nIns = 0;
            int id = 0;

            try {
                String uid = request.getParameter("user_id");
                con = SQLManager.getConnection();
                System.out.println("connection estableished");
                st = con.createStatement();
                System.out.println("statement exectued");

                String strQry = "update user_master set status=0 where user_id=" + uid + "";
             nIns = st.executeUpdate(strQry);%>
        <h2>Successfully deleted</h2>
        <%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                if (con != null) {

                    try {
                        //	SQLManager.closeAll(conn, stmt, result, true);
                        con.close();
                        st.close();

                        if (nIns >= 1) {
                            System.out.println("nINs enterd is value(nIns)");
                            response.sendRedirect(response.encodeUrl("viewUser.jsp?sts=User Successfully deleted"));
                        } else {
                            response.sendRedirect(response.encodeUrl("viewUser.jsp?sts=User Not deleted"));
                        }
                    } catch (Exception e) {
                    }
                }

            }



        %>
    </body>
</html>
