<%@page import="com.sql.connection.SQLManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        <script type="text/javascript" src="scripts/alternatetable.js"></script>
        <link rel="stylesheet" type="text/css" href="css/ddcolortabs.css" />
        <script type="text/javascript" src="scripts/dropdowntabs.js"></script>
        <title>Reset Password</title>
        <script type="text/javascript">
   
            function funValid()
            {
                if(document.getElementById('selpassword').value=="-1")
                {
                    alert('Select Username');
                    document.getElementById('selpassword').focus();
                    return false;
                }
                else{
                    return true;
                }
            }
        </script>

    </head>
    <body>
        <jsp:include page= "menu.jsp" flush="true" />
        <div id="contener">
            <!--Top logo and Navigation start here-->
            <%
                response.setHeader("Pragma", "no-cache"); // HTTP 1.0
                response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
                response.setDateHeader("Expires", 0);


            %>
            <!--content starts here-->
            <div id="mainBody">

                <!--navigation ends here-->

                <!--content starts here-->
               <div id="content">
<div id="heading">Reset Password </div>

                    <%
                        if (null != request.getParameter("sts")) {
                    %>
                    <h3 font color="red">Successfully reset the password</h3>
                    <%        }



                    %>


                    <%

                        Connection conn = SQLManager.getConnection();
                        Statement st = conn.createStatement();
                        ResultSet rs = null;
                        int user_id = 0;
                        String sqlQuery = "select user_id,name from user_master order by name";
                        rs = st.executeQuery(sqlQuery);
                    %>
                    <form name="frmchngpassword" action="ResetDB.jsp">
                        <br>
                        <table align="center">
                            <tr>
                                <td>UserName:</td>
                                <td>
                                    <select name="selpassword" id="selpassword">
                                        <option value="-1">---Select Username</option>
                                        <% while (rs.next()) {
                                                user_id = rs.getInt("user_id");
                                                String name = rs.getString("name");
                                                // System.out.println("id:"+user_id);
%>
                                        <option value="<%=user_id%>"><%=name%></option>	<%}%>

                                    </select>
                                </td>
                            </tr>

                        </table>
                        <table align="center">
                            <tr>
                                <td align="center">

                                    <input type="submit"  value="Submit" onclick="funValid()"/></td>
                            </tr>
                        </table>
                    </form>


                    <!--content end here-->

                    <!--fotter --> 
                    <div id="footer">© 2011 All rights reserved by WiFi Networks.</div></div>
                    <%

                        st.close();
                        rs.close();
                        conn.close();

                    %>


                </body>
                </html>