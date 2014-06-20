<%@page import="action.FileSize"%>
<%@page import="pagination.paging"%>
<%@page import="pagination.paginationbean"%>
<%@page import="pagination.pagination"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sql.connection.*,java.sql.*"%>
<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/style.css" rel="stylesheet" type="text/css"  media="screen"/>
        <script type="text/javascript" src="../scripts/menu.js"></script>
        <script type="text/javascript" src="../scripts/alternatetable.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/tcal.css" />
        <script type="text/javascript" src="../scripts/tcal.js"></script> 
        <title>Campaign</title>
         <script>
            function validate(){
                if(document.form1.sdate.value=="-1")
                {
                    alert('please select A Campaign');
                    document.form1.sdate.focus();
                    return false;
                }
            }
        </script>
        <script type="text/javascript">
            function goback(){
                window.loaction="report.jsp";
            }
        </script>
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        <div id="heading">Select The Campaign For Existing Scripts </div>
        <form action="campaignexistscript.jsp" method="post" name="form1" onsubmit="return validate()">
            <br><table  cellspacing="0" cellpadding="0" width="85%" class="attable" id="mytable">
                <tr>
                    <td>Select Campaign : </td>
                    <td>
                        <select name="sdate" id ="sdate">
                            <option value="-1">Select the Campaign</option>
                              <option  value="all">ALL</option>
                            <%

                                Connection con1 = null;
                                Statement stmt1 = null;
                                ResultSet rs1 = null;
                                String cname = null;
                                int user_id = 0;
                                try {
                                    SQLManager sq1 = new SQLManager();

                                    con1 = sq1.getConnection();
                                    stmt1 = con1.createStatement();
                                    String qry1 = "select * from scripts where status=2";
                                    // System.out.println(qry1);
                                    rs1 = stmt1.executeQuery(qry1);
                                    System.out.println(qry1);

                                    while (rs1.next()) {
                                        cname = rs1.getString("campaignname");
                                        user_id = rs1.getInt("user_id");
                                        //   System.out.println("Username ******" + name1);
%>
                            <option  value="<%=cname%>"><%=cname%></option>
                            <%}%>
                        </select>
                        
                        <%

                            } catch (Exception e) {
                                System.out.println(e);
                            }
                        %>
                        <input type="submit" value="submit"/>
                    </td>
                </tr></table>
        </form>


        <%  if ((request.getParameter("sdate") != null)) {
            
            %>
            <form action="report.jsp" method="post">  <table align="center"><td><input type="submit" value="Go Back" class="btn"></td></table>  </form>
        
        <%
            
                String stdate = request.getParameter("sdate");
                String edate = "";
                
               System.out.println("----->"+stdate);
                int status=2;
                int i=1;
                int PageNo = 1;
                

                pagination pgn = new pagination();
                ArrayList art = new ArrayList();
                if(stdate.equalsIgnoreCase("all")){
                
                art=pgn.showdetailsByDates();
                }else{
                    art = pgn.showCamp(stdate);
                                      }
                    System.out.println("setting values into session");
                    session.setAttribute("art", art);
              
                    System.out.println("getting data from session");
                    art = (java.util.ArrayList) session.getAttribute("art");
                


                int Tot_Recs = art.size();

                if (Tot_Recs == 0) {

                    out.println("<center>" + "No Records found to display" + "</center>");
                } else {
        %>
       

       <table align="center"  border="1"   id="mytable" class="attable">


            <tr>
                <th>Script ID</th>
                <th>Campaign Name</th>

                <th>Options</th>
                <th>Script Data</th>
                   <th>Background Prompt</th>
                   <th>Assigned To</th>
                <th>Requested At</th>
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
                    <%=pgb.getCampaignname()%>
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
                   String appdate=pgb.getApproveddate();
                   if(appdate!=null){
                   appdate=pgb.getApproveddate();
                   }else{
                   appdate="";
                   }
                   
%>
                    <%=appdate%>   
                    
                    
                </td>
            
                   <%
              String filesize="";            
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
                     <% }
    if(lang4!=null){
        FileSize fs=new FileSize();
filesize=fs.getsize(lang4path);
 %>
       <a href="download.jsp?fname=<%=lang4%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=values[3]+" : "+lang4%></a><br><span style="color: red">File Size Is <%=filesize%> </span><br>  
     </td>
     
  <% }}else{
       FileSize fs=new FileSize();
filesize=fs.getsize(pgb.getScriptUpload_path());
          %>
   <td> <a href="download.jsp?fname=<%=pgb.getScriptUpload_fname()%>&userid=<%=pgb.getUser_id()%>" style="color: #A42300">
                     <%=pgb.getScriptUpload_fname()%></a><br><span style="color: red">File Size Is <%=filesize%> </span><br></td>
                     
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
                        out.println(paging.FooterHtml(PageNo, art.size(), MNRPP, "campaignexistscript.jsp", stdate, edate));
                    }
                }}
                //}
%>
        </table>
    <div id="footer">© 2012 All Rights Reserved by WiFi Networks</div>
    </body>
</html>
