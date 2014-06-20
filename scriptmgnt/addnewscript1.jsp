<%@page import="java.util.Calendar"%>
<%@page import="java.io.File"%>
%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.IOException"%>
<%@page import="java.text.SimpleDateFormat"%>
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
        <title>Add Script</title>
    </head>
    <body>
        <%
            MultipartRequest mrequest = null;
            String DnFileDestination = "";
            String name = "";String createdby="";
            String path = HardcodedValues.scriptupload;
            String filename = "", pathfilename = "";
            String isFileThere = "999";
              ByteArrayOutputStream bos = new ByteArrayOutputStream();
              byte[] buf = new byte[5024];
            String acc_Date = "", acamount = "" , v_acamount ="" , k_acamount = "" , incomplete = "" , acc_pen_date = ""; 
            String cname = "", desc = "", bgm = "", artistvoice = "", language = "", prompttype = "", uploadfile = "", script = "", user_id = "";
            user_id = session.getAttribute("userid").toString();
            DnFileDestination = path;
            String email=HardcodedValues.fromemail;
            String uname=session.getAttribute("uname").toString();  
            createdby=session.getAttribute("uname").toString();
            System.out.println("created by---"+createdby);
            CustomFileRenamePolicy cfrp = new CustomFileRenamePolicy();
            mrequest = new MultipartRequest(request, DnFileDestination, 1024 * 1024 * 1024);
            cname = mrequest.getParameter("cname");
            desc = mrequest.getParameter("desc");
            bgm = mrequest.getParameter("bgm");
            acc_Date  = mrequest.getParameter("acc_date");
            acamount = mrequest.getParameter("acamount");
            v_acamount = mrequest.getParameter("v_acamount");
            k_acamount = mrequest.getParameter("k_acamount");
            incomplete = mrequest.getParameter("incomplete");
            acc_pen_date  = mrequest.getParameter("acc_pen_date");
            String assignedBy = mrequest.getParameter("user_type");
           Calendar cal = Calendar.getInstance();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            String strDate = sdf.format(cal.getTime());
            System.out.println("Current date in String Format: "+strDate);
            strDate = strDate.replaceAll("-","").replaceAll(":","").replaceAll(" ","");
            FileInputStream fis =null ;
            Connection con = null;
            Statement st = null;
            ResultSet rs = null;
            String all2 = "", ps2 = "", finl2 = "";
            System.out.println("before to the acamount"+acamount);
            System.out.println("ibm"+bgm);
    if (bgm.equals("0")) {
                bgm = "ON";
                uploadfile = mrequest.getParameter("uploadfile");
    System.out.println("Upload path---" + uploadfile);
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
                
            } else {
                bgm = "OFF";
                pathfilename = "Standard";
            }
            PreparedStatement scriptpst = null;
            PreparedStatement scriptpst2 = null;
            Connection scriptconn = null;
           ResultSet rst=null;

            try {
                
                SQLManager sm=new SQLManager();
                scriptconn = sm.getConnection();
                String qry = "insert into Accounts_quantatis(Account_name,acc_description,user_id,user_type,account_date,total_amount,venkat_amount,karthik_amount,amount_id,upload_fname,trans_stat";
                      if(acc_pen_date.equalsIgnoreCase("")){
                      qry = qry + ")" ;
                       }else{
                        qry = qry + " ,pending_dated)" ;
                       }                         
                        // qry += qry + " values(?,?,?,?,?,?,?,?,?,?,?)";
                         if(acc_pen_date.equalsIgnoreCase("")){
                     qry = qry + " values(?,?,?,?,?,?,?,?,?,?,?)"; 
                       }else{
                     qry = qry + " values(?,?,?,?,?,?,?,?,?,?,?,?)";
                       } 
                scriptpst = scriptconn.prepareStatement(qry);
                scriptpst.setString(1, cname);
                scriptpst.setString(2, desc);
                scriptpst.setString(3, user_id);
                scriptpst.setString(4, assignedBy);
                scriptpst.setString(5, acc_Date);
                scriptpst.setString(6,acamount);
                scriptpst.setString(7, v_acamount);
                scriptpst.setString(8, k_acamount);
                scriptpst.setString(9, strDate);
                scriptpst.setString(10, pathfilename);
                scriptpst.setString(11, incomplete);
                System.out.println(scriptpst.toString());
                  if(acc_pen_date.equalsIgnoreCase("")){
                      } else{
                    scriptpst.setString(12, acc_pen_date);
                       }
                int res=scriptpst.executeUpdate();
                if(res>0){
               System.out.println("Added Successfully in Accounts_quantatis");
               if("1".equalsIgnoreCase(incomplete)){
                String addsub="insert into account_subtab(account_id,acc_amount,venkat_amount,karthik_amount) values(?,?,?,?)";
                 scriptpst2=scriptconn.prepareStatement(addsub);       
                 scriptpst2.setString(1,strDate);
                 scriptpst2.setString(2,acamount);
                 scriptpst2.setString(3,v_acamount);
                 scriptpst2.setString(4,k_acamount);
                 int subacc=scriptpst2.executeUpdate();
                 if(subacc>0)
                 {
                response.sendRedirect("addnewscript.jsp?sts=Account added Succesfully in Non-Settlement Account");
                }else{
                response.sendRedirect("addnewscript.jsp?sts=Account added Succesfully in Non-Settlement Account , but failed in Sub-Account Transaction");
                }
                }else{
               response.sendRedirect("addnewscript.jsp?sts=Account added Succesfully in Settlement Account");
                      }
                } else {
            response.sendRedirect("addnewscript.jsp?sts=Account adding Failed.");
                }
    } catch (SQLException s) {
        s.printStackTrace();
    } finally {
        scriptconn.close();
        
    }
    %>
   
        
    </body>
</html>
