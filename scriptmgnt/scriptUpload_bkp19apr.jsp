

<%@page import="com.logic.mail"%>
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
        <link href="../css/style.css" rel="stylesheet" type="text/css"  media="screen"/>
        <script type="text/javascript" src="../scripts/menu.js"></script>
        <script type="text/javascript" src="../scripts/alternatetable.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/tcal.css" />
        <script type="text/javascript" src="../scripts/tcal.js"></script>

        <title>JSP Page</title>
        <script type="text/javascript">

            </script>
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
    </head>
    <body>
        <%
            MultipartRequest mrequest = null;
            String DnFileDestination = "";
            String name = "";Integer scId ;
            String path = HardcodedValues.scriptupload;
            String filename = "", pathfilename = "";
            String isFileThere = "999";
            String cname = "", desc = "", bgm = "", artistvoice = "", language = "", prompttype = "", uploadfile = "", script = "", user_id = "";
            //user_id = session.getAttribute("userid").toString();
            DnFileDestination = path;
           scId=(Integer)session.getAttribute("scriptId");
         //  String email = session.getAttribute("email").toString();
           String uname = session.getAttribute("uname").toString();
             System.out.println("created by------>"+scId);
           int scrId=(scId).intValue();

            System.out.println("created by---"+scrId+"--->"+scId);
            CustomFileRenamePolicy cfrp = new CustomFileRenamePolicy();
            mrequest = new MultipartRequest(request, DnFileDestination, 56 * 1024 * 1024);
           cname = mrequest.getParameter("cname2");
            System.out.println("created by---"+cname);
           user_id = session.getAttribute("userid").toString();
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
                String qry="UPDATE scripts SET scriptUpload_fname=?,scriptUpload_path=?,script_status=2 WHERE script_id = ?";

                System.out.println(qry);
                scriptpst = scriptconn.prepareStatement(qry);
                scriptpst.setString(1, filename);
                scriptpst.setString(2, pathfilename);
                
                scriptpst.setInt(3, scrId);


                int res=scriptpst.executeUpdate();
                System.out.println("RES value"+res);
               
                if(res>0){
                   /*  PreparedStatement ps_mail = null;
                    String in_qry = "insert into email_sending(from_mail,to_mail,subject,message,status,inserted_date) values(?,?,?,?,?,now())";
                    /////////to login user////////
                    ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.studiomail2);
                    ps_mail.setString(3, "Script Reques");
                    ps_mail.setString(4, "Hi,\n \tYour requested script for campaign "+cname+" has been updated as per the request. \n Regards \n "+uname+"");
                    ps_mail.setInt(5, 5);
                    int n1 = ps_mail.executeUpdate();
                    if(n1>0){
                        System.out.println("1st Inserted In DB");
                    }
                    ps_mail = null;
                    /////////to default user///////
                    ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.studiomail);
                    ps_mail.setString(3, "Script Reques");
                    ps_mail.setString(4, "Hi,\n \tYour requested script for campaign "+cname+" has been updated as per the request. \n Regards \n "+uname+"");
                    ps_mail.setInt(5, 5);
                    int n2 = ps_mail.executeUpdate();
                    if(n2>0){
                        System.out.println("2nd Inserted In DB");
                    }
                    ps_mail = null;
                    /////////to operations/////////
                    ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.opmail);
                    ps_mail.setString(3, "Script Reques");
                    ps_mail.setString(4, "Hi Operations,\n \tYour requested script for campaign "+cname+" has been updated as per the request. \n Regards \n "+uname+"");
                    ps_mail.setInt(5, 5);
                    int n3 = ps_mail.executeUpdate();
                    if(n3>0){
                        System.out.println("3rd Inserted In DB");
                    }
                    ps_mail = null;
                    //////////////end mail////////////
            /*        String  to=HardcodedValues.studiomail;
                    String  to1 = HardcodedValues.opmail;
              //  to="karthik.surapraju@wnipl.com";
                        System.out.println("mnail. i9dm " +to);
                    String from = "admin@wnipl.com";
                    String subject = "Hi, Your New Script for the campaign "+cname+" Has Been Uploaded By Studio Team .";
                    String text = "Your Script Has Been Uploaded With Following Details Of  : "
                            + " \n" + "UserId :"
                            + user_id
                            + " \n"
                            + "campaignname :"
                            
                            +cname
                         +"\n Promt Path :"
                           +pathfilename
                          
                            +"\n\n"
                            +"Regards.,\n"
                            +"Studio Team";
                    System.out.println("hello entered");
                    mail sendMail = new mail(from, to, subject, text);
                    sendMail.send();
                    System.out.println("completed first mail");
                     mail sendMail2 = new mail(from, to1, subject, text);
                     
                     sendMail2.send();
                    System.out.println("2 nd mail over and ....completed mails");
                    ////////////////////
                    
                    */
                    response.sendRedirect("scriptpending1.jsp?sts=Script added Succesfully.");
                }else{
                    response.sendRedirect("scriptpending1.jsp?sts=Script adding Failed.");
                              } } catch (SQLException s) {
                s.printStackTrace();
            } finally {
            }





        %>
    </body>
</html>
