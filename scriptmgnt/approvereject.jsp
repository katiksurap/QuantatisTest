<%-- 
    Document   : approvereject
    Created on : Mar 13, 2012, 3:03:10 PM
    Author     : wifibharathi
--%>

<%@page import="com.logic.mail"%>
<%@page import="com.sql.connection.HardcodedValues"%>
<%@page import="com.sql.connection.SQLManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Approve/Reject</title>
    </head>
    <body>
        <%
            PreparedStatement scriptpst = null;
            Connection scriptconn = null;
            ResultSet rs = null;
String utype= session.getAttribute("user_type").toString();
   

String uname = request.getParameter("assgnto");         
System.out.println("user type"+uname);
    String email=HardcodedValues.fromemail;
try {
                SQLManager sm = new SQLManager();
                scriptconn = sm.getConnection();
                String userid = request.getParameter("userid");
                String cname = request.getParameter("cname");
                String status = request.getParameter("status");
                String scriptid = request.getParameter("scriptid");
                System.out.println("In approvereject val's---" + status);
                String qry = "update scripts set status=?,approveddate=now() where user_id=? and campaignname=? and script_id=?";

                scriptpst = scriptconn.prepareStatement(qry);
                scriptpst.setString(1, status);
                scriptpst.setString(2, userid);
                scriptpst.setString(3, cname);
                scriptpst.setString(4, scriptid);
                int i = scriptpst.executeUpdate();
                System.out.println("Boolen val---" + i);
                if (i >0) {
                    
/////////////////////// email sending starts //////////////////////////////////
String assignedTo =uname;
                
String id= scriptid;                                                  
               PreparedStatement ps_mail = null;
                    String in_qry = "insert into email_sending(from_mail,to_mail,subject,message,status,inserted_date) values(?,?,?,?,?,now())";
                    /////////to login user////////
                    ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.operator1);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Approved.<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center> ");
                    ps_mail.setInt(5, 5);
                    int n1 = ps_mail.executeUpdate();
                    if(n1>0){
                        System.out.println("op 1 Inserted In DB");
                    }
                    ps_mail = null;
                    /////////to operator2///////
                    ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.operator2);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Approved .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
                    ps_mail.setInt(5, 5);
                    int n2 = ps_mail.executeUpdate();
                    if(n2>0){
                        System.out.println("op 2 Inserted In DB");
                    }
                    ps_mail = null;
                    /////////to operator 3/////////
                    ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.operator3);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Approved .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
                    ps_mail.setInt(5, 5);
                    int n3 = ps_mail.executeUpdate();
                    if(n3>0){
                        System.out.println("ope 3  Inserted In DB");
                    }
                    ps_mail = null;
             if(assignedTo.equalsIgnoreCase("Studio 9")){
             ///////////// for studio 9 first one /////////////
             ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.studio9team1);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Studio Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Approved .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
                    ps_mail.setInt(5, 5);
                    int n4 = ps_mail.executeUpdate();
                    if(n4>0){
                        System.out.println("Studio 9 user 1  Inserted In DB");
                    }
                    ps_mail = null;
                    /////////to operator 3/////////
                    ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.studio9team2);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Studio Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Approved.<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
                    ps_mail.setInt(5, 5);
                    int n5 = ps_mail.executeUpdate();
                    if(n5>0){
                        System.out.println("Studio 9 user  2 Inserted In DB");
                    }
                    ps_mail = null;    
////////////////// to the ending of studio team ////////////////
        
             
             
             
             
             
             }else if(assignedTo.equalsIgnoreCase("RadioMirchi")){
             
/////////////////// for radio mirchi ///////////////////////             
   ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.radiomirchi1);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Radio Mirchi, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Approved .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
                    ps_mail.setInt(5, 5);
                    int n6 = ps_mail.executeUpdate();
                    if(n6>0){
                        System.out.println("Radio Mirchi 1 Inserted In DB");
                    }
                    ps_mail = null;
                    /////////to operator 3/////////
                    ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.radiomirchi2);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Radio Mirchi, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Approved  <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
                    ps_mail.setInt(5, 5);
                    int n7 = ps_mail.executeUpdate();
                    if(n7>0){
                        System.out.println("Radio mirchi 2 Inserted In DB");
                    }
                    ps_mail = null;           
             
             
 //////////////////// edn of radio mirchi  ////////////////  
             
    } else if(assignedTo.equalsIgnoreCase("WiFi")){
   /////////////////// for radio mirchi ///////////////////////             
   ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.wifiteam1);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Approved<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
                    ps_mail.setInt(5, 5);
                    int n8 = ps_mail.executeUpdate();
                    if(n8>0){
                        System.out.println("wifi team 1 Inserted In DB");
                    }
                    ps_mail = null;
                    /////////to operator 3/////////
                    ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.wifiteam2);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Approved .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
                    ps_mail.setInt(5, 5);
                    int n9 = ps_mail.executeUpdate();
                    if(n9>0){
                        System.out.println("wifiteam 2 Inserted In DB");
                    }
                    ps_mail = null;           
          ////////////////////////////////////// 
   ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.wifiteam3);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Approved <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
                    ps_mail.setInt(5, 5);
                    int n10 = ps_mail.executeUpdate();
                    if(n10>0){
                        System.out.println("wifi team 3 Inserted In DB");
                    }
                    ps_mail = null;                      
             
 //////////////////// edn of radio mirchi  ////////////////  


}///////////////////////////////////////  total email sending completed ///////////////////////////    
                    //////////////end mail////////////
                    response.sendRedirect("existingscripts.jsp?sts=script approved successfully.");
                } else {
                    response.sendRedirect("existingscripts.jsp?sts=script not approved successfully.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                scriptconn.close();
            }
        %>
    </body>
</html>
