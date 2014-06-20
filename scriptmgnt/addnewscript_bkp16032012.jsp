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
                
              //  var prompt=document.getElementById("prompt").value;
               var bg1=document.getElementsByName("bgm");
              var artist=document.getElementsByName("artist");
           var file=document.getElementById("uploadfile").value;
                
            var script=document.getElementById("script").value;
               
              var selObj = document.getElementById('sel2'); 
                    
                /* alert(sel2[0].value);
                 alert(sel2[1].value);
                 alert(sel2[2].value);
                alert(sel2.length);
                alert(sel2)*/
                
               /* var selObj = document.getElementById('sel2');*/
        for (var i=0; i<selObj.options.length; i++) {
                selObj.options[i].selected = true;
            // alert(selObj[i].value);
              if(selObj.options[i]== false){
                  
                  alert("please select language");
              }
              
        }
           var selObj2 = document.getElementById('sel22');
        for (var j=0; j<selObj2.options.length; j++) {
                selObj2.options[j].selected = true;
            // alert(selObj2[j].value);
                
        }
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
        <script language="JavaScript" type="text/javascript">


            var NS4 = (navigator.appName == "Netscape" && parseInt(navigator.appVersion) < 5);

            function addOption(theSel, theText, theValue)
            {
                var newOpt = new Option(theText, theValue);
                var selLength = theSel.length;
                theSel.options[selLength] = newOpt;
            }

            function deleteOption(theSel, theIndex)
            { 
                var selLength = theSel.length;
                if(selLength>0)
                {
                    theSel.options[theIndex] = null;
                }
            }

            function moveOptions1(theSelFrom, theSelTo)
            {
                alert("came to script2");
                var selLength = theSelFrom.length;
                var selectedText = new Array();
                var selectedValues = new Array();
                var selectedCount = 0;
  
                var i;
  
                // Find the selected Options in reverse order
                // and delete them from the 'from' Select.
                for(i=selLength-1; i>=0; i--)
                {
                    if(theSelFrom.options[i].selected)
                    {
                        selectedText[selectedCount] = theSelFrom.options[i].text;
                        selectedValues[selectedCount] = theSelFrom.options[i].value;
                        deleteOption(theSelFrom, i);
                        selectedCount++;
                    }
                }
  
                // Add the selected text/values in reverse order.
                // This will add the Options to the 'to' Select
                // in the same order as they were in the 'from' Select.
                for(i=selectedCount-1; i>=0; i--)
                {
                    addOption(theSelTo, selectedText[i], selectedValues[i]);
                }
  
                if(NS4) history.go(0);
            }
        </script><script language="JavaScript" type="text/javascript">


    var NS4 = (navigator.appName == "Netscape" && parseInt(navigator.appVersion) < 5);

    function addOption(theSel, theText, theValue)
    {
        var newOpt = new Option(theText, theValue);
        var selLength = theSel.length;
        theSel.options[selLength] = newOpt;
    }

    function deleteOption(theSel, theIndex)
    { 
        var selLength = theSel.length;
        if(selLength>0)
        {
            theSel.options[theIndex] = null;
        }
    }

    function moveOptions(theSelFrom, theSelTo)
    {
        alert("came to script");
      //  var lang=document.getElementsByName("sel2");
          //      alert(lang);
        var selLength = theSelFrom.length;
        var selectedText = new Array();
        var selectedValues = new Array();
        var selectedCount = 0;
  
        var i;
  
        // Find the selected Options in reverse order
        // and delete them from the 'from' Select.
        for(i=selLength-1; i>=0; i--)
        {
            if(theSelFrom.options[i].selected)
            {
                selectedText[selectedCount] = theSelFrom.options[i].text;
                selectedValues[selectedCount] = theSelFrom.options[i].value;
                deleteOption(theSelFrom, i);
                selectedCount++;
            }
        }
  
        // Add the selected text/values in reverse order.
        // This will add the Options to the 'to' Select
        // in the same order as they were in the 'from' Select.
        for(i=selectedCount-1; i>=0; i--)
        {
            addOption(theSelTo, selectedText[i], selectedValues[i]);
        }
  
        if(NS4) history.go(0);
    }
        </script>
        <script language="JavaScript" type="text/javascript">


            var NS4 = (navigator.appName == "Netscape" && parseInt(navigator.appVersion) < 5);

            function addOption(theSel, theText, theValue)
            {
                var newOpt = new Option(theText, theValue);
                var selLength = theSel.length;
                theSel.options[selLength] = newOpt;
            }

            function deleteOption(theSel, theIndex)
            { 
                var selLength = theSel.length;
                if(selLength>0)
                {
                    theSel.options[theIndex] = null;
                }
            }

            function moveOptions(theSelFrom, theSelTo)
            {
                alert("came to script");
                var selLength = theSelFrom.length;
                var selectedText = new Array();
                var selectedValues = new Array();
                var selectedCount = 0;
  
                var i;
  
                // Find the selected Options in reverse order
                // and delete them from the 'from' Select.
                for(i=selLength-1; i>=0; i--)
                {
                    if(theSelFrom.options[i].selected)
                    {
                        selectedText[selectedCount] = theSelFrom.options[i].text;
                        selectedValues[selectedCount] = theSelFrom.options[i].value;
                        deleteOption(theSelFrom, i);
                        selectedCount++;
                    }
                }
  
                // Add the selected text/values in reverse order.
                // This will add the Options to the 'to' Select
                // in the same order as they were in the 'from' Select.
                for(i=selectedCount-1; i>=0; i--)
                {
                    addOption(theSelTo, selectedText[i], selectedValues[i]);
                }
  
                if(NS4) history.go(0);
            }
        </script><script language="JavaScript" type="text/javascript">


            var NS4 = (navigator.appName == "Netscape" && parseInt(navigator.appVersion) < 5);

            function addOption(theSel, theText, theValue)
            {
                var newOpt = new Option(theText, theValue);
                var selLength = theSel.length;
                theSel.options[selLength] = newOpt;
            }

            function deleteOption(theSel, theIndex)
            { 
                var selLength = theSel.length;
                if(selLength>0)
                {
                    theSel.options[theIndex] = null;
                }
            }

            function moveOptions(theSelFrom, theSelTo)
            {
                alert("came to script");
                var selLength = theSelFrom.length;
                var selectedText = new Array();
                var selectedValues = new Array();
                var selectedCount = 0;
  
                var i;
  
                // Find the selected Options in reverse order
                // and delete them from the 'from' Select.
                for(i=selLength-1; i>=0; i--)
                {
                    if(theSelFrom.options[i].selected)
                    {
                        selectedText[selectedCount] = theSelFrom.options[i].text;
                        selectedValues[selectedCount] = theSelFrom.options[i].value;
                        deleteOption(theSelFrom, i);
                        selectedCount++;
                    }
                }
  
                // Add the selected text/values in reverse order.
                // This will add the Options to the 'to' Select
                // in the same order as they were in the 'from' Select.
                for(i=selectedCount-1; i>=0; i--)
                {
                    addOption(theSelTo, selectedText[i], selectedValues[i]);
                }
  
                if(NS4) history.go(0);
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
                            <input type="radio" name="bgm" value="ON" id="bgm" />ON &nbsp;
                            <input type="radio" name="bgm" value="OFF" id="bgm">OFF</td>
                    </tr>
                    <tr>
                        <td>Voice Over Artist</td>
                        <td align="left" >
                            <input type="radio" name="artist" value="MALE" id="artist" />Male &nbsp;
                            <input type="radio" name="artist" value="FEMALE" id="artist">Female
                            <input type="radio" name="artist" value="BOTH" id="artist">Both
                        </td>
                    </tr>

                    <%--   <tr>
                           <td>Language</td><td><select name="lang" id="lang">
                                   <option value="0"> ---- select----</option>
                                   <option value="TELUGU">Telugu</option>
                                   <option value="HINDI">Hindi</option>
                                   <option value="ENGLISH">English</option>
                               </select></td>
                       </tr>
                       <tr>
                           <td>Prompt Type</td><td><select name="prompt" id="prompt">
                                   <option value="0"> ---- select----</option>
                                   <option value="OBD">OBD</option>
                                   <option value="CRBT">CRBT</option>
                               </select></td>
                       </tr>--%>
                    <%--  <tr>
                          <td width="100" align="left"><font face="Arial">Language</font></td><td>
                              <select name="sel1" size="3" multiple="multiple">
                                  <option value="1">TELUGU</option>
                                  <option value="2">HINDI</option>
                                  <option value="3">ENGLISH</option>
                              </select>
                          </td>
                          <td align="center" valign="middle">
                              <input type="button" value="--&gt;" onclick="moveOptions(this.form.sel1, this.form.sel2);" />
                              <input type="button" value="&lt;--" onclick="moveOptions(this.form.sel2, this.form.sel1);" />
                          </td>
                          <td>
                              <select name="sel2" size="3" multiple="multiple">
                                  <option value="1">TELUGU</option>
                                  <option value="2">HINDI</option>
                                  <option value="3">ENGLISH</option>
                              </select>
                          </td>
                      </tr>
                      <tr>
                          <td width="100" align="left"><font face="Arial">Prompt Type</font></td><td>
                              <select name="sel1" size="2" multiple="multiple">
                                  <option value="1">OBD</option>
                                  <option value="2">CRBT</option>
                              </select>
                          </td>
                          <td align="center" valign="middle">
                              <input type="button" value="--&gt;" onclick="moveOptions(this.form.sel1, this.form.sel2);" />
                              <input type="button" value="&lt;--" onclick="moveOptions(this.form.sel2, this.form.sel1);" />
                          </td>
                          <td>
                              <select name="sel2" size="2" multiple="multiple">
                                  <option value="1">OBD</option>
                                  <option value="2">CRBT</option>
                              </select>
                          </td>
                      </tr>--%>
                    <tr>
                        <td width="50" align="left"><font face="Arial">Language</font></td><td>
                            <select name="sel1" id="sel1" size="5" multiple="multiple">
                                <option value="TELUGU">TELUGU</option>
                                <option value="ENGLISH">ENGLISH</option>
                                <option value="HINDI">HINDI</option>
                                <option value="TAMIL">TAMIL</option>
                                <option value="MALAYALAM">MALAYALAM</option>
                            </select>
                        </td>
                        <td align="left" valign="middle">
                            <input type="button" value="--&gt;" onclick="moveOptions(this.form.sel1, this.form.sel2);" />
                            <input type="button" value="&lt;--" onclick="moveOptions(this.form.sel2, this.form.sel1);" />
                        </td>
                        <td>
                            <select name="sel2" size="5" id="sel2" multiple="multiple">
                               <%-- <option value="1"></option>
                                <option value="2"></option>
                                <option value="3"></option>
                                <option value="4"></option>
                                <option value="5"></option>--%>
                              
                            </select>
                        </td><td></td>
                    </tr>
                    <tr>
                        <td width="100" align="left"><font face="Arial">Prompt Type</font></td><td>
                            <select name="sel12" size="5" multiple="multiple">
                                <option value="OBD">OBD</option>
                                <option value="CRBT">CRBT</option>
                                <option value="3"></option>
                                <option value="4"></option>
                                <option value="5"></option>
                            </select>
                        </td>
                        <td align="left" valign="middle">
                            <input type="button" value="--&gt;" onclick="moveOptions1(this.form.sel12, this.form.sel22);" />
                            <input type="button" value="&lt;--" onclick="moveOptions1(this.form.sel22, this.form.sel12);" />
                        </td>
                        <td>
                            <select name="sel22" id="sel22" size="5" multiple="multiple">
                           
                            </select>
                        </td>
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
                        <td><input type="Submit" value="Create"><input type="RESET"></td>
                    </tr>
                </table>
            </form>
    </body>
    <div id="footer">© 2012 All Rights Reserved by WiFi Networks</div>
        </html>