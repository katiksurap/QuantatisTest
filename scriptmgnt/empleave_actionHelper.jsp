<%@page import="java.util.Calendar"%>
<%@page import="java.io.File"%>
<%@page import="java.io.File"%>
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

<%@page import="org.apache.commons.lang.time.DateUtils"%>
<%@page import="com.logic.GetNextDate"%><html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Empleave</title>
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
            String emp_date = "", acamount = "" , v_acamount ="" , k_acamount = "" , incomplete = "" , acc_pen_date = ""; 
            String empsal = "", empsalpm = "", desc = "" ,cname = "",empid = "",empadd="",empmob="",bgm = "", empdep = "",artistvoice = "", language = "", prompttype = "", uploadfile = "", script = "", user_id = "";
            user_id = session.getAttribute("userid").toString();
            DnFileDestination = path;
            String email=HardcodedValues.fromemail;
            String uname=session.getAttribute("uname").toString();  
            createdby=session.getAttribute("uname").toString();
            System.out.println("created by---"+createdby);
            CustomFileRenamePolicy cfrp = new CustomFileRenamePolicy();
            mrequest = new MultipartRequest(request, DnFileDestination, 1024 * 1024 * 1024);
            cname = mrequest.getParameter("cname");
            empsal = mrequest.getParameter("empsal");
            empsalpm = mrequest.getParameter("empsalpm");
            empid = mrequest.getParameter("empid");
            empadd =  mrequest.getParameter("empadd");
            empmob = mrequest.getParameter("empmob");
            desc = mrequest.getParameter("desc");
            empdep = mrequest.getParameter("empdep");
            bgm = mrequest.getParameter("bgm");
            emp_date  = mrequest.getParameter("emp_date");
            String assignedBy = mrequest.getParameter("user_type");
            String emprep = mrequest.getParameter("emprep");
            String prb_period = mrequest.getParameter("prb_period");
            String empprblev  = mrequest.getParameter("prb_leaves");
            String empprmnlev  = mrequest.getParameter("prmnt_leaves");
            Calendar cal = Calendar.getInstance();
            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
            String strDate = sdf.format(cal.getTime());
            System.out.println("Current date in String Format: "+strDate);
            strDate = strDate.replaceAll("-","").replaceAll(":","").replaceAll(" ","");
            strDate = empid + strDate ;
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
          String Prob_CompDate = GetNextDate.getNextDate(emp_date,Integer.parseInt(prb_period));
            PreparedStatement scriptpst = null;
            PreparedStatement scriptpst2 = null;
            Connection scriptconn = null;
           ResultSet rst=null;

            try {
                
                SQLManager sm=new SQLManager();
                scriptconn = sm.getConnection();
                String qry = "insert into emp_detail(Emp_Sal,Emp_Sal_pm,Emp_Name,Emp_ID,Emp_address,Emp_Mob,Emp_Desc,Emp_Dept,Emp_addby,uploadfilepath,Emp_joined,Emp_prb,Emp_prb_lev,Emp_perm_leve,Emp_Unq_num,Emp_Prb_Enddate,Emp_rep) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                scriptpst = scriptconn.prepareStatement(qry);
                scriptpst.setString(1, empsal);
                scriptpst.setString(2, empsalpm);
                scriptpst.setString(3, cname);
                scriptpst.setString(4, empid);
                scriptpst.setString(5, empadd);
                scriptpst.setString(6,empmob);
                scriptpst.setString(7, desc);
                scriptpst.setString(8, empdep);
                scriptpst.setString(9, user_id);
                scriptpst.setString(10, pathfilename);
                scriptpst.setString(11, emp_date);
                scriptpst.setString(12, prb_period);
                scriptpst.setString(13, empprblev);
                scriptpst.setString(14, empprmnlev);
                scriptpst.setString(15, strDate);
                scriptpst.setString(16, Prob_CompDate);
                scriptpst.setString(17, emprep);
                System.out.println(scriptpst.toString());
                
                int res=scriptpst.executeUpdate();
                if(res>0){
               System.out.println("Added Successfully in Emp Detail");
               response.sendRedirect("empleave.jsp?sts=Account adding Success.");
                } else {
            response.sendRedirect("empleave.jsp?sts=Account adding Failed.");
                }
    } catch (SQLException s) {
        s.printStackTrace();
    } finally {
        scriptconn.close();
        
    }
    %>
   
        
    </body>
</html>
