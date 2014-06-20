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
        <link rel="stylesheet" type="text/css" href="../css/tcal.css" />
        <script type="text/javascript" src="../scripts/tcal.js"></script>
        <title>Employee Management</title>
        
    </head>
    <script type="text/javascript">
    function getpackage(x){
        var pendval = x ;
    	  x = x.replace(/[, ]+/g,"").trim();
    	 if(parseInt(x)){
          x=parseInt(x)/12;
          x=x.toString();
          x = parseInt(x);
          document.getElementById("empsalpm").value = x;
          }else {
              alert("Kindly Enter the Package limit");
              document.getElementById("curamount").focus();
            return false ;
    		  }
            return true ;
          }
    </script>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        <div id="content">
        <%
            String sts = request.getParameter("sts");
            if (sts != null) {
                out.println("<center>" + sts + "</center>");
            }
        %>
        
            <div id="heading">Employee Leaves Management </div>
            <br>
            <form action="empleave_actionHelper.jsp" name="frm" id="frm" method="post" enctype="multipart/form-data" onsubmit="return scriptvalidation()">
                <table  cellspacing="0" cellpadding="5" width="75%" align="center" style="background-color:#FFBBBE; border-radius:10px;" id="myTable">
                    <tr>
                        <td colspan="2"><img src="images/blank.gif" width="1" height="1" /></td>
                    </tr>
                    <tr>
                        <td>Employee Name<span class="red">*</span></td>
                        <td width="286"><input type="text" name="cname" style="border-radius:10px" id="cname" maxlength="50"/>(50 Characters)</td>
                    </tr>
                    <tr>
                        <td>Employee ID Number <span class="red">*</span></td>
                        <td width="286"><input type="text" name="empid" style="border-radius:10px" id="empid" maxlength="50"/>(50 Characters)</td>
                    </tr>
                    <tr>
                        <td>Employee Mobile <span class="red">*</span></td>
                        <td width="286"><input type="text" name="empmob" style="border-radius:10px" id="empmob" maxlength="15"/>(15 Characters)</td>
                    </tr>
                    <tr>
                        <td>Employee Address <span class="red">*</span></td>
                        <td width="286"><textarea  rows="2" cols="23" name="empadd" style="border-radius:10px" id="empadd"> </textarea></td>
                    </tr>
                    
                    <tr>
                        <td width="173">Employee Job Description<span class="red">*</span></td>
                        <td width="286"><textarea rows="2" cols="23" style="border-radius:10px" name="desc" id="desc"></textarea></td>
                    </tr>
                    <tr>
                        <td>Employee Package<span class="red">*</span></td>
                        <td width="286">
                        <input type="text" id="empsal" name="empsal" style="border-radius:10px" onkeyup="getpackage(this.value)"/>(INR)
                        </td>
                    </tr>
                    <tr>
                        <td>Employee Per Month Salary<span class="red">*</span></td>
                        <td width="286">
                        <input type="text" id="empsalpm" name="empsalpm" style="border-radius:10px"/>(INR)
                        </td>
                    </tr>
                    <tr>
                        <td width="173">Department<span class="red">*</span></td>
                        <td width="286">
                        <select name="empdep" id="empdep"> 
                        	<option value="select">--Select--</option>
                        	<option value="EPUBDEV">EPUB Developer</option>
                        	<option value="XMLDEV">XML DEVELOPER</option>
                        	<option value="EPUBTL">EPUB TEAM LEADER</option>
                        	<option value="XMLTL">XML TEAM LEADER</option>
                        	<option value="HR">HR</option>
                        	<option value="ACCOUNTS">ACCOUNTANT</option>
                        </select>
                        </td>
                    </tr>
                    <tr>
                        <td>Employee Reporting to<span class="red">*</span></td>
                        <td width="286"><input type="text" name="emprep" style="border-radius:10px" id="emprep" maxlength="50"/>(50 Characters)</td>
                    </tr>
                    <td>Added By :</td>
                    <td>
                        <select name="user_type" id="user_type">
                            <option value="-1">--Select--</option>
                            <option value="1">Venkat</option>
                            <option value="2">Karthik</option>

                        </select>
                    </td>
                    <tr>
                        <td>Documents Scanned Zip</td>
                        <td>
                            <input type="radio" name="bgm" value="0" checked="checked"> ON
                            <input type="radio" name="bgm" value="1"  > OFF<br>
                        </td></tr><tr><td></td><td>
                            <div id="div_name">

                                <input type="file" style="border-radius:10px" name="uploadfile" id="uploadfile">
                            </div>
                        </td> </tr>
                    <tr>
                        <td width="100px" nowrap>Employee Joined :</td>
                        <td width="170px"> <input name="emp_date" id="emp_date" value="" class="tcal" >
                    </tr>
                    <tr>
                        <td>Prohibition Period :<span class="red">*</span></td>
                        <td width="286"><input name="prb_period" id="prb_period" value="" type="text" style="width: 50px;">(Months)</td>
                    </tr>
                    
                    <tr id="pend_date">
                        <td width="100px" nowrap>Number of leaves :</td>
                        <td ><input name="prb_leaves" id="prb_leaves" value="" type="text" style="width: 30px;"> in Prohibition &nbsp;
                       <input name="prmnt_leaves" id="prmnt_leaves" value="" type="text" style="width: 30px;"> in Permanent  </td>
                    </tr>
                   
                    <script type="text/javascript" src="../scripts/jquery.js"></script>
                    <script type="text/javascript">
                    
                        $(document).ready(function(){
                          $('input:radio[name="bgm"]').click(function() {
                                var $this = $(this);
                                if ( $this.val() == "0" ) {
                                	 $("#div_name").show(1000);
                                } else {
                                	$("#div_name").hide(1000);
                                }
                            });
                        });
                        </script>

                    <tr>
                        <td>&nbsp;</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <input type="Submit" style="background-color: white;cursor: pointer" class="btn" value="Create"><input style="background-color: white;cursor: pointer" type="RESET" class="btn"></td>
                    </tr>
                </table>
            </form>
                    </br>
                    <div id="footer">© 2014 All Rights Reserved by Quantatis</div>
        </div>
    </body>
   </html>
