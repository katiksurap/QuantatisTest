<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

<link href="css/style.css" rel="stylesheet" type="text/css"  media="screen"/>
<%@page session="true" %>

<%@page import="com.sql.connection.*,java.sql.*"%>
<link href="css/styles_main.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="../css/tcal.css" />
	<script type="text/javascript" src="../scripts/tcal.js"></script>
        <script type="text/javascript" src="../scripts/alternatetable.js"></script>
        <script type="text/javascript" src="../scripts/datetimepicker_css.js"></script>
<script type="text/javascript">
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
</script>
<script type="text/javascript">
function noBack(){
    window.history.forward();}

function editUser()
{
     var retVal = confirm("Do you want to edit ?");
   if( retVal == true ){
      alert("User wants to continue!");
	  return true;
   }else{
      alert("User does not want to continue!");
	  return false;
   }

    
}
function  deleteUser()
{
     var retVal = confirm("Do you want to delete ?");
   if( retVal == true ){
      alert("User wants to continue!");
	  return true;
   }else{
      alert("User does not want to continue!");
	  return false;
   }


}
</script>
</head>
<body  onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">

<jsp:include page= "menu.jsp" flush="true" />
<!--content starts here-->
<%
response.setHeader("Pragma","no-cache"); // HTTP 1.0
response.setHeader("Cache-Control","no-store"); // HTTP 1.1
response.setDateHeader("Expires", 0);
%>

  <div id="content">
<div id="heading">View Users </div>
   <form action="" method="post" name="frm">
   <table align="center" style="width:80px" id="mytable" class="attable">
      
      <tr height="17">
        <th align="center">UserID</th>
        <th align="center">UserType</th>
        <th align="center">UserName</th>
        <th align="center">Password</th>
        <th align="center">Mobile Number</th>
         <th align="center">Email Address</th>
        <th align="center">Validity</th>
        <th align="center">Status</th>
        <th align="center">Edit</th>
        <th align="center">Delete</th>
      </tr>
        <%
         try
         {
             Connection con=SQLManager.getConnection();
             Statement st=con.createStatement();
             ResultSet rs=st.executeQuery("select * from user_master where status=1");
             int i=1;
             while(rs.next())
             {
        %>
              <tr height="17">
                  <td align="center"><%=rs.getString("user_id")%></td>
                  <td align="center"><%=rs.getString("user_type")%></td>
                  <td align="center"><%=rs.getString("name")%></td>
                  <td align="center"><%=rs.getString("password")%></td>
                  <td align="center"><%=rs.getString("mobno")%></td>
                  <td align="center"><%=rs.getString("email")%></td>
                
                  <td align="center"><%=rs.getString("validity")%></td>
                 <%
                 int status1=rs.getInt("status");
                  if(status1==1)
                  {
                      %>
                     <td align="center">Active</td>
                      <%
                  }
                 else
                     {

                  %>

        
                  <td align="center">InActive</td>
                  <%
                  }
%>
                  
                  <td align="center"><a href="edit.jsp?user_id=<%=rs.getString("user_id")%>&user_type=<%=rs.getString("user_type")%>&username=<%=rs.getString("name")%>&Password=<%=rs.getString("password")%>&MobileNum=<%=rs.getString("mobno")%>&mailid=<%=rs.getString("email")%>&Validity=<%=rs.getString("validity")%>&status=<%=rs.getInt("status")%>" onclick="return editUser()">Edit</a></td>
                  <td align="center"><a href="delete.jsp?user_id=<%=rs.getString("user_id")%>" onclick="return deleteUser()">Delete</a></td>
              </tr>
         <%
             }
             con.close();
             st.close();
             rs.close();
        }catch(Exception e){}
        %>
      
    </table>
   </form>
</div>
<!--sub contents ends here -->
</body>
</html>
