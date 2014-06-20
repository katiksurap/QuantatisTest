<%@page import="action.FileSize"%>
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
        <script type="text/javascript">
            function approve(userid,cname,status,scriptid,assgnto){
                //alert(assgnto);
                window.location="approvereject.jsp?userid="+userid+"&cname="+cname+"&status="+status+"&scriptid="+scriptid+"&assgnto="+assgnto;
               
            }
            function Delete(userid,cname,status){ 
               //alert(status);
   var b = confirm('Are You Sure You Want To Delete This Campaign');
                if(b==true){
               
                window.location="deletecamp.jsp?userid="+userid+"&cname="+cname+"&status="+status;
                } else if(b==false){
                    
                 return false;   
                }
                  
 }
            function reject(userid,cname,status,rowno,m,n,o){
               // alert(n);
               //alert(rowno+"--"+cname);
               // window.open("rejectreason.jsp?userid="+userid+"&cname="+cname+"&status="+status,'nom','toolbar=0,menubar=0,location=0,scrollbars=0,left=175,top=175,width=350,height=220,resizable=0,status=0');
                var ajaxobject = false;

                if(window.XMLHttpRequest){
                    ajaxobject = new XMLHttpRequest();
                } else if(window.ActiveXObject){
                    ajaxobject = new ActiveXObject("Microsoft.XMLHTTP");
                }
                var list=document.getElementById(rowno);
             
                ajaxobject.open("GET", "rejectreason.jsp?userid="+userid+"&cname="+cname+"&status="+status+"&rowVal="+rowno+"&assignedto="+m+"&rejby="+n+"&scriptid="+o, true);
                ajaxobject.onreadystatechange = function(){
                    if(ajaxobject.readyState==4){
                        if(ajaxobject.status==200){
                            list.innerHTML = ajaxobject.responseText;
                            evaluateAjaxScripts(ajaxobject.responseText);
                            
                        } else {
                            list.innerHTML = "<div align='center'>An error occured while fetching Match detals. Please click on the date again to retry.</div>";
                        }
                            
                           
                    }
                };
                ajaxobject.send(null);
            }
            function rejectSubmit(x,y,z,r,m,n,o){
                
                //alert(n);
               //alert(x+'--'+y+"--");
               // window.open("rejectreason.jsp?userid="+userid+"&cname="+cname+"&status="+status,'nom','toolbar=0,menubar=0,location=0,scrollbars=0,left=175,top=175,width=350,height=220,resizable=0,status=0');
                var ajaxobject = false;
                var reason=document.getElementById("reason").value;
                if(window.XMLHttpRequest){
                    ajaxobject = new XMLHttpRequest();
                } else if(window.ActiveXObject){
                    ajaxobject = new ActiveXObject("Microsoft.XMLHTTP");
                }
               var list=document.getElementById(r);
               //alert(r);

                ajaxobject.open("Post", "rejectreason1.jsp?userid="+x+"&cname="+y+"&status="+z+"&reason="+reason+"&assignedto="+m+"&rejby="+n+"&scriptid="+o, true);
                ajaxobject.onreadystatechange = function(){
                    if(ajaxobject.readyState==4){
                        if(ajaxobject.status==200){
                           list.innerHTML = ajaxobject.responseText;
                            evaluateAjaxScripts(ajaxobject.responseText);

                        } else {
                            list.innepHTML = "<div align='center'>An error occured while fetching Match detals. Please click on the date again to retry.</div>";
                        }
                    }
                };
                ajaxobject.send(null);
            }
            function songplay(userid,path,songname){
                //alert(songname);
               window.open("songplay.jsp?userid="+userid+"&songname="+songname+"&path="+path,'nom','toolbar=0,menubar=0,location=0,scrollbars=0,left=175,top=175,width=450,height=270,resizable=0,status=0' );
               <%--  window.open="songplay.jsp?userid="+userid+"&songname="+songname;--%>
               
            }
        </script>
        <title>Pending Scripts</title>
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        <% // if ((request.getParameter("sdate") != null) && (request.getParameter("edate") != null)) {
            String stdate = request.getParameter("sdate");
            String edate = request.getParameter("edate");
            int PageNo = 1;
            int status = 1;
            int script_status=0;
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
                System.out.println("Meathod passing values--->"+stdate+" : "+edate+" : "+status);
                art = pgn.showdetails(stdate, edate, status);
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
        <div id="heading">Script Details For Approve/Reject</div>
        
         <%
            if (request.getParameter("sts") != null) {
                String status5 = request.getParameter("sts");
                out.println("<center><b><font color='Red'>" + status5 + "</font><b></center>");
            }
        %>
        <table align="center" width="990px" style id="mytable" class="attable" >
            <tr>  
           
                <th>Campaign Name</th><th>Assigned To</th> 
               <th>Script ID</th>
                <th>Description</th>
                <th>Options</th>
                <th>Script Data</th>
                <th>Requested At</th>
                <th>Requested By</th>
                      
                <th>Voice Prompt</th>
                <th>Status</th>
              
                <%--<th>Listen</th>--%>
                <th colspan="2">Action</th>

            </tr>
            <%
            int j = 1;    
            int CurPN = PageNo;
                int MNRPP = 10;
                int RecNo = 0;int i=1;
                if (Tot_Recs != 0) {
                    while (Tot_Recs <= (CurPN - 1) * MNRPP) {
                        if (CurPN != 1) {
                            CurPN = CurPN - 1;
                        }
                    }
                }
                Integer curpn = new Integer(CurPN);

                RecNo = (CurPN - 1) * MNRPP;

                while (RecNo < ((CurPN) * MNRPP) && RecNo < art.size()) {
                    paginationbean pgb = (paginationbean) art.get(RecNo);
                       
            %>
            <tr  style="height:150px;">
                        
                <td>
                    <%=pgb.getCampaignname()%>
                </td><td><%= pgb.getAssignedTo()%></td>
                <td>
                    <%=pgb.getScript_id()%>
                </td>
                <td><div style="width:250px; height:150px; overflow-x:hidden; overflow-y:scroll;  margin:0px auto; clear:both; overflow:auto;">
                    <%=pgb.getDescription()%></div>
                </td>
                <td nowrap>
                    <font style="color: #B47474" ><b>Background Music :</b></font> <%=pgb.getBgmusic()%><br>
                    <font style="color: #B47474"><b>Voice Over Artist :</b></font> <%=pgb.getArtistvoice()%><br>
                    <font style="color: #B47474"><b>Languages         :</b></font><br/> <%=pgb.getLanguage()%>
                </td>
                <td>
                  
                    <div style="width:250px; height:150px; overflow-x:hidden; overflow-y:scroll;  margin:0px auto; clear:both; overflow:auto;">
                    <%=pgb.getScriptdata()%>
                    </div>
                </td>
                <td>
                    <%=pgb.getInserted_time()%>
                </td>
                <td><%=pgb.getUsername()%></td>
        
                
                     <%
                                          
  String qury="";                  
String finalstatus="";                     
script_status=pgb.getScript_status();
if(script_status==1){
finalstatus="Pending";
%>
<td> </td>
<td><%=finalstatus%></td>
<td><input type="button" value="Delete" onclick="return Delete('<%=pgb.getScript_id()%>','<%=pgb.getCampaignname()%>',2)"> </td>
<td> </td>
                     <%
}else if(script_status==2){
finalstatus="processed";
%>

   <%
       String filesize=""; 
   String uploadfname="";
   uploadfname=pgb.getScriptUpload_fname();
   
   if(uploadfname==null){

   String lang1="";
   String lang2="";
   String lang3="";
   String lang4="";
   String lang1path="";
      String lang2path="";
         String lang3path="";
            String lang4path="";
Connection scriptconn = null;
            ResultSet rs = null;
            String qry="";
 Statement stmt=null;
            try {
                SQLManager sm = new SQLManager();
                
                
       String laguagefall="";
                
                scriptconn = sm.getConnection();
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
  String language=pgb.getLanguage();
                    System.out.println("languages -----------"+language);                      
                    
                    
                    String values[]=language.split(",");
 
 
 
 %>
<td nowrap>
    <%
    if(lang1!=null){
        FileSize fs=new FileSize();
filesize=fs.getsize(lang1path);
    %>
    <a href="download.jsp?fname=<%=lang1%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values[0]+" : "+lang1%></a><br><span style="color: red">File Size Is <%=filesize%> </span><br>
    <%}
    if(lang2!=null){
          FileSize fs=new FileSize();
filesize=fs.getsize(lang2path);
 %>
       <a href="download.jsp?fname=<%=lang2%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values[1]+" : "+lang2%></a><br><span style="color: red">File Size Is <%=filesize%> </span><br>
                     <%}
    if(lang3!=null){
          FileSize fs=new FileSize();
filesize=fs.getsize(lang3path);
 %>
       <a href="download.jsp?fname=<%=lang3%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values[2]+" : "+lang3%></a><br><span style="color: red">File Size Is <%=filesize%> </span><br>
                     <%}
    if(lang4!=null){
          FileSize fs=new FileSize();
filesize=fs.getsize(lang4path);
 %>
       <a href="download.jsp?fname=<%=lang4%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values[3]+" : "+lang4%></a><br><span style="color: red">File Size Is <%=filesize%> </span><br>  
     
     
  <% }}else{
         FileSize fs=new FileSize();
filesize=fs.getsize(pgb.getScriptUpload_path());
          %>
   <td> <a href="download.jsp?fname=<%=pgb.getScriptUpload_fname()%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=pgb.getScriptUpload_fname()%></a><br><span style="color: red">File Size Is <%=filesize%> </span><br></td>
                     
                     <%              
  }%>   
     
 
<td><%=finalstatus%></td>
<td>
                    <input type="button" value="Approve" onclick="return approve('<%=pgb.getUser_id()%>','<%=pgb.getCampaignname()%>',2,'<%=pgb.getScript_id()%>','<%=pgb.getAssignedTo()%>')">

                </td>
                <td>
                    <input type="button" value="Reject" onclick="return reject('<%=pgb.getUser_id()%>','<%=pgb.getCampaignname()%>',3,<%=RecNo%>,'<%=pgb.getAssignedTo()%>','<%=pgb.getUsername()%>','<%=pgb.getScript_id()%>')">
                    <div id="<%=RecNo%>"  ></div>
                </td>
                
<%
}else if(script_status==3){
finalstatus="Rejected-Reworking";
%>
<td> </td>
<td><%=finalstatus%></td>
<td> </td>
<td> </td>
                <%

}



%>
               
               <%-- <td>
                     <input type="button" src="/ value="songplay" onclick="return songplay('<%=pgb.getUser_id()%>','<%=pgb.getUploadpath()%>','<%=pgb.getUploaded_fname()%>')">
                </td>--%>
               
                

            </tr>
            <%
                        RecNo++;
                        j++;
                    }
                    if (art.size() > 0) {
                        paging paging = new paging();
                        out.println(paging.FooterHtml(PageNo, art.size(), MNRPP, "existingscripts.jsp", stdate, edate));
                    }
                }
                
%>
        </table>
    </body>
</html>
