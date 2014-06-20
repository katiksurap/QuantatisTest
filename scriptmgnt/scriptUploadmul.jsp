

<%@page import="java.util.Calendar"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Enumeration"%>
<%@page import="java.sql.*"%>
<%@page import="com.sql.connection.*"%>
<%@page import="com.logic.mail"%>
<%@page import="com.sun.mail.smtp.*"%>
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

        <title>Script Multiple Upload</title>
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
            Calendar cal1 = Calendar.getInstance();
            java.text.SimpleDateFormat sdf9 = new java.text.SimpleDateFormat("dd-MMM-yyyy");
            String strdate1 = sdf9.format(cal1.getTime());
            System.out.println("came rtroooooooooooooooooooooooooooooooo"+path);
            String filename = "", pathfilename = "";
            String isFileThere = "999";
            String cname = "",checkbox="", desc = "", bgm = "", artistvoice = "", language = "", prompttype = "", uploadfile = "", script = "", user_id = "";
            user_id = session.getAttribute("userid").toString();
            String utype= session.getAttribute("user_type").toString();
            DnFileDestination = path;
           //scId=(Integer)session.getAttribute("scriptId");
             //System.out.println("created by------>"+scId);
           //int scrId=(scId).intValue();

            //System.out.println("created by---"+scrId+"--->"+scId);
            CustomFileRenamePolicy cfrp = new CustomFileRenamePolicy();
            mrequest = new MultipartRequest(request, DnFileDestination, 56 * 1024 * 1024);
           //cname = session.getAttribute("cname2").toString();
                cname=mrequest.getParameter("campname");  
            String scriptid=mrequest.getParameter("scriptid");
       checkbox=mrequest.getParameter("checkbox");                
       String user_type=session.getAttribute("user_type").toString();           
       System.out.println("checkbox value by---"+checkbox);
           System.out.println("campaign name by---"+cname);
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
            File f = new File(DnFileDestination+filename);
            File newfile = new File(DnFileDestination+scriptid+"_"+utype+"_"+checkbox+"_"+strdate1+"_"+filename.trim());
            f.renameTo(newfile);
            pathfilename = newfile.getPath();
            filename = scriptid+"_"+utype+"_"+checkbox+"_"+strdate1+"_"+filename.trim();
            script = mrequest.getParameter("script");
            PreparedStatement scriptpst = null;
            Connection scriptconn = null;
            ResultSet rs = null;
            String qry="";
    Statement stmt=null;
            try {
                SQLManager sm = new SQLManager();
              
                scriptconn = sm.getConnection();
                String Query="select language from scripts where campaignname='"+cname+"'";
               stmt=scriptconn.createStatement();
               rs=stmt.executeQuery(Query); 
              String alllang="";
               
               if(rs.next()){
              alllang=rs.getString("language");
             System.out.println("languages-tobe updated in line in path ---->"+alllang); 
              
             String values[]=alllang.split(",");
             System.out.println();
             if(checkbox.equalsIgnoreCase(values[0])){
             
             
              qry="UPDATE scripts SET lang1=?,lang1path=? WHERE campaignname = ?";
             
             }else if(checkbox.equalsIgnoreCase(values[1]))
                             {
              qry="UPDATE scripts SET lang2=?,lang2path=? WHERE campaignname = ?";
             }else if(checkbox.equalsIgnoreCase(values[2]))
                                 {
                 
                 qry="UPDATE scripts SET lang3=?,lang3path=? WHERE campaignname = ?"; 
                 
                 
             }else if(checkbox.equalsIgnoreCase(values[3])){
             
              qry="UPDATE scripts SET lang4=?,lang4path=? WHERE campaignname = ?";
             }
                         }
              
               // String qry = "insert into scripts(user_id,campaignname,description,bgmusic,artistvoice,prompttype,language,uploaded_fname,uploadpath,scriptdata,username) values(?,?,?,?,?,?,?,?,?,?,?)";
                //String qry="UPDATE scripts SET scriptUpload_fname=?,scriptUpload_path=?,script_status=2 WHERE campaignname = ?";
//String qry="insert into scripts(scriptUpload_fname,scriptUpload_path,script_status,script_status) values(?,?,2) WHERE campaignname =?";
                System.out.println(qry);
                scriptpst = scriptconn.prepareStatement(qry);
                scriptpst.setString(1, filename);
                scriptpst.setString(2, pathfilename);
                
                scriptpst.setString(3, cname);


                int res=scriptpst.executeUpdate();
                System.out.println("RES value"+res);
               
                if(res>0){
                    
         
                    
                    
                    response.sendRedirect("scriptView2.jsp?name="+cname+"&scriptid="+scriptid+"&sts=Script updated for "+checkbox+" Succesfully.");
                                   }else{
                    response.sendRedirect("scriptView2.jsp?name='"+cname+"'&sts=Script updating Failed.");
                              } } catch (SQLException s) {
                s.printStackTrace();
            } finally {
                scriptconn.close();
            }





        %>
    </body>
</html>

