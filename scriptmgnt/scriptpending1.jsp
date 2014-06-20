<%-- 
    Document   : scriptpending1
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
                art = pgn.scriptPend(stdate, edate, status, status1,user_type);

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
        <div id="heading">Upload For Pending Scripts </div>
        <form action="scriptpending1.jsp" method="post">
        </form>
        <h3 align="center">Pending Scripts Details</h3>
        <%if (request.getParameter("sts") != null) {
                out.println("<br><br><center>" + request.getParameter("sts") + "</center>");
            }
        %>
        <table align="center"  border="1"   id="mytable" class="attable">


            <tr>
                <th>Script ID</th>
                <th>Campaign Name</th>

                <th>Options</th>
                <th>Script Data</th>
                   <th>Background Prompt</th>
                <th>Requested Date</th>
                <th>Requested By</th>
                <th>Action</th>


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
                <td>
                    <%=pgb.getInserted_time()%>
                </td>
                <td><%=pgb.getUsername()%></td>

                <td align="center"><a  href="<%=response.encodeURL("scriptView.jsp?name=" + cname1+"&scriptid="+pgb.getScript_id()+"")%>"><input type="button" value="Single Upload"/></a><br><br><a  href="<%=response.encodeURL("scriptView2.jsp?name=" + cname1+"&scriptid="+pgb.getScript_id()+"")%>"><input type="button" value="Multiple Upload"/></a></td>

            </tr>
            <%
                        System.out.println("createdby---" + pgb.getUsername());

                        RecNo++;
                        j++;
                    }
                    if (art.size() > 0) {
                        paging paging = new paging();
                        out.println(paging.FooterHtml(PageNo, art.size(), MNRPP, "scriptpending1.jsp", stdate, edate));
                    }
                }
                //}
%>
        </table>
    </body>
    <div id="footer">© 2012 All Rights Reserved by WiFi Networks</div>
</html>

