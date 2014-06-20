<%-- 
    Document   : download
    Created on : Mar 15, 2012, 5:16:29 PM
    Author     : wifibharathi
--%>

<%@page import="com.sql.connection.HardcodedValues"%>
<%-- 
    Document   : download
    Created on : Oct 20, 2011, 3:35:17 PM
    Author     : root
--%>

<%@page import="java.util.concurrent.TimeUnit"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page  import="java.io.FileInputStream" %>
<%@ page  import="java.io.BufferedInputStream"  %>
<%@ page  import="java.io.File"  %>
<%@ page import="java.io.IOException" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%-- <a href="http://localhost:8084/Register/load.jsp">Download</a>--%>
        <%
                    // you  can get your base and parent from the database
      /*  String fname=request.getParameter("fname");
        String userid=request.getParameter("userid");
        String base = HardcodedValues.scriptupload;*/
      /*  String base="/home/wifibharathi/Desktop/";
        String fname="Doc1.zip";*/
                    //String parent = "cbs1";
                    //String filename = base;

    //Calendar cal1 = Calendar.getInstance();
      //      java.text.SimpleDateFormat sdf9 = new java.text.SimpleDateFormat("dd-MMM-yyyy");
        //    String strdate1 = sdf9.format(cal1.getTime());i
        String base = HardcodedValues.scriptupload;
        String fname=request.getParameter("fname");
 
                    String filepath =  base + fname;

                    BufferedInputStream buf = null;
                    ServletOutputStream myOut = null;

                    try {

                        myOut = response.getOutputStream();
                        File myfile = new File(filepath);

                        //set response headers
                        response.setContentType ("application/zip; charset=UTF-8"); 



                            fname=fname.replaceAll(" ","");
//fname=fname+"_"+strdate1;
                        response.addHeader("Content-Disposition", "attachment; filename=" + fname);

                        response.setContentLength((int) myfile.length());

                        FileInputStream input = new FileInputStream(myfile);
                        buf = new BufferedInputStream(input);
                        int readBytes = 0;

                        //read from the file; write to the ServletOutputStream
                        while ((readBytes = buf.read()) != -1) {
                            myOut.write(readBytes);
                        }

                    } catch (IOException ioe) {

                        throw new ServletException(ioe.getMessage());

                    } finally {

                        //close the input/output streams
                        if (myOut != null) {
                            myOut.close();
                        }
                        if (buf != null) {
                            buf.close();
                        }

                    }



        %>
        %>
    </body>
</html>

