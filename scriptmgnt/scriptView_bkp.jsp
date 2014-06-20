<%-- 
    Document   : scriptUplod
    Created on : Mar 20, 2012, 4:20:51 PM
    Author     : Rani
--%>

<%@page import="com.sql.connection.SQLManager"%>
<%@page import="java.sql.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/style.css" rel="stylesheet" type="text/css"  media="screen"/>
        <script type="text/javascript" src="../scripts/menu.js"></script>
        <script type="text/javascript" src="../scripts/alternatetable.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/tcal.css" />
        <script type="text/javascript" src="../scripts/tcal.js"></script>

        <title>Script</title>
        <script type="text/javascript">
function scriptvalidation(){
    var file=document.getElementById("uploadfile").value;
 var filesplit=file.split(".");
                if(!(filesplit[1]=="zip" || filesplit[1]=="zip"))
                {
                    alert("Browse The .zip File......")
                    document.getElementById("uploadfile").focus();
                    return false;
                }

}
</script>

            
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
         
    </head>
    <body>
        <form action="scriptUpload.jsp" method="post" enctype="multipart/form-data" onsubmit="return scriptvalidation()" >

        <%
        String cname=request.getParameter("name");
        System.out.println("Campaign name="+cname);
        String query="";
        PreparedStatement pstmt = null;
            Connection conn = null;
            ResultSet rs = null;

            try {
                SQLManager sm = new SQLManager();
            conn = sm.getConnection();
            query = "select * from  scripts where campaignname=? ";
            
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1,cname);

            System.out.println("Qry frm pagination---"+query);
            rs = pstmt.executeQuery();
            while (rs.next()) {
           %>
           <table align="center"  border="1"   id="mytable" class="attable">


            <tr>
                 <th>Script Id</th>
                <th>Campaign Name</th>

                 <th>Options</th>
                <th>Script Data</th>
             
                <th>Requested At</th>
                <th>Requested By</th>



               </tr>


            <tr>
                 <td>
                     <%=rs.getInt("script_id")%><% int sId=rs.getInt("script_id");session.setAttribute("scriptId",sId );%>
                </td>
                <td>
                    <%=rs.getString("campaignname")%>
                    <input  type="hidden" name="cname2" value="<%=rs.getString("campaignname")%>">
                </td>
             

                <td nowrap>
                    <font style="color: #B47474 ">Back Ground Music :</font> <%=rs.getString("bgmusic")%><br>
                    <font style="color: #B47474">Voice Over Artist :</font> <%=rs.getString("artistvoice")%><br>
                    <font style="color: #B47474">Languages         :</font> <%=rs.getString("language")%><br>
                   
                </td>
                <td>
                   <div style="width:250px; height:150px; overflow-x:hidden; overflow-y:scroll;  margin:0px auto; clear:both; overflow:auto;">
                       <%=rs.getString("scriptdata")%>
                    </div>
                </td>
                <td>
                    <%=rs.getString("inserted_time")%>
                </td>
                <td><%=rs.getString("username")%></td>

             <%-- <td align="center"><a  href="<%=response.encodeURL("scriptView.jsp?name="+cname1)%>">Upload Action</a></td>--%>

            </tr></table><br/>
                <table align="center">  <tr>

                        <td><input type="file" name="uploadfile" id="uploadfile"  ></td>
                        <td><input type="Submit" value="upload" name="uplod"  ></td></tr>
                    
                </table>

        </form><br><table align="center"><td><a  href="<%=response.encodeURL("scriptpending1.jsp")%>"><input type="button" value="Go Back" class="btn" ></a></td></table>
               <% }} catch (SQLException s) {
                s.printStackTrace();
            } finally {
            }
        %>
    </body>
</html>
