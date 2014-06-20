<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="java.util.ArrayList"%>

<%@page import="com.sql.connection.SQLManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
 <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Script Management System</title>
        <link href="../css/style.css" rel="stylesheet" type="text/css"  media="screen"/>
        <script type="text/javascript" src="../scripts/menu.js"></script>
        <script type="text/javascript" src="../scripts/alternatetable.js"></script>
    </head>
     <jsp:include page= "menu.jsp" flush="true" />

<script type="text/javascript">

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

</script>
 <script type="text/javascript">
function noBack(){
    window.history.forward();}
</script>
<script language="javascript">
                    function chkpwd()
                    {
                        var oldpwd = document.getElementById("oldpwd").value;

                        var newpwd = document.getElementById("newpwd").value;
                        var conpwd = document.getElementById("conpwd").value;

                        if(oldpwd==null||oldpwd=="")
                            {
                                alert("You must enter current password");
                                return false;
                            }
                            if(newpwd==null||newpwd=="")
                            {
                                alert("You must enter new password");
                                return false;
                            }
                            if(conpwd==null||conpwd=="")
                            {
                                alert(" confirm password can not  be blank");
                                return false;
                            }
                            else if (conpwd == newpwd)
                            {
                                document.changepwd.submit();
                            }
                        else
                        {
                            alert("New password and confirm password must match");
                        }
                    }

</script>
</head>
<body  onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
        <!--content starts here-->
        <div id="mainBody">

            <div id="logo"><img src="../images1/logo1.gif" width="291" height="63" /></div>
            <div id="title"><img src="../images1/wifilogo.gif" width="82" height="61" /></div>


    
     <div id="header">

    <%!
    String col="";
    %>
  <%--<jsp:include page="menu.jsp"></jsp:include>--%>
    <%
if(request.getParameter("sts")!=null)
{
    if(request.getParameter("sts").equals("You have Successfully changed passoword"))
    {
        col="green";
    }
   else
   {
        col="red" ;
   }

%>
<h2><font color="<%=col%>"><%=request.getParameter("sts")%></font></h2>

<!--Top logo and Navigation start here-->
<%

}
response.setHeader("Pragma","no-cache"); // HTTP 1.0
response.setHeader("Cache-Control","no-store"); // HTTP 1.1
response.setDateHeader("Expires", 0);
	//if(session.getAttribute("user")!=null){
%>
 <!--content starts here-->

<!--navigation ends here-->

<!--content starts here-->
<%
		Connection conn = SQLManager.getConnection();
        Statement st = conn.createStatement();
        ResultSet rs=null;
%>
<div id="content">
<div id="heading">Change Password </div>
<form name="changepwd" method="post"action="../ChangePassword?action=change">
<br>
<table align="center">
<tr>
<td>Enter old password:</td>
<td>
    <input type="password" name="oldpwd" maxlength="15" id="oldpwd" onkeyup="checkspace(this)">
</td>
</tr>
<tr>
<td>Enter New Password :</td>
<td>
    <input type="password" name="newpwd" maxlength="15" id="newpwd" onkeyup="checkspace(this)">
</td>
</tr>
<tr>
<td>Confirm New Password:</td>
<td>
    <input type="password" name="conpwd" maxlength="15" id="conpwd" onkeyup="checkspace(this)">
</td>
</tr>
<tr><td><input type="button" class="btn" value="submit" onclick="return chkpwd()" ></td></tr></table>
</form>
</div>
</body>
</html>