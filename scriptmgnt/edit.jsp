<%@page import="com.sql.connection.*,java.sql.*"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/styles_main.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="../css/tcal.css" />
	<script type="text/javascript" src="../scripts/tcal.js"></script>
        <script type="text/javascript" src="../scripts/alternatetable.js"></script>
        <script type="text/javascript" src="../scripts/datetimepicker_css.js"></script>
        <script>
            function mobileLength(id,min)
            {

                if (id.length<min)
                {
                    alert('mobile number length should be 10 of digits');
                    id.focus();
                    //id.value="";
                    return false;
                }
            }
            function mobileStart(id,start)
            {

                if ((id.value.charAt(0))!=start)
                {
                    alert('mobile number should start with 7');
                    id.focus();
                    id.value="";
                    return false

                }

                mobileLength(this,10);
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
            function validityCheck()
            {

                var validity1=document.getElementById('validity').value +" 00:00:00" ;

                if(!checkdate(validity1)){
                    alert('Validity should be greater than  current date..');
                    return false;
                }
            }
            function emailCheck(emailStr) {
                var checkTLD=1;

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
                    document.getElementById('email').focus();
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

        </script>
    </head>
    <body>

        <jsp:include page= "menu.jsp" flush="true" />
        <div id="content">
            <div id="heading">Add New Script </div>

            <%
                String userId = request.getParameter("user_id");
                String user_type = request.getParameter("user_type");

                String username = request.getParameter("username");
                String password = request.getParameter("Password");
                String mobno = request.getParameter("MobileNum");

                String mailId = request.getParameter("mailid");
                int Status = Integer.parseInt(request.getParameter("status"));
                String validity = request.getParameter("Validity");
                if (Status == 1) {
            %>
            <form action="edit2.jsp" method="post" name="frm" onsubmit="return validityCheck(this)">
                <table align="center">
                    <tr>
                        <td>

                        </td>
                        <td>
                            <input type="hidden" value="<%=userId%>" name="userId"readonly="readonly">
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#F3DAE1">
                            User_Type:
                        </td>
                        <td>
                            <input type="text" name="user_type" value="<%=user_type%>" readonly="readonly">
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#F3DAE1">
                            UserName:
                        </td>
                        <td>
                            <input type="text" name="username" value="<%=username%>" readonly="readonly" >
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#F3DAE1">
                            Password:
                        </td>
                        <td>
                            <input type="text" name="password" value="<%=password%>" readonly="readonly">
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#F3DAE1">
                            Mobile Number:
                        </td>
                        <td>
                            <input type="text" name="mobno" value="<%=mobno%>"  onchange="return mobileStart(this,7)" >
                        </td>
                    </tr>
                    <tr>
                        <td bgcolor="#F3DAE1">
                            Email Id:
                        </td>
                        <td>
                            <input type="text" name="email" id="email" value="<%=mailId%>" onchange="return emailCheck(this.value)" >
                        </td>
                    </tr>
                    <tr>

                            <td width="100px" nowrap>Validity:</td>
                            <td width="170px"> <input name="sdate" id="sdate" value="" class="tcal">
                        </tr>
                    <tr>
                        <td></td>
                        <td><input type="submit" value="save" ></td>
                    </tr>
                </table>
                <%
                } else {
                %>

                <form action="edit3.jsp" method="post" name="frm" onsubmit="return validityCheck(this)">
                    <table align="center" style="width:100px" border="1" cellpadding="1" cellspacing="1" bgcolor="yellow" id="mytable" class="attable">
                        <tr>
                            <td>

                            </td>
                            <td>
                                <input type="hidden" value="<%=userId%>" name="userId"readonly="readonly">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                User_Type:
                            </td>
                            <td>
                                <input type="text" name="user_type" value="<%=user_type%>" readonly="readonly">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                UserName:
                            </td>
                            <td>
                                <input type="text" name="username" value="<%=username%>" readonly="readonly" >
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Password:
                            </td>
                            <td>
                                <input type="text" name="password" value="<%=password%>" readonly="readonly">
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Mobile Number:
                            </td>
                            <td>
                                <input type="text" name="mobno" value="<%=mobno%>"  onchange="return mobileStart(this,7)" >
                            </td>
                        </tr>

                        <tr>
                            <td>
                                Email Id:
                            </td>
                            <td>
                                <input type="text" name="email" id="email" value="<%=mailId%>" onchange="return emailCheck(this.value)" >
                            </td>
                        </tr>
                        <tr>

                            <td width="100px" nowrap>Validity:</td>
                            <td width="170px"> <input name="sdate" id="sdate" value="" class="tcal">
                        </tr>
                        <tr>
                            <td></td>
                            <td><input type="submit" value="save" ></td>
                        </tr>
                    </table>
                    <%
                        }
                    %>
                </form>
                </body>

                </html>
