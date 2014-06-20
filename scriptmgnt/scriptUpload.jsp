

<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
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
            Calendar cal1 = Calendar.getInstance();
            java.text.SimpleDateFormat sdf9 = new java.text.SimpleDateFormat("dd-MMM-yyyy");
            String strdate1 = sdf9.format(cal1.getTime());
           scId=(Integer)session.getAttribute("scriptId");
           //String email = session.getAttribute("email").toString();
           
           String email=HardcodedValues.fromemail;
 
           String uname = session.getAttribute("uname").toString();
           String utype= session.getAttribute("user_type").toString();
             System.out.println("created by------>"+scId);
           int scrId=(scId).intValue();
           //DnFileDestination  = DnFileDestination+scrId+"_"+strdate1+"_";
            System.out.println("created by---"+scrId+"--->"+scId);
            CustomFileRenamePolicy cfrp = new CustomFileRenamePolicy();
            System.out.println("this is the request"+request);
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
               //pathfilename = path + scrId+"_"+strdate1+"_"+filename.trim();
//filename =scrId+"_"+strdate1+"_"+filename.trim();
                System.out.println("File name----" + filename);
                if (name.equals("ufile")) {
                    if (null != filename) {
                        isFileThere = filename;
                    }
                }
            }
            
            File f = new File(DnFileDestination+filename);
  File newfile = new File(DnFileDestination+scrId+"_"+utype+"_"+strdate1+"_"+filename.trim());
            f.renameTo(newfile);
            pathfilename = newfile.getPath();
            filename = scrId+"_"+utype+"_"+strdate1+"_"+filename.trim();
            script = mrequest.getParameter("script");
            PreparedStatement scriptpst = null;
            Connection scriptconn = null;
            ResultSet rs = null;
String assignedTo =utype;
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
     
/////////////////////// email sending starts //////////////////////////////////

                
int id= scrId;                                                  
               PreparedStatement ps_mail = null;
                    String in_qry = "insert into email_sending(from_mail,to_mail,subject,message,status,inserted_date) values(?,?,?,?,?,now())";
                    /////////to login user////////
                    ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.operator1);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Updated by prmmpt , kindly do Needful.<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center> ");
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
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Updated by Prompt File , Kindly do needful .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Updated by Prompt File , Kindly do needful .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Studio Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Updated by Prompt File , went for Operator Approval.<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Studio Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with the prompt file, went for Operator Approval.<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Radio Mirchi, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded,went for Operator approval  .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Radio Mirchi, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Prompt file ,,went for Operator approval  <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Updated with prompt file ,went for Operator approval <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Updated with Prompt,went for Operator approval .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded By prompt,went for Operator approval <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
                    ps_mail.setInt(5, 5);
                    int n10 = ps_mail.executeUpdate();
                    if(n10>0){
                        System.out.println("wifi team 3 Inserted In DB");
                    }
                    ps_mail = null;                      
             
 //////////////////// edn of radio mirchi  ////////////////  


}///////////////////////////////////////  total email sending completed ///////////////////////////    
                    //////////////end mail////////////
          
         
                    
                    
                    
                    
                    
                    
                    
                    response.sendRedirect("scriptpending1.jsp?scriptid="+scrId+"&name="+cname+"&sts=Script added Succesfully.");
                                  }else{
                    response.sendRedirect("scriptpending1.jsp?sts=Script adding Failed.");
                              } } catch (SQLException s) {
                s.printStackTrace();
            } finally {
                scriptpst.close();
                scriptconn.close();
                
            }





        %>
    </body>
</html>

