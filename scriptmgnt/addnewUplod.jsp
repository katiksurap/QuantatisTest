<%-- 
    Document   : addnewUplod
    Created on : Mar 20, 2012, 11:00:21 AM
    Author     : Rani
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.*"%>

<%@page import="com.sql.connection.*"%>

<%@page import="action.CustomFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Upload</title>
    </head>
    <body>
        <%
            MultipartRequest mrequest = null;
            String DnFileDestination = "";
            String name = "";String createdby="";
            String path = HardcodedValues.scriptupload;
            String filename = "", pathfilename = "";
            String isFileThere = "999";
            String cname = "", desc = "", bgm = "", artistvoice = "", language = "", prompttype = "", uploadfile = "", script = "", user_id = "";
            //user_id = session.getAttribute("userid").toString();
            DnFileDestination = path;
           // createdby=session.getAttribute("uname").toString();
           // System.out.println("created by---"+createdby);
            CustomFileRenamePolicy cfrp = new CustomFileRenamePolicy();
            mrequest = new MultipartRequest(request, DnFileDestination, 56 * 1024 * 1024);
            cname = session.getAttribute("cname").toString();
            System.out.println("created by---"+cname);
           // desc = mrequest.getParameter("desc");
            //bgm = mrequest.getParameter("bgm");
            //artistvoice = mrequest.getParameter("artist");
           // language = mrequest.getParameter("lang");
            //prompttype = mrequest.getParameter("prompt");
            uploadfile = mrequest.getParameter("uploadfile");
            System.out.println("Upload path---"+uploadfile);
            Enumeration fi = mrequest.getFileNames();
            while (fi.hasMoreElements()) {
                name = (String) fi.nextElement();
                System.out.println("name----" + name);
                filename = mrequest.getFilesystemName(name);

                pathfilename = path + filename;

                System.out.println("File name----" + filename);
                if (name.equals("ufile")) {
                    if (null != filename) {
                        isFileThere = filename;
                    }
                }
            }
            script = mrequest.getParameter("script");
            PreparedStatement scriptpst = null;
            Connection scriptconn = null;
            ResultSet rs = null;

            try {
                SQLManager sm = new SQLManager();
                scriptconn = sm.getConnection();
               // String qry = "insert into scripts(user_id,campaignname,description,bgmusic,artistvoice,prompttype,language,uploaded_fname,uploadpath,scriptdata,username) values(?,?,?,?,?,?,?,?,?,?,?)";
                String qry="UPDATE scripts SET uploaded_fname = ? ,uploadpath=? WHERE campaignname = ?";
                scriptpst = scriptconn.prepareStatement(qry);
                
                
                scriptpst.setString(1, filename);
                scriptpst.setString(2, pathfilename);
                scriptpst.setString(3, cname);
               

                int res=scriptpst.executeUpdate();
                session.removeAttribute("cname");
                if(res>=1)
                    response.sendRedirect("studioupload.jsp?sts=Script added Succesfully.");
                else
                    response.sendRedirect("studioupload.jsp?sts=Script adding Failed.");
            } catch (SQLException s) {
                s.printStackTrace();
            } finally {
            }





        %>
    </body>
</html>