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
 //String createdby=session.getAttribute("uname").toString();
 //String mobno=session.getAttribute("mobno").toString();

 String campaign = request.getParameter("campaign");
            try {
                SQLManager sm = new SQLManager();
                scriptconn = sm.getConnection();
              qry="UPDATE scripts SET script_status=2 WHERE campaignname = ?";
               // String qry = "insert into scripts(user_id,campaignname,description,bgmusic,artistvoice,prompttype,language,uploaded_fname,uploadpath,scriptdata,username) values(?,?,?,?,?,?,?,?,?,?,?)";
                //String qry="UPDATE scripts SET scriptUpload_fname=?,scriptUpload_path=?,script_status=2 WHERE campaignname = ?";
//String qry="insert into scripts(scriptUpload_fname,scriptUpload_path,script_status,script_status) values(?,?,2) WHERE campaignname =?";
                System.out.println(qry);
                scriptpst = scriptconn.prepareStatement(qry);
                scriptpst.setString(1, campaign);
                int res=scriptpst.executeUpdate();
                System.out.println("RES value"+res);
                if(res>0){
                    
                  /*   sms sms = new sms();
 int n = sms.send_sms(mobno, ""+createdby+" has uploaded Promt for the script of campaign name "+campaign+""); 
 if(n>0){
     System.out.println("inserted in smshist for operator "+createdby+"");
 }
 /////////default 1 sms//////////
 
 n = sms.send_sms(HardcodedValues.default1, ""+createdby+" has uploaded Promt for the script of campaign name "+campaign+" kindly do the needful");
 if(n>0){
     System.out.println("Successfully inserted sms details for default1");
 }
 ///////////default 2 sms ////////
 n = sms.send_sms(HardcodedValues.default2, ""+createdby+" has uploaded Promt for the script of campaign name "+campaign+"");
 if(n>0){
     System.out.println("Successfully inserted sms details for default2");
 }
 ///////////default 3 sms/////////
 n = sms.send_sms(HardcodedValues.default3, ""+createdby+" has uploaded Promt for the script of campaign name "+campaign+"");
 if(n>0){
     System.out.println("Successfully inserted sms details for default3");
 }
 /////////////studio sms////////
 n = sms.send_sms(HardcodedValues.studiomobno, ""+createdby+" has Uploaded Promt for the script of campaign name "+campaign+""); 
 if(n>0){
     System.out.println("Successfully inserted sms details for studio");
 }
 ////////////operations sms////////
 n = sms.send_sms(HardcodedValues.operationsmobno, ""+createdby+" has Uploaded Promt for the script of campaign name "+campaign+" "); 
 if(n>0){
     System.out.println("inserted in smshist for operations");
 }
                    
                    
         */           
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                  response.sendRedirect("scriptpending1.jsp?sts=Script updated with Promts Succesfully.");
                }else{
                
                response.sendRedirect("scriptpending1.jsp?sts=Script updating Failed.");
                }
                
                
            }catch(Exception ex){
            
            ex.printStackTrace();
            }finally{
            scriptconn.close();
            
            }












%>
    </body>
</html>
