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
        <title>Studio Upload</title>
       <script>
function generatenew(){
    //alert("enter");
    document.fom.uploadfile.style.visibility="visible";
    document.fom.uplod.style.visibility="visible";
}
function scriptvalidation(){
    var file=document.getElementById("uploadfile").value;
 var filesplit=file.split(".");
                if(!(filesplit[1]=="zip" || filesplit[1]=="zip"))
                {
                    alert("Browse The .zip File......")
                    document.getElementById("uploadfile").focus();
                    return false;
                }

}
</script>

    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        <%
            String sts = request.getParameter("sts");
            if (sts != null) {
                out.println("<center>" + sts + "</center>");
            }
        %>
        <div id="heading">Select The Campaign For Existing Scripts </div>
        
        <form action="studioupload.jsp" method="post">
            <br><table  cellspacing="0" cellpadding="0" width="85%" class="attable" id="mytable">
                <tr>
                    <td>Select Campaign : </td>
                    <td>
                        <select name="user_type1" id ="user_type1">
                            <option value="-1">Select the Campaign</option>
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
        </form><form action="addnewUplod.jsp" method="post" name="fom" enctype="multipart/form-data" onsubmit="return scriptvalidation()" >

        <%  if ((request.getParameter("user_type1") != null)) {
                String stdate = request.getParameter("user_type1");
                session.setAttribute("cname", stdate);
               System.out.println("----->"+stdate);
                int status=2;int i=1;
                int PageNo = 1;


                pagination pgn = new pagination();
                ArrayList art = new ArrayList();

                    art = pgn.showCamp(stdate);

                    System.out.println("setting values into session");
                    session.setAttribute("art", art);

                    System.out.println("getting data from session");
                    art = (java.util.ArrayList) session.getAttribute("art");



                int Tot_Recs = art.size();

                if (Tot_Recs == 0) {

                    out.println("<center>" + "No Records found to display" + "</center>");
                } else {
        %>


        <h3 align="center">Existing Scripts Details</h3>
        <table align="center"  border="1"  bgcolor="yellow" id="mytable" class="attable" width="85%">


            <tr>

                <th>Campaign Name</th>
                <th>Description</th>
                <th>Options</th>
                <th>Script Data</th>
                <th>Requested At</th>
                <th>Requested By</th>
                <th>Previous Uploaded</th>
                <th>Upload New File</th>


               </tr>
            <%

                   for (i=0;i < art.size();i++) {
                    paginationbean pgb = (paginationbean) art.get(i);
            %>
            <tr>

                <td>
                    <%
                    String campaign=pgb.getCampaignname();
                    if(campaign==null){
                    campaign="";
                    }else{
                    campaign=pgb.getCampaignname();
                    }
            
            %>
                    <%=campaign%>
                </td>
                <td>
                   <%
                    String desc=pgb.getDescription();
                    if(desc==null){
                    desc="";
                    }else{
                    desc=pgb.getDescription();
                    }
            String bgm=pgb.getBgmusic();
                    if(bgm==null){
                    bgm="";
                    }else{
                    bgm=pgb.getBgmusic();
                    }
            String artVoic=pgb.getArtistvoice();
                    if(artVoic==null){
                    artVoic="";
                    }else{
                    artVoic=pgb.getArtistvoice();
                    }
            %> 
                    
                    
                    <%=desc%>
                </td>
                <td nowrap>
                    <font style="color: #B47474">Back Ground Music :</font> <%=bgm%><br>
                    <font style="color: #B47474">Voice Over Artist :</font> <%=artVoic%><br>
                    <%
                   String prmt=pgb.getPrompttype();
                    if(prmt==null){
                    prmt="";
                    }else{
                    prmt=pgb.getPrompttype();
                    }
            %>
                    
                    <font style="color: #B47474">Prompt Category   :</font> <%=prmt%><br>
                    
                  <%
                   String lang=pgb.getLanguage();
                    if(lang==null){
                    lang="";
                    }else{
                    lang=pgb.getLanguage();
                    }
            %>  
                    
                    
                    
                    <font style="color: #B47474">Languages         :</font> <%=lang%>
                </td>
                
                
                <td>
                     <%
                   String script=pgb.getScriptdata();
                    if(script==null){
                    script="";
                    }else{
                    script=pgb.getScriptdata();
                    }
            %> 
                    
   <%=script%>
                </td>
                <td>
                   <%
                   String instime=pgb.getInserted_time().toString();
                    if(instime==null){
                    instime="";
                    }else{
                    instime=pgb.getInserted_time().toString();
                    }
            %>  
                    
                    
                    
                    
                    <%=instime%>
                </td>
                <td>
                    <%
                   String user=pgb.getUsername();
                    if(user==null){
                    user="";
                    }else{
                    user=pgb.getUsername();
                    }
            %> 
                    
         <%=user%></td>
                 <td>
                   <%
                   String uploadname=pgb.getUploaded_fname();
                    if(uploadname==null){
                    uploadname="";
                    }else{
                    uploadname=pgb.getUploaded_fname();
                    }
            %>   
                     
                     
                     
                     
                     
                     
                     <%=uploadname%></td> 
                     <td><input type="button"  value="change" onclick="generatenew();"></td>

              


       </tr></table>
            <%
            System.out.println("createdby---"+pgb.getUsername());

                    }}}
                //}
            %>
            <table align="center">  <tr>

                        <td><input type="file" name="uploadfile" id="uploadfile" style="visibility:hidden" ></td>
                        <td><input type="Submit" value="upload" name="uplod" style="visibility:hidden" ></td></tr></table>
        </form>

        </body>
</html>