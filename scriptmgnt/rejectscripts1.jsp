<%-- 
    Document   : rejectscripts1
    Created on : Mar 21, 2012, 12:13:47 PM
    Author     : Rani
--%>


<%@page import="com.sql.connection.SQLManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
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
            function Rejscriptvalidation(rowno){
               //alert(rowno);
                var file=document.getElementById("uploadfile1").value;
                //alert(file);
                var filesplit=file.split(".");
                if(!(filesplit[1]=="zip" || filesplit[1]=="zip"))
                {
                    alert("Browse The .zip File......")
                    document.getElementById("uploadfile1").focus();
                    return false;
                }
                return true;
            }
              
            </script>
             <script>
            function Rejscriptvalidation2(rownum){
               //alert("hi");
                var file=document.getElementById(rownum).value;
                //alert(file);
                var filesplit=file.split(".");
                if(!(filesplit[1]=="mp3" || filesplit[1]=="wav"))
                {
                    alert("Browse The mp3/wav File......")
                    document.getElementById(rownum).focus();
                    return false;
                }
                return true;
            }
        </script>
        <script type="text/javascript">
                function sendparam(campaign,scrid,assgnto)
                {
                   alert(assgnto);
                  
                   var b = confirm('Are You Sure You Have Completed Uploading Prompts');
                if(b==true){
                //alert(status);
                window.location="statusupload_1.jsp?campaign="+campaign+"&scrid="+scrid+"&assgnto="+assgnto;
                } else if(b==false){
                    return false;
                }
                    
                }
                
                
                
            </script>
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
         <% // if ((request.getParameter("sdate") != null) && (request.getParameter("edate") != null)) {
                String user_type = (String)session.getAttribute("user_type");
                String stdate = request.getParameter("sdate");
                String edate = request.getParameter("edate");
                String cname1="";
                int status=3;int i=1;int status1=1;
                int scriptsts=1;

               int PageNo = 1;
                int insrt_art_in_session = 0;
                if (request.getParameter("PgNo") != null) {
                    if (request.getParameter("PgNo").length() > 0) {
                        PageNo = Integer.parseInt(request.getParameter("PgNo"));
                    }
                } else {
                    insrt_art_in_session = 1;
                }

                pagination pgn = new pagination();
                ArrayList art = new ArrayList();
                if (insrt_art_in_session == 1) {
                    art = pgn.scriptReject(stdate,edate,status,user_type);
                    //  art = crbt.receivedfaxno();
                    session.removeAttribute("art");
                    System.out.println("setting values into session");
                    session.setAttribute("art", art);
                } else {
                    System.out.println("getting data from session");
                    art = (java.util.ArrayList) session.getAttribute("art");
                }


                int Tot_Recs = art.size();

                if (Tot_Recs == 0) {

                    out.println("<center>" + "No Records found to display" + "</center>");
                } else {
        %>
        <div id="heading">Select The Dates For Existing Scripts </div>
<form action="rejectscripts.jsp" method="post">
            </form>
        <%if(request.getParameter("sts")!=null) {
            out.println("<br><br><center>"+request.getParameter("sts")+"</center>");}
            %>
        <h3 align="center">Rejected Scripts Details</h3>
        <table align="center"  border="1" width="90%"  id="mytable" class="attable">


            <tr>
                <th>Script Id</th>
                <th>Campaign Name</th>
                <th>Options</th>
                <th>Script Data</th>
                <th>Status</th>
                <th>Rejected Reason</th>
                <th>Rejected Date</th>
                <th>Upload Promt/s</th>
                <th> Previous Upload/s</th>
            </tr>
            <%
              int mn=1;
                int j=1;  
                int CurPN = PageNo;
                int MNRPP = 10;
                int RecNo = 0;
                if (Tot_Recs != 0) {
                    while (Tot_Recs <= (CurPN - 1) * MNRPP) {
                        if (CurPN != 1) {
                            CurPN = CurPN - 1;
                        }
                    }
                }
                Integer curpn = new Integer(CurPN);
int scriptsts2=0;

                RecNo = (CurPN - 1) * MNRPP;

                while (RecNo < ((CurPN) * MNRPP) && RecNo < art.size()) {
                    paginationbean pgb = (paginationbean) art.get(RecNo);



            %>
            <tr style="height:100px;">

                <td>
                    <%=pgb.getScript_id()%>
                </td>
                <td>
                    <%=pgb.getCampaignname()%><%  cname1=pgb.getCampaignname();System.out.println("campnmae="+cname1);
                    %>
                </td>

                <td nowrap>
                    <font style="color: #B47474">Back Ground Music :</font> <%=pgb.getBgmusic()%><br>
                    <font style="color: #B47474">Voice Over Artist :</font> <%=pgb.getArtistvoice()%><br>
                    <font style="color: #B47474">Languages         :</font> <%=pgb.getLanguage()%><br>
                    
                </td>
                <td>
                <div style="width:250px; height:150px; overflow-x:hidden; overflow-y:scroll;  margin:0px auto; clear:both; overflow:auto;">
                       <%=pgb.getScriptdata()%>
                    </div>
                </td>
                <td>Rejected</td>


                <td><%=pgb.getRejectreason()%></td>
                <%String rejdate=pgb.getRejecteddate();
                if(rejdate!=null){
rejdate=pgb.getRejecteddate();
}else{
rejdate="";
}
%>
   <td><%=rejdate%></td>             
                
<td nowrap>
     <%
   String uploadfname="";
   uploadfname=pgb.getScriptUpload_fname();
   
   if(uploadfname==null){
   
   
     String language=pgb.getLanguage();
                    System.out.println("languages -----------"+language);                      
                    
                    
                    String values[]=language.split(",");
                  
                    for(int k=0;k<values.length;k++)
                        {
                        
                       // RecNo
                        //String div[]={};
                        String rownum = String.valueOf(mn)+String.valueOf(k);
                    %>

<input type="checkbox" id="modtype" name="modtype"  value="<%=values[k]%>" onclick="showMe('div<%=rownum%>', this)"/><%=values[k]%>
<br>

<div class="row" id="div<%=rownum%>"  style="display:none"> <form action="scriptRejUploadmul.jsp" method="post" enctype="multipart/form-data" onsubmit="return Rejscriptvalidation2(<%=rownum%>)"><input type="file" name="uploadfile" id="<%=rownum%>"  />
    <input type="hidden" name="checkbox" value="<%=values[k]%>">
    
    <%
System.out.println("this is the campaign name which is going to be -- "+cname1);    

%>
 <input type="hidden" name="scriptid" value="<%=pgb.getScript_id()%>">
        <input type="hidden" name="campname" value="<%=cname1%>">
        <input type="hidden" name="scriptid" value="<%=pgb.getScript_id()%>"/>
<input type="hidden" name="assgnto" value="<%=pgb.getAssignedTo()%>"/>
        
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
        <center>
<input type="submit" value="Completed" class="btn" onclick="return sendparam('<%=cname1%>','<%=pgb.getScript_id()%>','<%=pgb.getAssignedTo()%>')"></center>
<%
           ////////////this is for languages upaded showing///////////         
                    String lang1="";
   String lang2="";
   String lang3="";
   String lang4="";
   String lang1path="";
      String lang2path="";
         String lang3path="";
            String lang4path="";
            String displayedlang="";         
                Connection scriptconn = null;
            ResultSet rs = null;
            String qry="";
 Statement stmt=null;
            try {
                SQLManager sm2 = new SQLManager();
                
  
         String laguagefall="";
                
                scriptconn = sm2.getConnection();
                String Query="select * from scripts where campaignname='"+pgb.getCampaignname()+"'";
               stmt=scriptconn.createStatement();
               rs=stmt.executeQuery(Query);     
                    if(rs.next()){
                        
                    
                      lang1=rs.getString("lang1");
                      lang2=rs.getString("lang2");
                      lang3=rs.getString("lang3");
                      lang4=rs.getString("lang4");                                                                 
                       lang1path=rs.getString("lang1path");
                       lang2path=rs.getString("lang2path");
                       lang3path=rs.getString("lang3path");
                       lang4path=rs.getString("lang4path");
                    }
            }catch(Exception exp){
            exp.printStackTrace();
            }
  String language2=pgb.getLanguage();
                    System.out.println("languages -----------"+language2);                      
                    
                    
                    String values2[]=language2.split(",");
 
 
 
 %>
<td nowrap>
    <%
    if(lang1!=null){
    %>
    <a href="download.jsp?fname=<%=lang1%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values2[0]+" : "+lang1%></a><br>
    <%}
    if(lang2!=null){
 %>
       <a href="download.jsp?fname=<%=lang2%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values2[1]+" : "+lang2%></a><br>
                     <%}
    if(lang3!=null){
 %>
       <a href="download.jsp?fname=<%=lang3%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values2[2]+" : "+lang3%></a><br>
                     <%}
    if(lang4!=null){
 %>
       <a href="download.jsp?fname=<%=lang4%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values2[3]+" : "+lang4%></a><br>  
     
     
  <% }}

   
   
   
  else{
          %>
  <form action="scriptRejUpload.jsp" method="post" enctype="multipart/form-data" onsubmit="return Rejscriptvalidation(<%=RecNo%>)">
                        <input type="file" name="uploadfile1" id="uploadfile1" ><br>
                        <input type="hidden" name="campName" value="<%=pgb.getCampaignname()%>"/>
<input type="hidden" name="scriptid" value="<%=pgb.getScript_id()%>"/>
<input type="hidden" name="assgnto" value="<%=pgb.getAssignedTo()%>"/>
                        <input type="Submit" value="upload" name="uplod" ></form>
                  <%--  <input type="button" value="uplod" onclick="return rejectUplod('<%=pgb.getCampaignname()%>',<%=RecNo%>)">--%>
                    <div id="<%=RecNo%>" style="overflow:auto; width: 150px;" ></div> </td>
    <td><a href="download.jsp?fname=<%=pgb.getScriptUpload_fname()%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=pgb.getScriptUpload_fname()%></a>
                </td>                 
                     <%              
  }


%>   </td> 
  </tr>
            <%
            System.out.println("createdby---"+pgb.getUsername());
                            RecNo++;
                            j++;
                            mn++;
                        }
                        if (art.size() > 0) {
                            paging paging = new paging();
                            out.println(paging.FooterHtml(PageNo, art.size(), MNRPP, "rejectscripts1.jsp",stdate,edate));
                        }
                    }
                //}
            %>
            </table>
    </body>
    <div id="footer">© 2012 All Rights Reserved by WiFi Networks</div>
</html>
