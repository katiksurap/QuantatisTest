<%-- 
    Document   : songplay
    Created on : Mar 15, 2012, 12:56:28 PM
    Author     : wifibharathi
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <SCRIPT LANGUAGE="Javascript" SRC="../scripts/jwplayer.js"></SCRIPT>
    </head>
    <body>
        <div id="heading">Player </div>
        <%
            String path = request.getParameter("path");

            String songname = request.getParameter("songname");

            String song = null;
            song = "Preview?file=" + path;
            System.out.println("WAV file name--path n name" + path + "---name--" + songname+"----song--"+song);
            //String songpath = path+"/"+songname;
            // song = "../tunes/video.mp4";
            //System.out.println("song path-->"+songpath);
%>
    <td align=center><EMBED SRC=<%=path%> VOLUME="50" HEIGHT="10" WIDTH="75" autostart="false"></td>
    <div align="center">
    <!--<embed src="<%=song%>" width="240" height="30"/>-->
        <!-- Flash Player Begin-->

        <p align="center" class="cli_text" id="player3">
            <%--Old code
     <a href="http://www.macromedia.com/go/getflashplayer">Get the Flash Player</a>to see this player.</p>
             <script type="text/javascript">
     var s3 = new SWFObject("cci_system/cci_scripts/player.swf", "line", "240", "20", "7");
     s3.addVariable("file","<%=song%>");
     s3.addVariable("repeat","false");
     s3.addVariable("showdigits","true");
     s3.addVariable("showdownload","false");
     s3.addVariable("width","240");
     s3.addVariable("height","20");
     s3.write("player3");
     </script>--%>



        <div id="container">Loading the player ...</div>
        <script type="text/javascript">
            alert("<%=path%>")
            jwplayer("container").setup({
                flashplayer: "../scripts/player.swf",
        
                file: "<%=path%>",
                height: 100,
                width: 280
            });
        </script>

        <!-- Flash Player End-->
        </body>
        </html>

