<%-- 
    Document   : existingscripts
    Created on : Mar 5, 2012, 1:32:25 PM
    Author     : wifibharathi
--%>

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
                    art = pgn.showdetailsexistscript(stdate, edate,status,user_type);
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
<form action="existscripts1.jsp" method="post" >
            </form>
        <h3 align="center">Existing Scripts Details</h3>
        <table align="center"  border="1"   id="mytable" class="attable">


            <tr>
                <th>SNo</th>
                <th>Campaign Name</th>
                <th>Description</th>
                <th>Options</th>
                <th>Script Data</th>
                <th>Requested At</th>
                <th>Requested By</th>
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
                    <%=j%>
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
                    <%=pgb.getScriptdata()%>
                </td>
                <td>
                    <%=pgb.getInserted_time()%>
                </td>
                <td><%=pgb.getUsername()%></td>
                <td>
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
                
                
               <%-- <td>
                    <form action="scriptedit.jsp" method="post">
                        <input type="hidden" name="eid" value="<%=pgb.getUser_id()%>">
                        <input type="submit" name="edit" id="<%=pgb.getUser_id()%>" value="Edit">
                    </form>
                </td>
                <td>
                    <form action="scriptdit.jsp" method="post">
                        <input type="hidden" name="eid" value="<%=pgb.getUser_id()%>">
                        <input type="submit" name="edit" id="<%=pgb.getUser_id()%>" value="Delete">
                    </form>
                </td>--%>
                
               

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
    </body>
    <div id="footer">© 2012 All Rights Reserved by WiFi Networks</div>
</html>
