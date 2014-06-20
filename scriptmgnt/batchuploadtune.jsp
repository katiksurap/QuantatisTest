<%-- 
    Document   : batchuploadtune
    Created on : Aug 24, 2012, 12:26:23 PM
    Author     : karthikeyan
--%>
<%@page import="org.apache.commons.beanutils.RowSetDynaClass"%>
<%@page import="com.sql.connection.SQLManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="../WEB-INF/displaytag.tld" prefix="display"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
          <link href="../css/style.css" rel="stylesheet" type="text/css" />
          <script type="text/javascript" src="../Javascripts/batchuploadmain.js"></script>
          <link rel="stylesheet" type="text/css" href="../css/tcal.css" />
        <script type="text/javascript" src="../scripts/tcal.js"></script>
        <title>Batch Upload</title>
        <script language="javascript" type="text/javascript">
function getCategory()
{
   document.frm.action="Batchupload.jsp";
   document.frm.submit();

}
function showsubdiv(acc_id){
    document.getElementById("sub-div").style.display='';
    
    
    var xmlhttp;
if (window.XMLHttpRequest)
{

    xmlhttp=new XMLHttpRequest();

}
else
{

    xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");

}
xmlhttp.onreadystatechange=function() //This part is actually executed last
{

    if (xmlhttp.readyState==4 && xmlhttp.status==200) // Was the request processed successfully?
    {

        document.getElementById("sub-account").innerHTML=xmlhttp.responseText;

    }

}
xmlhttp.open("GET","getdiv.jsp?accid="+acc_id);
xmlhttp.send();
}
</script>
    </head>
    <body>
     <jsp:include page="menu.jsp"/>
     <br><%
String message = null;
if(request.getParameter("sts")!=null){
message = request.getParameter("sts");
out.println("<center><b><p style='color:#5D95CE'>"+message+"</p></b></center>");
  }
%>
 <div id="content">
<div id="heading">View Users </div>
<%
    Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;
String sqlquery="";
String mainquery="";
java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
java.text.SimpleDateFormat sdf2 = new java.text.SimpleDateFormat("dd-MMM-yyyy");
java.text.SimpleDateFormat sdf1 = new java.text.SimpleDateFormat("dd-MMM-yyyy hh:mm:ss");
try{
con=SQLManager.getConnection();
String toneName ="";
String singerName ="";
String SortingMode ="";
 String minOrderTimes ="";
 String maxOrderTimes ="";
 String RBTSTATUS ="";
 String CLASSIFICATION ="";
 String PROVIDER ="";
 String beginUploadTime ="";
 String endUploadTime ="";
sqlquery="select * from Accounts_quantatis";
ps=con.prepareStatement(sqlquery);
rs=ps.executeQuery();
System.out.println("Browsevrbt page query"+ps);
if(rs.next()){
rs.beforeFirst();
RowSetDynaClass resultSet = new RowSetDynaClass(rs,true);
request.setAttribute("resultSet",resultSet);
 Connection conn1 = SQLManager.getConnection();
PreparedStatement stmt1 = conn1.prepareStatement(sqlquery);
ResultSet rs1 = stmt1.executeQuery();
%>
<br><center><font style="font-size: 18px">Displaying Catogery Details records</font></center>
 
<display:table name="requestScope.resultSet.rows" class="attable" pagesize="6"  style="border:0;align:center;cellpadding:4;cellspacing:2" export="true">
 <display:setProperty name="export.excel.filename" value="Campnames.xls" />
  <display:setProperty name=" export.pdf.include_header" value="true" />
  <display:setProperty name="export.pdf" value="true" />
  <display:setProperty name="export.csv" value="true" />
  
    <display:setProperty name="export.excel" value="false"/>
  <display:setProperty name="export.xml" value="false" />
              
                  <%
                  String Status="";
                  String remark="";
                  String firstdate="";
                  rs1.next();
                //  String path=rs1.getString("tunepath");
                 String Account_name=rs1.getString("Account_name");
                 String user_id =rs1.getString("user_id");
                 String createddate =rs1.getString("createddate");
                 String account_date =rs1.getString("account_date");
                 String total_amount =rs1.getString("total_amount");
                 String venkat_amount =rs1.getString("venkat_amount");
                 String karthik_amount =rs1.getString("karthik_amount");
                 String acc_description =rs1.getString("acc_description");
                 String upload_fpath =rs1.getString("upload_fname");
                 String trans_stat = rs1.getString("trans_stat");
                 String accountid = rs1.getString("amount_id");
                 String IdStat="";
                 if(trans_stat.equalsIgnoreCase("0")){
                     IdStat = "<a href='#' style='color:green;' ><b>Settled</b></a>";
                 }else{
                 IdStat = "<a href='#' style='color:red;' onclick='showsubdiv("+accountid+")'><b>un-Settled<span id='accountid_text' style='display:none'>Selected*</span</b></a>";
                 }
             
                 %>
<display:column title="Account Name"  group="1"><%=Account_name%></display:column> 
<display:column title="Added By" style="nowrap"><%=user_id%></display:column>
<display:column title="Created Date"><%=createddate%></display:column>
<display:column title="Account Date"><%=account_date%></display:column>
<display:column title="Amount"><%=total_amount%></display:column>
<display:column title="Venkat" style="nowrap"><%=venkat_amount%></display:column>
<display:column title="Karthik"><%=karthik_amount%></display:column>
<display:column title="Description"><%=acc_description%></display:column>
<display:column title="File Path"><%=upload_fpath%></display:column>
<display:column title="Acc Status"><%=IdStat%></display:column>
</display:table>
<%

            } else {
                out.println("<center>Nothing Account related info found to display</center>");

            }
} catch (Exception e) {
            e.printStackTrace();

        }
        
        
%>
</br>
<div id="sub-div" style="display:none;width: 690px ;border: 2px solid #C98F8F;position: absolute;left:260px ;border-radius:10px">
    <table class="attable" style="border-radius:10px">
     <tr>
         <th>Account Name</th>
         <th>Total Amount</th>
         <th>Last Modified Amount</th>
         <th>Current Amount</th>
         <th>Venkat Amount</th>
         <th>Karthik Amount</th>
         <th>Created Date</th>
         <th>Attachment</th>
         <th>Status</th>
     </tr>
        <tr id="sub-account">
            
        </tr>
        <tr>
            <td colspan="3"><input type="button" class="btn" onclick="closediv()"/></td>
        </tr>
    </table>
</div>
</br></br>
 </div>

 
    </body>
</html>
