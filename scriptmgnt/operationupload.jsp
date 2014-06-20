<%-- 
    Document   : addnewscript1
    Created on : Mar 5, 2012, 12:18:48 PM
    Author     : wifibharathi
--%>

<%@page import="com.logic.mail"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.*"%>

<%@page import="com.sql.connection.*"%>
<%@page import="com.sun.mail.smtp.*"%>
<%@page import="action.CustomFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
            user_id = session.getAttribute("userid").toString();
            DnFileDestination = path;
            createdby=session.getAttribute("uname").toString();
            System.out.println("created by---"+createdby);
            CustomFileRenamePolicy cfrp = new CustomFileRenamePolicy();
            mrequest = new MultipartRequest(request, DnFileDestination, 56 * 1024 * 1024);
            cname = mrequest.getParameter("cname");
            //desc = mrequest.getParameter("desc");
         // bgm = mrequest.getParameter("bgm");
       // artistvoice = mrequest.getParameter("artist");
          
           // prompttype = mrequest.getParameter("prompt");
Connection con = null;
        Statement st = null;
        ResultSet rs = null;

////////////////////////////////// this is for the language//////////////////////
                                String all="",ps="",finl="";
         //  String comma=",";
            String pavi[]=mrequest.getParameterValues("sel2");
            for(int i=0;i<pavi.length;i++)
                                        {
                                               
                                         String strval = pavi[i];
                                         all=pavi[i]+",";
                                 ps=ps+all;
                                        System.out.println("values all ------" +ps);
                                  System.out.println("pavivalues--->"+strval);       
                                         
                                  }
              
                                  System.out.println("values all ------" +ps);
                  language =ps ; 
////////////////////////////////this is for prompt type//////////////////
     
String all2="",ps2="",finl2="";
System.out.println("before to the");
           String prmt[]=mrequest.getParameterValues("sel22");
           System.out.println("came to the next"+prmt);
 for(int j=0;j<prmt.length;j++){
 
     
     String strval1=prmt[j];
     all2=prmt[j]+",";
     ps2=ps2+all2;
     
 }                                                      
     
prompttype=ps2;
System.out.println("promt type"+prompttype);
                          // String pavivalues=mrequest.getParameter("sel2");
          
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
           

            try {
                SQLManager sm = new SQLManager();
               
                scriptconn = sm.getConnection();
                String qry = "insert into scripts(user_id,campaignname,description,bgmusic,artistvoice,prompttype,language,uploaded_fname,uploadpath,scriptdata,username) values(?,?,?,?,?,?,?,?,?,?,?)";

                scriptpst = scriptconn.prepareStatement(qry);
                scriptpst.setString(1, user_id);
                scriptpst.setString(2, cname);
                scriptpst.setString(3, desc);
                scriptpst.setString(4, bgm);
                scriptpst.setString(5, artistvoice);
                scriptpst.setString(6, language);
                scriptpst.setString(7, prompttype);
                scriptpst.setString(8, filename);
                scriptpst.setString(9, pathfilename);
                scriptpst.setString(10, script);
                scriptpst.setString(11, createdby);

                int res=scriptpst.executeUpdate();
                if(res>=1){
                    
                    
                    
                    
                    
                    String userid=createdby;
                    String to="";
                  
                    con = SQLManager.getConnection();
            st = con.createStatement();
            String squery = "select email from user_master where name='"+userid+"'";
            rs = st.executeQuery(squery);
            if(rs.next()) {       
                    
                    
                   to=rs.getString("email").trim();
                    
              //  to="karthik.surapraju@wnipl.com";
                        System.out.println("mnail. i9dm " +to);
                    String from = "admin@wnipl.com";
                    String subject = "Hi,Now Your New Script Has Been Created In Script Management application.";
                    String text = "Your Script Has Been Created With Details Of  : "
                            + " \n" + "UserId :"
                            + user_id
                            + " \n"
                            + "campaignname :"
                            
                            +cname
                            + " \n"
                            +"BackGround Music :"
                            +bgm
                            +"\n"
                            +"Voice Over Artist :"
                            +artistvoice
                            +"\n Language's :"
                            +language
                            +"\n Prompt Type : "
                            +prompttype
                            +"\n Prompt File:"
                           + filename
                           +"\n Promt Path :"
                           +pathfilename
                            +" \n Script :"
                            +script ;
                    System.out.println("hello entered");
                    mail sendMail = new mail(from, to, subject, text);
                    System.out.println("entering");
                    sendMail.send();
                    System.out.println("enterd");
                    
                    
                                       }else{
                                       response.sendRedirect("addnewscript.jsp?sts=Script added Succesfully.But mail not sent");
                                       }
                    response.sendRedirect("addnewscript.jsp?sts=Script added Succesfully.");
                                   }else{
                    response.sendRedirect("addnewscript.jsp?sts=Script adding Failed.");
                                   }            } catch (SQLException s) {
                s.printStackTrace();
            } finally {
            }





        %>
    </body>
</html>