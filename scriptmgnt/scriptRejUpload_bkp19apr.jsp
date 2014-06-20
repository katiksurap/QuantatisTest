<%-- 
    Document   : scriptRejUpload
    Created on : Mar 22, 2012, 12:20:39 PM
    Author     : Rani
--%>

<%@page import="com.logic.mail"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.sql.connection.SQLManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Enumeration"%>
<%@page import="action.CustomFileRenamePolicy"%>
<%@page import="com.sql.connection.HardcodedValues"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>

<%
            System.out.println("Enter upload");
            MultipartRequest mrequest = null;
            String DnFileDestination = "";
            String name = "";Integer scId ;
            String path = HardcodedValues.scriptupload;
            String filename = "", pathfilename = "";
            String isFileThere = "999";
            String cname = "", desc = "", bgm = "", artistvoice = "", language = "", prompttype = "", uploadfile = "", script = "", user_id = "";
            //user_id = session.getAttribute("userid").toString();
            DnFileDestination = path;
          // scId=(Integer)session.getAttribute("scriptId");
             //System.out.println("created by------>"+scId);
           //int scrId=(scId).intValue();

           // System.out.println("created by---"+scrId+"--->"+scId);
            CustomFileRenamePolicy cfrp = new CustomFileRenamePolicy();
            mrequest = new MultipartRequest(request, DnFileDestination, 56 * 1024 * 1024);
           cname = mrequest.getParameter("campName");
            System.out.println("created by---"+cname);

            uploadfile = mrequest.getParameter("upFile");
            System.out.println("Upload path---"+uploadfile);
            Enumeration fi = mrequest.getFileNames();
            while (fi.hasMoreElements()) {
                name = (String) fi.nextElement();
                System.out.println("name----" + name);
                filename = mrequest.getFilesystemName(name);
 user_id = session.getAttribute("userid").toString();
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
                String qry="UPDATE scripts SET scriptUpload_fname=?,scriptUpload_path=?,script_status=2,status=1 WHERE campaignname = ?";

                System.out.println(qry);
                scriptpst = scriptconn.prepareStatement(qry);
                scriptpst.setString(1, filename);
                scriptpst.setString(2, pathfilename);

                scriptpst.setString(3, cname);


                int res=scriptpst.executeUpdate();
                System.out.println("RES value"+res);

                if(res>0){
                    
           /*           String   to=HardcodedValues.studiomail;
                   String  to1 = HardcodedValues.opmail;
              //  to="karthik.surapraju@wnipl.com";
                        System.out.println("mnail. i9dm " +to);
                    String from = "admin@wnipl.com";
                    String subject = "Hi,Now Your Script with "+cname+" Has Been Approved By Operator .";
                    String text = "Your Script Has Been Created With Following Details : "
                            + " \n" + "UserId :"
                            + user_id
                            + " \n"
                            + "campaignname :"
                            
                            +cname
                            + " \n"
                           +"Filename"
                           +filename
                            +"\n"
                            +"File Path :"
                          +pathfilename
                          
                         
                            +"\n"
                            +"Regards ,\n"
                            +"OPERATOR";
                    System.out.println("hello entered");
                    mail sendMail = new mail(from, to, subject, text);
                    sendMail.send();
                    System.out.println("completed first mail");
                     mail sendMail2 = new mail(from, to1, subject, text);
                     
                     sendMail2.send();
                    */
                    
                    response.sendRedirect("rejectscripts1.jsp?sts=File uploaded successfully");
                                 }  else{
                                       response.sendRedirect("rejectscripts1.jsp?sts=Error occured while uploading");
            }} catch (SQLException s) {
                s.printStackTrace();
            } finally {
            }


%>

