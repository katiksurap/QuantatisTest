 <%-- 
    Document   : report
    Created on : Mar 16, 2012, 7:04:21 PM
    Author     : Rani
--%>

<%@page import="com.sql.connection.*,java.sql.*"%>
<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/style.css" rel="stylesheet" type="text/css"  media="screen"/>
        <script type="text/javascript" src="../scripts/menu.js"></script>
        <script type="text/javascript" src="../scripts/alternatetable.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/tcal.css" />
        <script type="text/javascript" src="../scripts/tcal.js"></script>
        
        <script>
            function check(){
            var bg1=document.getElementsByName("chek");
  if(bg1[0].checked==false && bg1[1].checked==false)
                {
                    alert("Please Make a Choice " );
                    return false;
                }
            }
            
        </script>

        <title>Reports</title>
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        <div id="heading">Select Search Type Of Search For Approved Scripts </div>
        <form action="report.jsp" method="post" onsubmit="return check()">
            <br/><div style="padding-left: 350px;"><table  cellspacing="0" cellpadding="0" width="95%" class="attable" id="mytable" align="center"><table><tr><td>
            <input type="radio" value="0" name="chek" align="center"/>Campaign Wise
            <input type="radio" value="1" name="chek" align="center"/>Script ID Wise
            <input type="submit" value="Submit"/></td></tr></table></div>
        </form>
        <%
             if(request.getParameter("chek")!=null){


            if(request.getParameter("chek").equalsIgnoreCase("0")){
                response.sendRedirect("campaignexistscript.jsp");
            }
            if(request.getParameter("chek").equalsIgnoreCase("1")){
                out.println("Enter Date");
                response.sendRedirect("existscripts.jsp");
            }
           
}
        %>
    
    <div id="footer">© 2012 All Rights Reserved by WiFi Networks</div>
    </body>
</html>
