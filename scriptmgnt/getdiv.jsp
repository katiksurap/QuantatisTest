<%@page import="com.sql.connection.SQLManager"%><%@page import="java.sql.ResultSet"%><%@page import="java.sql.PreparedStatement"%><%@page import="java.sql.Connection"%>

<%System.out.println("ingetdiv");
Connection con=null;
PreparedStatement ps=null,psamt=null;
ResultSet rs=null,rsamt=null;
String sqlquery="";
String accid = request.getParameter("accid");
String Account_name = request.getParameter("accname");
System.out.println("accid"+accid);
String totamount =  "";
String accname = "";
String latamount = "";
String accnid = "";
String mainaccid ="" ; 
int pendamount =0;
String sumamount = "" ;
try{
con=SQLManager.getConnection();
sqlquery="select * from account_subtab where account_id= ? and status = 0 order by inserted_date desc";
ps=con.prepareStatement(sqlquery);
ps.setString(1,accid);
rs =ps.executeQuery();
if(rs.next()){
	accnid =  rs.getString("account_subid");
	mainaccid = rs.getString("account_id");
    totamount= rs.getString("acc_amount");
    latamount= rs.getString("updated_amount");
    if(latamount == null){
    	latamount = "0";
    }
    String amtcheck = "select sum(updated_amount) from account_subtab where account_id= ?" ;
    psamt = con .prepareStatement(amtcheck);
    psamt.setString(1,accid);
    System.out.print(psamt.toString());
    rsamt =  psamt.executeQuery();
    if(rsamt.next()){
    	sumamount = rsamt.getString(1);
    	System.out.println("sumamount"+sumamount);
    	if(sumamount == null){
    		sumamount = "0"; 
    	}
    }
    pendamount = Integer.parseInt(totamount)- Integer.parseInt(sumamount) ;
    out.print("<table class='attable'><tr><td><table><tr><th>Account Name</th><th>Total Amount</th><th>Total Updated Amount</th><th>Total Pending Amount</th><th>Last Modified Amount</th></tr>"
         + "<tr><td><input type='text' id='accname' name='accname' readonly='readonly' value='"+Account_name+"' style='border-radius:10px'/></td>"
         + "<td><input type='text' id='totamount' name='totamount' readonly='readonly' value='"+totamount+"' style='border-radius:10px'/></td>"
         + "<td><input type='text' id='totmodamount' name='totmodamount' readonly='readonly' value='"+sumamount+"' style='border-radius:10px'/></td>"
         + "<td><input type='text' id='totpenamount' name='totpenamount' readonly='readonly' value='"+pendamount+"' style='border-radius:10px'/></td>"
         + "<td><input type='text' id='latamount' name='latamount' readonly='readonly' value='"+latamount+"' style='border-radius:10px'/></td></tr></table></td></tr>"
         + "<tr><td><table><tr><th>Current Amount</th><th>Venkat Amount</th><th>Karthik Amount</th><th>Current Pending Amount</th></tr>"
         + "<tr><td><input type='text' id='curamount' name='curamount' value=''  style='border-radius:10px' onkeyup=' return getcurrency(this.value)'/></td>"
         + "<td><input type='text' id='vamount' name='vamount' value='' style='border-radius:10px'/></td>"
         + "<td><input type='text' id='kamount' name='kamount' value='' style='border-radius:10px'/></td>"
         + "<td><input type='text' id='pendamount' name='pendamount' value='"+pendamount+"' style='border-radius:10px' /><input type='hidden' id='pendamounthidden' name='pendamounthidden' value='"+pendamount+"'></td></tr></table></td></tr></table>"
         + "<input type='hidden' id='accid' name='accid' value='"+accnid+"'><input type='hidden' id='mainaccid' name='mainaccid' value='"+mainaccid+"'>");
}
}catch(Exception ex){
ex.printStackTrace();
}finally{
con.close();
}
%>