<%-- 
    Document   : scriptpending1
    Created on : Mar 5, 2012, 1:32:25 PM
    Author     : wifibharathi
--%>

<%@page import="action.FileSize"%>
<%@page import="java.awt.BufferCapabilities.FlipContents"%>
<%@page import="java.lang.String"%>
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

        <title>All Scripts</title>
        <script type="text/javascript">
            
        </script>
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>

        <% // if ((request.getParameter("sdate") != null) && (request.getParameter("edate") != null)) {
            String user_type = (String)session.getAttribute("user_type");
            String stdate = request.getParameter("sdate");
            String edate = request.getParameter("edate");
            String cname1 = "";
            int status = 1;
            int i = 1;
            int status1 = 1;
            int scriptsts = 1;

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
                // art = pgn.showdetails(stdate, edate,status);
                //  art = crbt.receivedfaxno();
                art = pgn.showdetailsapproved();

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
        <div id="heading">    <h3 align="center">Scripts Details</h3> </div>
        <form action="scriptpending1.jsp" method="post">
        </form>
    
        <%if (request.getParameter("sts") != null) {
                out.println("<br><br><center>" + request.getParameter("sts") + "</center>");
            }
        %>
        <table align="center"  border="1"   id="mytable" class="attable">


            <tr>
                <th>Campaign ID</th>
                <th>Campaign Name</th>

                <th>Options</th>
                <th>Script Data</th>
                   <th>Background Prompt</th>
                   <th>Assigned To</th>
                <th>Requested At</th>
                <th>Status</th>
                <th>Approved At</th>
                <th>Script File</th>
                <th>Requested By</th>
         


            </tr>
            <%int j = 1;
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
                int scriptsts2 = 0;

                RecNo = (CurPN - 1) * MNRPP;

                while (RecNo < ((CurPN) * MNRPP) && RecNo < art.size()) {
                    paginationbean pgb = (paginationbean) art.get(RecNo);


                        
            %>
            <tr>
                <td>
                    <%=pgb.getScript_id()%>
                </td>
                <td>
                    <%=pgb.getCampaignname()%><%  cname1 = pgb.getCampaignname();
                        System.out.println("campnmae=" + cname1);
                    %>
                </td>

                <td nowrap>
                    <font style="color: #B47474">Back Ground Music :</font> <%=pgb.getBgmusic()%><br>
                    <font style="color: #B47474">Voice Over Artist :</font> <%=pgb.getArtistvoice()%><br>
                    <font style="color: #B47474">Languages         :</font> <%=pgb.getLanguage()%>
                </td>
                <td>
                    
                    <div style="width:250px; height:150px; overflow-x:hidden; overflow-y:scroll;  margin:0px auto; clear:both; overflow:auto;">
                    <%=pgb.getScriptdata()%>
                    </div>
                </td>
                <td>
                   <%
                   
String bgmusic=pgb.getBgmusic();
if(bgmusic.equalsIgnoreCase("ON")){
    String uname="";
  


uname=pgb.getUploaded_fname();
//out.println(uname);


%>
<a href="download.jsp?fname=<%=uname%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300"> <%=uname%></a>
<%
}


%> 
                </td>
                
                <td><%=pgb.getAssignedTo()%></td>
                <td>
                    <%=pgb.getInserted_time()%>
                </td>
                <td>
                                       <%
    String appdate="";                                      
  String qury="";                  
String finalstatus="";
       int script_status=0;                     
script_status=pgb.getStatus();
if(script_status==1){
finalstatus="Pending";
%>


  <%}else if(script_status==2){
  finalstatus="Approved";
  }else if(script_status==3){
finalstatus="Rejected-Reworking";

}
%>                  
     <%=finalstatus%>           </td>
                <td>
                    <%
                  appdate=pgb.getApproveddate();
                   if(appdate!=null){
                   appdate=pgb.getApproveddate();
                   }else{
                   appdate="";
                   }
                   
%>
                    <%=appdate%>
                </td>
           
                   <%
       String finalsize="";            
String scriptfile=pgb.getScriptUpload_fname();
 
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
finalsize=fs.getsize(lang1path);
    %>
    <a href="download.jsp?fname=<%=lang1%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
        <%=values[0]+" : "+lang1%></a><br><span style="color: red">File Size Is  :<%=finalsize%></span><br>
    <%}
    if(lang2!=null){
        FileSize fs=new FileSize();
finalsize=fs.getsize(lang2path);
 %>
       <a href="download.jsp?fname=<%=lang2%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values[1]+" : "+lang2%></a><br><span style="color: red">File Size Is  :<%=finalsize%> </span><br>
                     <%}
    if(lang3!=null){
        FileSize fs=new FileSize();
finalsize=fs.getsize(lang3path);
 %>
       <a href="download.jsp?fname=<%=lang3%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values[2]+" : "+lang3%></a><br><span style="color: red">File Size Is  :<%=finalsize%></span><br>
                     <%}
    if(lang4!=null){
        FileSize fs=new FileSize();
finalsize=fs.getsize(lang4path);
 %>
       <a href="download.jsp?fname=<%=lang4%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values[3]+" : "+lang4%></a><br><span style="color: red">File Size Is  :<%=finalsize%> </span><br>  
     </td>
     
  <% }}else{
       FileSize fs=new FileSize();
finalsize=fs.getsize(pgb.getScriptUpload_path());
    %>
        
   <td> <a href="download.jsp?fname=<%=pgb.getScriptUpload_fname()%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=pgb.getScriptUpload_fname()%></a><br><span style="color: red">File Size Is  :<%=finalsize%> </span><br></td>
                     
                     <%              
  }%>   
     
 




                    
                <td><%=pgb.getUsername()%></td>

               

            </tr>
            <%
                        System.out.println("createdby---" + pgb.getUsername());

                        RecNo++;
                        j++;
                    }
                    if (art.size() > 0) {
                        paging paging = new paging();
                        out.println(paging.FooterHtml(PageNo, art.size(), MNRPP, "approved.jsp", stdate, edate));
                    }
                }
                //}
%>
        </table></body>
    <div id="footer">© 2012 All Rights Reserved by WiFi Networks</div>
</html>
