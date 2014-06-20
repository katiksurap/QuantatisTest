<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

        <link href="css/style.css" rel="stylesheet" type="text/css"  media="screen"/>

        <%@page import="com.sql.connection.*,java.sql.*"%>
           <link href="css/styles_main.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="../css/tcal.css" />
	<script type="text/javascript" src="../scripts/tcal.js"></script>
        <script type="text/javascript" src="../scripts/alternatetable.js"></script>
        <script type="text/javascript" src="../scripts/datetimepicker_css.js"></script>
        <script type="text/javascript">
            <!--
            function MM_openBrWindow(theURL,winName,features)
            { //v2.0
                window.open(theURL,winName,features);
            }
            //-->
        </script>
        <script type="text/javascript">
            function noBack(){
                window.history.forward();}
        </script>
    </head>

    <div id="header">

        <jsp:include page= "menu.jsp" flush="true" />
        <!--content starts here-->
        <script type="text/javascript">
            function emailCheck(emailStr) {
                var checkTLD=1;
                //alert(emailStr);
                var
                knownDomsPat=/^(com|net|org|edu|int|mil|gov|arpa|biz|aero|name|coop|info|pro|museum)$/;

                var emailPat=/^(.+)@(.+)$/;

                var specialChars="\\(\\)><@,;:\\\\\\\"\\.\\[\\]";

                var validChars="\[^\\s" + specialChars + "\]";

                var quotedUser="(\"[^\"]*\")";

                var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/;

                var atom=validChars + '+';

                var word="(" + atom + "|" + quotedUser + ")";

                var userPat=new RegExp("^" + word + "(\\." + word + ")*$");

                var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$");

                var matchArray=emailStr.match(emailPat);

                if (matchArray==null) {
                    alert("Email address seems incorrect (check @ and .'s)");
                    document.getElementById('mailid').focus();
                    return false;
                }
                var user=matchArray[1];
                var domain=matchArray[2];

                for (i=0; i<user.length; i++) {
                    if (user.charCodeAt(i)>127) {
                        alert("Ths username contains invalid characters.");
                        document.getElementById('email').focus();
                        return false;
                    }
                }
                for (i=0; i<domain.length; i++) {
                    if (domain.charCodeAt(i)>127) {
                        alert("Ths domain name contains invalid characters.");

                        document.getElementById('email').focus();
                        return false;
                    }
                }

                if (user.match(userPat)==null) {

                    alert("The username doesn't seem to be valid.");
                    document.getElementById('email').focus();
                    return false;
                }

                var IPArray=domain.match(ipDomainPat);
                if (IPArray!=null) {
                    for (var i=1;i<=4;i++) {
                        if (IPArray[i]>255) {
                            alert("Destination IP address is invalid!");
                            return false;
                        }
                    }
                    return true;
                }
                var atomPat=new RegExp("^" + atom + "$");
                var domArr=domain.split(".");
                var len=domArr.length;
                for (i=0;i<len;i++) {
                    if (domArr[i].search(atomPat)==-1) {
                        alert("The domain name does not seem to be valid.");
                        document.getElementById('email').focus();
                        return false;
                    }
                }
                if (checkTLD && domArr[domArr.length-1].length!=2 &&
                    domArr[domArr.length-1].search(knownDomsPat)==-1) {
                    alert("The address must end in a well-known domain or two letter " +
                        "country.");
                    document.getElementById('email').focus();
                    return false;
                }
                if (len<2) {
                    alert("This address is missing a hostname!");
                    document.getElementById('email').focus();
                    return false;
                }
                return true;
            }

            function checkMobno()
            {
                //alert("hi");
                var iChars = "~!@#$%^&*(){}`?><,?/[]\|'.;:+=-_[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ] ";
                for(var i=0;i<document.getElementById('mobno').value.length;i++){
           
       
                    if(iChars.indexOf(document.getElementById('mobno').value.charAt(i))!=-1){
                        alert("These Characters are not allowed...Enter Mobile Number");
                        document.getElementById('mobno').focus();
                        document.getElementById('mobno').value="";
                        return false;
                    }
                    if ((document.getElementById('mobno').value.charAt(0))==0)
                    {
                        alert('mobile number should be starting with 7to9');
                        document.getElementById('mobno').focus();
                        document.getElementById('mobno').value="";
                        return false

                    }
                }
    
            }


            function checkdate(a){
                var today = new Date()

                var appdate=a;
                var index=0;
                var adate=appdate.split(' ')[0].split('-')[0];
                var amonth=appdate.split(' ')[0].split('-')[1];
                var ayear=appdate.split(' ')[0].split('-')[2];
                var ahour=appdate.split(' ')[1].split(':')[0];
                var amin=appdate.split(' ')[1].split(':')[1];
                var asec=appdate.split(' ')[1].split(':')[2];
                var mon=new Array ("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");

                for (i=0; i<mon.length; i++){
                    if (mon[i]==amonth){
                        index=i;
                    }
                }
                //var d3 = new Date(ayear,index,adate,ahour,amin,asec);
                var d3 = new Date(ayear,index,adate);

                if(today<=d3){
                    return true;
                }
                else{


                    return false;
                }
            }
            function isAlpha()
            {

                var txt=document.form1.name;
                var filter=/^[a-zA-Z]+$/;
                var test_bool = filter.test(txt.value);
                if (test_bool==false)
                {
                    alert('Please Enter Only Alphabets');
                    txt.focus();
                    txt.value="";
                    return false;
                }
            }
            <%--function validityCheck()
            {
           
                var validity1=document.getElementById('validity').value +" 00:00:00" ;
         
                if(!checkdate(validity1)){
                    alert('Validity should be greater than  current date..');
                    return false;
                }
            }--%>
            function check()
            {

                if(document.form1.user_type.value=="")
                {
                    alert('usertype cannot be empty');
                    document.form1.user_type.focus();
                    return false;
                }
                if(document.form1.user_type.value=="-1")
                {
                    alert('please select Your usertype');
                    document.form1.user_type.focus();
                    return false;
                }

                if(document.form1.name.value=="")
                {
                    alert('Name should not be Empty.');
                    document.form1.name.focus();
                    return false;
                }
                else if(document.form1.name.value.length<5)
           
	
                {
                    alert("Username should be min 5 characters");
                    document.form1.name.value="";
                    document.form1.name.focus();
                    return false;
        
                }
                else if(document.form1.name.value.length>10)
                {
                    alert("Username should be Maximum 10 characters");
                    document.form1.name.value="";
                    document.form1.name.focus();
                    return false;

                }


                
                if(document.getElementById('mobno').value=="")
                {
                    alert('Mobile Number Cannot be empty');
                    document.getElementById('mobno').focus();
                    return false;
                }
                if(document.getElementById('email').value=="")
                {
                    alert('please mention ur email id');
                    document.getElementById('email').focus();
                    return false;
                }
                if(document.getElementById('validity').value=="")
                {
                    alert('Validity Cannot be blank');
                    document.getElementById('validity').focus();
                    return false;
                }
                else
                {

                    return true;

                }
            }
        </script>
    </head>
    <body>
        <%

            if (request.getParameter("sts") != null) {
                out.println("<font color='Red'>USER CREATED SUCCESSFULLY</font>");
        %>
        <br>
        <%
                out.println("<font color='Red'>Your Password Details Sent To your Mail Please check it </font><BR>");
            }
        %>
        <!--content starts here-->
        <%
            response.setHeader("Pragma", "no-cache"); // HTTP 1.0
            response.setHeader("Cache-Control", "no-store"); // HTTP 1.1
            response.setDateHeader("Expires", 0);
        %>
        <div id="content">
<div id="heading">Add New User </div>
        <form action="AddUserInsert.jsp"  name="form1" method="post" onsubmit='return check()'>
            <table width="444" border="0" align="center" cellpadding="4" cellspacing="2">
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>Select The UserType :</td>
                    <td>
                        <select name="user_type" id="user_type">
                            <option value="-1">----Select</option>
                            <option value="Admin">Admin</option>
                            <option value="Operator">Operator</option>
                            <option value="WiFiUser">WiFiUser</option>
                            <option value="StudioUser">StudioUser</option>
                            <option value="RadioMirchi">RadioMirchi</option>
                            <option value="Operations">Operations</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Name :</td>
                    <td>
                        <input type="text" name="name" maxlength="40" id="name" value="" onkeyup="return isAlpha(this)"/>
                        <span class="red">*</span>
                    </td>
                </tr>
                <%
                    Connection con;
                    Statement stmt = null;
                    ResultSet rs = null;
                    boolean name_exist = false;

                    String sql = "select name,password from user_master";
                    try {
                        SQLManager sq = new SQLManager();

                        con = sq.getConnection();
                        stmt = con.createStatement();
                        rs = stmt.executeQuery(sql);
                        while (rs.next()) {
                            String name1 = rs.getString(1);
                            String pwd = rs.getString(2);

                %>

                <input type="hidden" name="dbname" value="<%=rs.getString(1)%>" />
                <script type="text/javascript">

                    function convertText()
                    {
                        alert('in the convert Text');
                        var n=document.form1.name.value ;
                        var dn=document.form1.dbname.value;
                        if(n.equals(dn))
                            alert('duplicate name');
                    }

                </script>

                <%
                        }
                    } catch (Exception e) {
                        out.println(e);
                    }
                %>
                <%--<tr>
    	<td bgcolor="#F3DAE1">Password:</td>
    	<td><input type="password" name="password" maxlength="10" id="password" value=""/>
    	<span class="red">*</span></td>
                </tr>--%>
                <tr>
                    <td>Mobile Number : </td>
                    <td><input type="text" name="mobno" maxlength="10" id="mobno" value="" onkeyup="checkMobno()"/>
                        <span class="red">*</span></td>
                    <td>Ex : 9876543210 </td></tr>

                <tr>
                    <td>
                        Email:
                    </td>
                    <td>
                        <input type="text" value="" name="email" id="email" onchange="return emailCheck(this.value)">
                    </td>
                </tr>
                <tr>
                    <td width="100px" nowrap>Validity:</td>
                <td width="170px"> <input name="validity" id="validity" value="" class="tcal">
                </tr>
                <tr>
                <td align="center"><input type="submit"  value="Submit" onclick="return validityCheck(this)"/></td></tr>
            </table>
        </form>
</div>
</body>
</html>
