<%-- 
    Document   : existingscripts
    Created on : Mar 5, 2012, 1:32:25 PM
    Author     : wifibharathi
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
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        <% // if ((request.getParameter("sdate") != null) && (request.getParameter("edate") != null)) {
                String user_type = (String)session.getAttribute("user_type");
             String stdate = request.getParameter("sdate");
                String search = request.getParameter("search");
                String edate = request.getParameter("edate");
                int status=2;int i=1;
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
                    art = pgn.showdetailsexistscript1(search,edate,status,user_type);
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
            

 
<form action="existscripts1.jsp" method="post" >
              <font style="color: red"> <h3><center>Enter Script Id : <input type="text" class="active" maxlenth="15" name="search" id="search"/> 
                        <input type="submit"  id="submit" value="Search" class="btn"></center></h3></font>          

</form>
        <h3 align="center">Existing Scripts Details</h3>
        <table align="center"  border="1"   id="mytable" class="attable">


            <tr>
                <th>SNo</th><th>Assaigned To</th>
                <th>Campaign Name</th>
                <th>Description</th>
                <th>Options</th>
                <th>Script Data</th>
                <th>Approved Date</th>
                
                <th>Requested At</th>
                <th>Requested By</th>
                <th>Script File</th>
                <th>Status</th>
              
               </tr>
            <%
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

                RecNo = (CurPN - 1) * MNRPP;

                while (RecNo < ((CurPN) * MNRPP) && RecNo < art.size()) {
                    paginationbean pgb = (paginationbean) art.get(RecNo);
                    
                    
            %>
            <tr>
                <td>
                    <%=pgb.getScript_id()%>
                </td><td>
                    
                  <%=pgb.getAssignedTo()%>  
                    
                    
                </td>
                <td>
                    <%=pgb.getCampaignname()%>
                </td>
                <td>
                    <%=pgb.getDescription()%>
                </td>
                <td nowrap>
                    <font style="color: #B47474">Back Ground Music :</font> <%
                    
                    String bgname= pgb.getBgmusic();
                    System.out.println("value"+bgname);
                    if(bgname==null){
  bgname="";
                   
                    }else{
                    bgname=pgb.getBgmusic();
                    }
                    
                    %><%=bgname%><br>
                    <font style="color: #B47474">Voice Over Artist :</font> 
                    
                    <%
                    
                    String artist= pgb.getArtistvoice();
                    System.out.println("value"+artist);
                    if(artist==null){
  artist="";
                   
                    }else{
                    artist=pgb.getArtistvoice();
                    }
                    
                    %>
                  <%=artist%><br>
                    <%
                    
                    String promt= pgb.getPrompttype();
                    System.out.println("value"+promt);
                    if(promt==null){
  promt="";
                   
                    }else{
                    promt=pgb.getPrompttype();
                    }
                    
                    %>
                    <%=promt%><br><font style="color: #B47474">Languages         : 
                      <%
                    
                    String lang= pgb.getLanguage();
                    System.out.println("value"+promt);
                    if(lang==null){
  lang="";
                   
                    }else{
                    lang=pgb.getLanguage();
                    }
                    
                    %>
                    
                    
                    
                    
                    
                    
                    :</font> <%=lang%>
                </td>
                <td>
                  <div style="width:250px; height:150px; overflow-x:hidden; overflow-y:scroll;  margin:0px auto; clear:both; overflow:auto;">
                    <%=pgb.getScriptdata()%>
                    </div>
                </td>
                    <td>
                   <%
                   String appdate=pgb.getApproveddate();
                   if(appdate!=null){
                   appdate=pgb.getApproveddate();
                   }else{
                   appdate="";
                   }
                   
%>
                    <%=appdate%>   
                    
                    
                </td>
                
                <td>
                    <%=pgb.getInserted_time()%>
                </td>
                <td><%=pgb.getUsername()%></td>
                        
                   <%
                   
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
    %>
    <a href="download.jsp?fname=<%=lang1%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values[0]+" : "+lang1%></a><br>
    <%}
    if(lang2!=null){
 %>
       <a href="download.jsp?fname=<%=lang2%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values[1]+" : "+lang2%></a><br>
                     <%}
    if(lang3!=null){
 %>
       <a href="download.jsp?fname=<%=lang3%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values[2]+" : "+lang3%></a><br>
                     <%}
    if(lang4!=null){
 %>
       <a href="download.jsp?fname=<%=lang4%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values[3]+" : "+lang4%></a><br>  
     </td>
     
  <% }}else{
          %>
   <td> <a href="download.jsp?fname=<%=pgb.getScriptUpload_fname()%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=pgb.getScriptUpload_fname()%></a></td>
                     
                     <%              
  }%>   <td>
                   <%
                   String status1="";
                    int ab=pgb.getStatus();
                    if(ab==2){
                        status1="Approved";
                        
                    }else if(ab==1){
                    status1="Pending";
                    }else if(ab==3){
                    status1="Removed";
                    }
                   %> 
               
                <%=status1%></td>
                
    
                
               

            </tr>
            <%
            System.out.println("createdby---"+pgb.getUsername());
                            RecNo++;
                            j++;
                        }
                        if (art.size() > 0) {
                            paging paging = new paging();
                            out.println(paging.FooterHtml(PageNo, art.size(), MNRPP, "existscripts1.jsp",stdate,edate));
                        }
                    }
                //}
            %>
      </table><br><form action="report.jsp" method="post">  <table align="center"><td><input type="submit" value="Go Back" class="btn"></td></table>  </form>

    <div id="footer">© 2012 All Rights Reserved by WiFi Networks</div> </body>
</html>
