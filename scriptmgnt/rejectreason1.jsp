<%-- 
    Document   : rejectreason1
    Created on : Mar 16, 2012, 10:40:10 AM
    Author     : wifibharathi
--%>

<%@page import="com.sql.connection.HardcodedValues"%>
<%@page import="com.logic.mail"%>
<%@page import="com.sql.connection.SQLManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


         
        <%
            PreparedStatement scriptpst = null,pst=null;
            Connection scriptconn = null;
            ResultSet rs = null;

   //String utype= session.getAttribute("user_type").toString();         
       String uname =session.getAttribute("user_type").toString();          
System.out.println("user type"+uname);
    String email=HardcodedValues.fromemail;   
            
            
            try {
                 System.out.println("In rejectreason1");
                SQLManager sm = new SQLManager();
                scriptconn = sm.getConnection();
                String userid = request.getParameter("userid");
                String cname = request.getParameter("cname");
                //int status = Integer.parseInt(request.getParameter("status"));
                String reason = request.getParameter("reason");
                String assignedto=request.getParameter("assignedto");
                String rejby=request.getParameter("rejby");
                int scriptid=Integer.parseInt(request.getParameter("scriptid"));
                System.out.println("In reject val's---" +reason + userid);
                String qry = "update scripts set status=?,rejectreason=?,rejecteddate=now() where  user_id=? and campaignname=?";

                scriptpst = scriptconn.prepareStatement(qry);
              
                
                scriptpst.setInt(1,3);
                scriptpst.setString(2,reason);
              
                scriptpst.setString(3,userid);
               
                scriptpst.setString(4,cname);
                
                int i = scriptpst.executeUpdate();
                System.out.println("exe val---" + i);
                  System.out.println("query"+scriptpst);
                if (i >=1) {
                   // response.sendRedirect("existdates.jsp?sts=script rejected successfully.");
       System.out.println("query 2 came yaar");
                    String qryhist="insert into rejscripts(campid,campname,rejdate,rejreason,assign_to,RejBy) values(?,?,now(),?,?,?)";
                    pst=scriptconn.prepareStatement(qryhist);
                     
                    pst.setInt(1,scriptid);
                    pst.setString(2,cname);
                    pst.setString(3,reason);
                     pst.setString(4,assignedto);
                     pst.setString(5, rejby);
                     System.out.println("hist qry--->"+qryhist);
                     System.out.println("values--->"+scriptid+"---"+cname+"----"+reason+"----"+rejby);
                     System.out.println("hist qry--->"+qryhist);
                      int j = pst.executeUpdate();
                            System.out.println("query 2 ece yaar" +j);
                     if(j>=1){
                         
 String assignedTo =assignedto;
                
int id= scriptid;                                                  
               PreparedStatement ps_mail = null;
                    String in_qry = "insert into email_sending(from_mail,to_mail,subject,message,status,inserted_date) values(?,?,?,?,?,now())";
                    /////////to login user////////
                    ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.operator1);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been rejected Due To Reason :"+reason+" .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center> ");
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
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been rejected Due To Reason :"+reason+"  .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been rejected Due To Reason :"+reason+"  .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Studio Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been rejected Due To Reason :"+reason+"  .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Studio Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been rejected Due To Reason :"+reason+" .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Radio Mirchi, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been rejected Due To Reason :"+reason+"  .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Radio Mirchi, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span> has been rejected Due To Reason :"+reason+"  <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been rejected Due To Reason :"+reason+" <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been rejected Due To Reason :"+reason+"  .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Script <span style='color: red'><b>"+id+"_"+cname+" </b></span> has been rejected Due To Reason :"+reason+"  <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
                    ps_mail.setInt(5, 5);
                    int n10 = ps_mail.executeUpdate();
                    if(n10>0){
                        System.out.println("wifi team 3 Inserted In DB");
                    }
                    ps_mail = null;                      
             
 //////////////////// edn of radio mirchi  ////////////////  


}///////////////////////////////////////  total email sending completed ///////////////////////////    
                    //////////////end mail////////////                        
                         
                         
                         
                         
                         
                         
                         
                         
                      System.out.println("The updation in history is completed ");
                                                                }
                    
                    out.println("<br><br><center>script rejected successfully</center>");
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
           
                } else {
                    response.sendRedirect("existdates.jsp?sts=script not rejected successfully.");
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                scriptconn.close();
            }
        %>
    
