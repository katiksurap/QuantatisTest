<%@page import="com.sql.connection.SQLManager"%><%@page import="java.sql.ResultSet"%><%@page import="java.sql.PreparedStatement"%><%@page import="java.sql.Connection"%>
<%System.out.println("ingetdiv");
Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;
String sqlquery="";
String accid = request.getParameter("accid");
String Account_name = request.getParameter("accname");
System.out.println("accid"+accid);
String totamount =  "";
String accname = "";
String latamount = "";
String accnid = "";
try{
con=SQLManager.getConnection();
sqlquery="select * from account_subtab where account_id= ? and status = 0 order by inserted_date desc";
ps=con.prepareStatement(sqlquery);
ps.setString(1,accid);
rs =ps.executeQuery();
if(rs.next()){
	accnid =  rs.getString("account_subid");
    totamount= rs.getString("acc_amount");
    latamount= rs.getString("updated_amount");
out.print("<link rel='stylesheet' type='text/css' href='css/tcal.css' /> <script type='text/javascript' src='scripts/tcal.js'></script>        <td><input type='text' id='accname' name='accname' value='"+Account_name+"' size='7' style='border-radius:10px' /></td>"
        + "<td><input type='text' id='totamount' name='totamount' value='"+totamount+"'  size='7' style='border-radius:10px' /></td>"
        + "<td><input type='text' id='latamount' name='latamount' value='"+latamount+"'  size='7'style='border-radius:10px' /></td>"
        + "<td><input type='text' id='curamount' name='curamount' value='' size='7' style='border-radius:10px' /></td>"
        + "<td><input type='text' id='vamount' name='vamount' value='' size='7' style='border-radius:10px' /></td>"
        + "<td><input type='text' id='kamount' name='kamount' value='' size='7' style='border-radius:10px' /></td>"
        + "<td><input name='acc_date' id='acc_date'  class='tcal' size='7' /></td>"
        + "<td><input name='uploadfile' id='uploadfile' type='file' size='5' /></td>"
        + "<td><input name='complete' id='complete' type='radio' />"
        + "<input type='hidden' id='accid' name='accid' value='"+accnid+"'></td>");
}

}catch(Exception ex){
ex.printStackTrace();
}finally{
con.close();
}
%>