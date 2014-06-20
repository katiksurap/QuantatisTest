<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.sql.connection.*,java.sql.*"%>
<%@page language="java" import="javazoom.upload.*" import="java.util.*"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/style.css" rel="stylesheet" type="text/css"  media="screen"/>
        <script type="text/javascript" src="../scripts/menu.js"></script>
        <script type="text/javascript" src="../scripts/alternatetable.js"></script>
        <title>JSP Page</title>
        <script>
            function scriptvalidation(){
                var cname=document.getElementById("cname").value;
                var desc=document.getElementById("desc").value;
                var lang=document.getElementById("lang").value;
                var prompt=document.getElementById("prompt").value;
                var bg1=document.getElementsByName("bgm");
                var artist=document.getElementsByName("artist");
                var file=document.getElementById("uploadfile").value;
                
                var script=document.getElementById("script").value;
                
                
                if(cname==null || cname==""){
                    alert("Campaign Name Should Not Empty");
                    return false;
                }
                if(desc==null || desc==""){
                    alert("Description Should Not be Empty  ");
                    return false;
                }
                //alert(bg1[0].checked);
                if(bg1[0].checked==false && bg1[1].checked==false)
                {
                    alert("Please Choose BackGround Music" );
                    return false;
                }
                if(artist[0].checked==false && artist[1].checked==false&& artist[2].checked==false)
                {
                    alert("Please Choose Voice Over Artist" );
                    return false;
                }
                
                if(lang==null || lang=="0"){
                    alert("Select any language ");
                    return false;
                }
                //alert(prompt)
                if(prompt==null || prompt=="0"){
                    alert("Select any Prompt ");
                    return false;
                }       
                var filesplit=file.split(".");
                if(!(filesplit[1]=="zip" || filesplit[1]=="zip"))
                {
                    alert("Browse The .zip File......")
                    document.getElementById("uploadfile").focus();
                    return false;
                }
                if(script==null || script==""){
                    alert("Script Should Not be Empty");
                    return false;
                }
                     
                return true;
                       
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
        <div id="content">
            <div id="heading">Add New Script </div>
            <form action="addnewscript1.jsp" name="frm" id="frm" method="post" enctype="multipart/form-data" onsubmit="return scriptvalidation()">
                <table  cellspacing="0" cellpadding="0" width="95%" class="attable" id="mytable">
                    <tr>
                        <td colspan="2"><img src="images/blank.gif" width="1" height="1" /></td>
                    </tr>
                    <tr>
                        <td>Campiagn Name<span class="red">*</span></td>
                        <td width="286"><input type="text" name="cname" id="cname" maxlength="20"/>(20 Characters)</td>
                    <tr>
                        <td width="173">Description<span class="red">*</span></td>
                        <td width="286"><textarea rows="4" cols="10" name="desc" id="desc"></textarea></td>
                    </tr>
                    <tr>
                        <td>BackGround Music</td>
                        <td align="left" >
                            <input type="radio" name="bgm" value="on" id="bgm" />ON &nbsp;
                            <input type="radio" name="bgm" value="off" id="bgm">OFF</td>
                    </tr>
                    <tr>
                        <td>Voice Over Artist</td>
                        <td align="left" >
                            <input type="radio" name="artist" value="male" id="artist" />Male &nbsp;
                            <input type="radio" name="artist" value="female" id="artist">Female
                            <input type="radio" name="artist" value="both" id="artist">Both
                        </td>
                    </tr>

                    <tr>
                        <td>Language</td><td><select name="lang" id="lang">
                                <option value="0"> ---- select----</option>
                                <option value="Telugu">Telugu</option>
                                <option value="Hindi">Hindi</option>
                                <option value="English">English</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>Prompt Type</td><td><select name="prompt" id="prompt">
                                <option value="0"> ---- select----</option>
                                <option value="OBD">OBD</option>
                                <option value="CRBT">CRBT</option>
                            </select></td>
                    </tr>
                    <tr>
                        <td>Prompt File:</td>
                        <td><input type="file" name="uploadfile" id="uploadfile"></td>
                    </tr>
                    <tr>
                        <td width="173">Script<span class="red">*</span></td>
                        <td width="286"><textarea rows="4" cols="50" name="script" id="script"></textarea></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="Submit" value="Create"></td>
                    </tr>
                </table>
            </form>
    </body>
    <div id="footer">© 2012 All Rights Reserved by WiFi Networks</div>
</html>
