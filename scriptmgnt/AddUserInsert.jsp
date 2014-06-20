<%@page import="com.logic.mail"%>
<%@ page import="java.util.*" %>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*" %><%@ page import="javax.activation.*" %>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.io.DataOutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.Writer"%>
<%@page import="java.io.FileWriter"%>
<%@page import="java.util.Scanner"%>
<%@page import="java.io.File"%>
<%@page import="java.io.BufferedWriter"%>
<%@page import="com.sql.connection.SQLManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.servlet.http.*,javax.servlet.*" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.sun.mail.smtp.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add User</title>
    </head>
    <body>
        
        <%
            int nFindchname = 0;
            Connection con = null;
            Statement stmt = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null, rs1 = null;
            try {
                SQLManager sq = new SQLManager();

                con = sq.getConnection();
                stmt = con.createStatement();
                String name = request.getParameter("name");
                String user_type = request.getParameter("user_type");
                String mobno = request.getParameter("mobno");
                String emailid = request.getParameter("email");
                String validity = request.getParameter("validity");
                System.out.println("Validity---"+validity);
               

                //Expiry Password
              
                String sql1 = "select * from user_master where name ='" + name + "'";
                rs1 = stmt.executeQuery(sql1);
                System.out.println(sql1);
                if (rs1.next()) {
                    nFindchname = 1;
                    response.sendRedirect("AddUser.jsp?sts=Sorry,UserName already exists");
                } else {
                    nFindchname = 0;
                    String sql = "insert into user_master(name,user_type,mobno,email,validity) values(?,?,?,?,?)";

                    pstmt = con.prepareStatement(sql);
                    pstmt.setString(1, name);

                    pstmt.setString(2, user_type);
                    pstmt.setString(3, mobno);
                    pstmt.setString(4, emailid);
                    pstmt.setString(5, validity);
                    System.out.println("user creation query is" + sql);
                }
                int c = pstmt.executeUpdate();
                if (c > 0) {


                    String to = request.getParameter("email");
                    String from = "admin@wnipl.com";
                    String subject = "Hi,Now You can login into WiFi Script Management application.";
                    String text = "Use this Login details(Keep it Confidential) : "
                            + " \n" + "UserName:"
                            + name
                            + " \n"
                            + "your password is:script123"
                            + " \n"
                            + "Change your password as soon as possible.";
                    System.out.println("hello entered");
                    mail sendMail = new mail(from, to, subject, text);
                    System.out.println("entering");
                    sendMail.send();
                    System.out.println("enterd");

                    response.sendRedirect("AddUser.jsp?sts=User created successfully");

                } else {
                    response.sendRedirect("AddUser.jsp?sts=Fail to add user");
                }

                rs1.close();
                stmt.close();
            } catch (Exception e) {
                System.out.println(e);
                e.printStackTrace();
            }

        %>


    </body>
</html>
