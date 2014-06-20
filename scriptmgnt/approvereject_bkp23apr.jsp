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

            try {
                SQLManager sm = new SQLManager();
                scriptconn = sm.getConnection();
                String userid = request.getParameter("userid");
                String cname = request.getParameter("cname");
                String status = request.getParameter("status");
                System.out.println("In approvereject val's---" + status);
                String qry = "update scripts set status=?,approveddate=now() where user_id=? and campaignname=?";

                scriptpst = scriptconn.prepareStatement(qry);
                scriptpst.setString(1, status);
                scriptpst.setString(2, userid);
                scriptpst.setString(3, cname);
                boolean i = scriptpst.execute();
                System.out.println("Boolen val---" + i);
                if (i == false) {
                    
  /*                String   to=HardcodedValues.studiomail;
                   String  to1 = HardcodedValues.opmail;
              //  to="karthik.surapraju@wnipl.com";
                        System.out.println("mnail. i9dm " +to);
                    String from = "admin@wnipl.com";
                    String subject = "Hi,Now Your Script with "+cname+" Has Been Approved By Operator .";
                    String text = "Your Script Has Been Approved With Following Details Of  : "
                            + " \n" + "UserId :"
                            + userid
                            + " \n"
                            + "campaignname :"
                            
                            +cname
                            + " \n"
                           
                            +"\n"
                          
                          
                         
                            +""
                            +"Regards ,\n"
                            +"OPERATOR";
                    System.out.println("hello entered");
                    mail sendMail = new mail(from, to, subject, text);
                    sendMail.send();
                    System.out.println("completed first mail");
                     mail sendMail2 = new mail(from, to1, subject, text);
                     
                     sendMail2.send();
                    System.out.println("2 nd mail over and ....completed mails");
*/
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
