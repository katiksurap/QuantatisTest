<%-- 
    Document   : scriptpending1
    Created on : Mar 5, 2012, 1:32:25 PM
    Author     : wifibharathi
--%>
<%@page import="java.sql.Statement"%>
<%@page import="action.CustomFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
<%@page import="com.sql.connection.SQLManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.sql.connection.HardcodedValues"%>
<%@page import="com.logic.mail"%>
<%@page import="java.sql.SQLException"%>
<%@page import="pagination.paginationbean"%>
<%@page import="pagination.paging"%>
<%@page import="java.util.ArrayList"%>
<%@page import="pagination.pagination"%>
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
            //window.history.forward();
            function noBack() {
                window.history.forward();
            }
        </script>
    

  <script type="text/javascript">
            function Rejscriptvalidation(rownum){
              // alert("hi");
                var file=document.getElementById(rownum).value;
               //alert(file.contains(".zip"));
               
               var filesplit=file.split(".");
               var totle=filesplit.length;
               
               var ch=filesplit[totle-1];
               //alert(ch);
               
               
              //alert(filesplit.length);
             // alert()
               //var emailPat=/.wav/;
               //var emailPat2=/.mp3/;
               //var matchArray=file.match(emailPat);
               
               //alert(matchArray);
               
               //var matchArray2=file.match(emailPat2);
        if(!(filesplit[1]=="mp3" || filesplit[1]=="wav"))
                {
                    alert("Browse The mp3/wav File......")
                    document.getElementById(rownum).focus();
                    return false;
                }
               
             
                return true;
            }
        </script>
    
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        
       
        <% // if ((request.getParameter("sdate") != null) && (request.getParameter("edate") != null)) {
                String stdate = request.getParameter("sdate");
                String edate = request.getParameter("edate");
                String cname1="";
               String status="1,2";
               String user_type=session.getAttribute("user_type").toString();
      
              String cname=request.getParameter("name");
              String scriptid = request.getParameter("scriptid");
                int i=1;
                int scriptsts=1;
       
                    
                    
                    
        System.out.println("Campaign name="+cname);
        String query="";
        PreparedStatement pstmt = null;
            Connection conn = null;
            ResultSet rs = null;
  int mn=1;
            try {
                SQLManager sm = new SQLManager();
            conn = sm.getConnection();
            query = "select * from  scripts where script_id=? and campaignname=? and assignedTo=? ";
            
            pstmt = conn.prepareStatement(query);
            pstmt.setInt(1,Integer.parseInt(scriptid));
            pstmt.setString(2,cname);
            pstmt.setString(3, user_type);

            System.out.println("Qry frm pagination---"+query);
            rs = pstmt.executeQuery();
                System.out.println("Qry frm pagination---"+query);
            while (rs.next()) {
                    
                    
                    
                    
                    
                    
        %>
        <div id="heading"></div>

        <h3 align="center">Existing Scripts Details</h3>
        
        
        
        <table align="center"  border="1" id="mytable" class="attable">


            <tr>
                <th>Script ID</th>
                <th>Campaign Name</th>
                
                <th>Options</th>
                
                <th>Script Data</th>
                <th>Requested At</th>
                <th>Requested By</th>
                <th>Language/s</th>
                    <th>Language/s<br> uploaded</th>
              
          
               </tr>
            <%
                
                
int scriptsts2=0;

               
            %>
            <tr>
                <td>
                  <%=rs.getInt("script_id")%>
                </td>

                <td>
                    <%=rs.getString("campaignname")%><%  cname1=rs.getString("campaignname");System.out.println("campnmae is ="+cname1);
                    %>
                    <input type="hidden" id="name" name="name" value="<%=cname1%>">
                </td>
                
                <td>
                    <font style="color: #B47474">Back Ground Music :</font> <%=rs.getString("bgmusic")%><br>
                    <font style="color: #B47474">Voice Over Artist :</font> <%=rs.getString("artistvoice")%><br>
                     <font style="color: #B47474">Languages         :</font> <%=rs.getString("language")%><br>
                  
                </td>
               
                <td>
                  <div style="width:250px; height:150px; overflow-x:hidden; overflow-y:scroll;  margin:0px auto; clear:both; overflow:auto;">
                       <%=rs.getString("scriptdata")%>
                    </div>
                </td>
                <td>
                    <%=rs.getString("inserted_time")%>
                </td>
                <td><%=rs.getString("username")%></td>
                <td>
                    <%
                    
                    
                    
                    String language=rs.getString("language");
                    System.out.println("languages -----------"+language);                      
                    
                    
                    String values[]=language.split(",");
                  int valueslen=values.length;
                  System.out.println("original languages length"+valueslen);
                    for(int k=0;k<values.length;k++)
                        {
                        
                       // RecNo
                        //String div[]={};
                        String rownum = String.valueOf(mn)+String.valueOf(k);
                    %>

<input type="checkbox" id="modtype" name="modtype"  value="<%=values[k]%>" onclick="showMe('div<%=rownum%>', this)"/><%=values[k]%>
<br>

<div class="row" id="div<%=rownum%>"  style="display:none"> <form action="scriptUploadmul.jsp" method="post" enctype="multipart/form-data" onsubmit="return Rejscriptvalidation(<%=rownum%>)"><input type="file" name="uploadfile" id="<%=rownum%>"  />
    <input type="hidden" name="checkbox" value="<%=values[k]%>">
                   <input type="hidden" name="scriptid" value="<%=rs.getInt("script_id")%>">
    <%
System.out.println("this is the campaign name which is going to be -- "+cname1);    

%>
        <input type="hidden" name="campname" value="<%=cname1%>">
        <input type="Submit" value="upload" name="uplod" onclick="return checkbrowse()" class="btn" />
</form>
</div>

  
</form><script type="text/javascript">
<!--
function showMe (it, box) {
var vis = (box.checked) ? "block" : "none";
document.getElementById(it).style.display = vis;
}
-->
</script>
   
          
                        
        <%
                        System.out.println("values"+values[k]);
                        }
                    
                    
                    %>
        
</td> 
<%
           ////////////this is for languages upaded showing///////////         
PreparedStatement scriptpstcmp = null;
Connection scriptconncmp = null; 

String addval="";
int addvallength=0;                   
String displayedlang="";         
Connection scriptconn = null;
ResultSet rs2 = null;
 String qry="";
 Statement stmt=null;
            try {
                SQLManager sm2 = new SQLManager();
                
                
       
                String lang1="";
                String lang2="";
                String lang3="";
                String lang4="";
                scriptconn = sm2.getConnection();
                String Query="select * from scripts where campaignname='"+rs.getString("campaignname")+"'";
               stmt=scriptconn.createStatement();
               rs2=stmt.executeQuery(Query);     
                    if(rs2.next()){
                      lang1=rs2.getString("lang1");
                      lang2=rs2.getString("lang2");
                      lang3=rs2.getString("lang3");
                      lang4=rs2.getString("lang4");                                                                 
                        
                    }
                    if(lang1==null){
                  
                    }else{
                  addval=","+values[0];
                   displayedlang=values[0];
  }if(lang2==null){}
                 else{
                   addval+=","+values[1];
                 displayedlang+="<br>"+values[1];
                 }            
   if(lang3==null){}
else{
               addval+=","+values[2];    
displayedlang+="<br>"+values[2];
}if(lang4==null){}                               
                    else{
                  addval+=","+values[3];
                    displayedlang+=values[3];
                    }
               String langup[]=addval.split(",");
               
               System.out.println("vaules of array"+addval);
                 addvallength=langup.length-1;
                 if(valueslen==addvallength){
                 try {
                SQLManager sm3 = new SQLManager();
                scriptconncmp = sm3.getConnection();
              qry="UPDATE scripts SET script_status=2 WHERE campaignname = ? and script_id=?";
                 
                 scriptpstcmp = scriptconncmp.prepareStatement(qry);
                scriptpstcmp.setString(1,rs.getString("campaignname"));
                scriptpstcmp.setInt(2,rs.getInt("script_id"));
                int res=scriptpstcmp.executeUpdate();
                System.out.println("RES value"+res);
                if(res>0){
 String uname =session.getAttribute("user_type").toString();
 String assignedTo =rs.getString("assignedTo");
   String email=HardcodedValues.fromemail;             
int id= rs.getInt("script_id");                                                  
               PreparedStatement ps_mail = null;
                    String in_qry = "insert into email_sending(from_mail,to_mail,subject,message,status,inserted_date) values(?,?,?,?,?,now())";
                    /////////to login user////////
                    ps_mail = scriptconn.prepareStatement(in_qry);
                    ps_mail.setString(1, email);
                    ps_mail.setString(2, HardcodedValues.operator1);
                    ps_mail.setString(3, "Script Updation - "+id+"_"+cname);
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  Uploaded With Audio Files .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center> ");
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
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Audio Files .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Operator, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Audio Files   .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Studio Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Audio Files .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Studio Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Audio Files.<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Radio Mirchi, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Audio Files  .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Radio Mirchi, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script <span style='color: red'><b>"+id+"_"+cname+" </b></span> has been Uploaded with Audio Files  <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Audio Files <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Script  <span style='color: red'><b>"+id+"_"+cname+" </b></span>  has been Uploaded with Audio Files  .<br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
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
                    ps_mail.setString(4, "Hi Wifi Team, \n \t <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Script <span style='color: red'><b>"+id+"_"+cname+" </b></span> has been Uploaded with Audio Files  <br> \n Regards, <br> \n "+uname+"<br><br><center><span style='color: red'><i>Script Management System </i></span></center>");
                    ps_mail.setInt(5, 5);
                    int n10 = ps_mail.executeUpdate();
                    if(n10>0){
                        System.out.println("wifi team 3 Inserted In DB");
                    }
                    ps_mail = null;                      
             
 //////////////////// edn of radio mirchi  ////////////////  


}///////////////////////////////////////  total email sending completed ///////////////////////////    
                    //////////////end mail////////////                        
                         
      



                                                                                                                             
                out.println("<font style='color:red'><center>Voice Files Uploading For Campaign :  <b>"+rs.getString("campaignname")+"</b>Has Been COmpleted.Now the The campagin has Gone For Operator Approval <br><br></center></font>");
                out.println("<script type='text/javascript'>alert('Voice Files Uploading For Campaign :  "+rs.getString("campaignname")+" Has Been COmpleted.Now the The campagin has Gone For Operator Approval');</script>");
                
                //out.println("function checkforblanks(){if(document.myform.loginname.value==''){alert('Please'+' '+'enter Login Name.');return'+' '+'false;}else{if(document.myform.password.value==''){alert('Please enter password.');return'+' '+'false;}}return true;}");

                                       System.out.println("completed updating of status");
                 }}catch(Exception ex){
            
            ex.printStackTrace();
            }finally{
            scriptconncmp.close();
            
            }  
                 
                 }
                 
                 
                 
                 System.out.println("original legtn of the languages array=="+valueslen);
                  System.out.println("length of the file uploaded for all == "+addvallength);
                    %>
                    
              <td > <%=displayedlang%> </td>
<%--<td align="center"><a  href="<%=response.encodeURL("scriptView.jsp?name="+cname1)%>"><input type="button" value="Upload Action"/></a></td>--%>
<%--<td align="center"><input type="submit" value="Conform Go Back" class="btn" onclick="return sendparam()"></td>--%>
            </tr>
                         <script type="text/javascript">
                function sendparam()
                {
                    alert("hi");
                
             var b = confirm('Are You Sure You Have Completed Uploading Voice Files And Continue');
                if(b==true){
               
                window.location="scriptpending1.jsp?sts=Script with campagin "+<%=rs.getString("campaignname")%>"Has Been sent for Operator Approval";
                } else if(b==false){
                    
                 window.location="statusupload.jsp?campaign="+<%=rs.getString("campaignname")%>"&scriptid="+<%=rs.getInt("script_id")%>;   
                }
                  
                   
                    
                }
                
                
                
            </script>
            <%
            
          }
            catch(Exception ex){
                            ex.printStackTrace();
                            }     
            
             mn++;
                        }
                       
                    }catch(Exception ex){
                            ex.printStackTrace();
                            }  
                //}
            %>
   </table><br><table align="center"><td><a  href="<%=response.encodeURL("scriptpending1.jsp")%>"><input type="button" value="Go Back" class="btn"></a></td></table>
    </form>
     </body>
   
</html>

