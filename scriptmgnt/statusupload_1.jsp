<%-- 
    Document   : statusupload
    Created on : Mar 27, 2012, 1:13:40 PM
    Author     : karthikeyan
--%>

<%@page import="java.sql.*"%>
<%@page import="com.sql.connection.*"%>
<%@page import="com.logic.mail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
      <%
      
 PreparedStatement scriptpst = null;
Connection scriptconn = null;
            ResultSet rs = null;
            String qry="";
 Statement stmt=null;
 String assignedTo =request.getParameter("assgnto");
 //String createdby=session.getAttribute("uname").toString();
 //String mobno=session.getAttribute("mobno").toString();
String id= request.getParameter("scrid"); 
 String campaign = request.getParameter("campaign");
 System.out.println(campaign);
            try {
                SQLManager sm = new SQLManager();
                scriptconn = sm.getConnection();
              qry="UPDATE scripts SET script_status=2,status=1 WHERE script_id ='"+id+"'";
               
               
               // String qry = "insert into scripts(user_id,campaignname,description,bgmusic,artistvoice,prompttype,language,uploaded_fname,uploadpath,scriptdata,username) values(?,?,?,?,?,?,?,?,?,?,?)";
                //String qry="UPDATE scripts SET scriptUpload_fname=?,scriptUpload_path=?,script_status=2 WHERE campaignname = ?";
//String qry="insert into scripts(scriptUpload_fname,scriptUpload_path,script_status,script_status) values(?,?,2) WHERE campaignname =?";
                System.out.println(qry);
                scriptpst = scriptconn.prepareStatement(qry);
                
                int res=scriptpst.executeUpdate();
                System.out.println("RES value"+res+qry);
                if(res>0){
     String cname= campaign;              
        String uname =session.getAttribute("user_type").toString();
 
 System.out.println("assaigned to value"+assignedTo);
   String email=HardcodedValues.fromemail;             
                                                 
               PreparedStatement ps_mail = null;
                    String in_qry = "insert into email_sending(from_mail,to_mail,subject,message,status,inserted_date) values(?,?,?,?,?,now())";
                    /////////to login user////////
                    ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.operator1);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  Uploaded With Promt .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center> ");
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
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with promt .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Prompt   .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Studio Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Promt .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Studio Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Prompt.<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Radio Mirchi, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Prompt  .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Radio Mirchi, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span> has been Uploaded with Prompt  <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Prompt <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Prompt  .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Script <span style='color: red'><b>"+id+"_"+cname+" </b></span> has been Uploaded with Prompt  <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
                    ps_mail.setInt(5, 5);
                    int n10 = ps_mail.executeUpdate();
                    if(n10>0){
                        System.out.println("wifi team 3 Inserted In DB");
                    }
                    ps_mail = null;                      
             
 //////////////////// edn of radio mirchi  ////////////////  


}///////////////////////////////////////  total email sending completed ///////////////////////////    
                    //////////////end mail////////////                        
                         
      

     
response.sendRedirect("rejectscripts1.jsp?sts=Script updated with Promts Succesfully.");
                }else{
                
                response.sendRedirect("rejectscripts1.jsp?sts=Script updating Failed.");
                }
                
                
            }catch(Exception ex){
            
            ex.printStackTrace();
            }finally{
            scriptconn.close();
            
            }












%>
    </body>
</html>
