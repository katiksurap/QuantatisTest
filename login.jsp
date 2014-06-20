<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Script Management System</title>
<link href="css/Login_style.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
            window.history.forward();
            function noBack() {
                window.history.forward();
            }
        </script>
       <script type="text/javascript">
    function checkvalid(){
        
        var uname=document.frm.scru.value;
        var emailPat=/\"/;
        var emailPat1=/'/;
        var emailPat2=/#/;
        var matchArray=uname.match(emailPat);
        var matchArray1=uname.match(emailPat1);
        var matchArray2=uname.match(emailPat2);
                if (matchArray2!=null||matchArray1!=null) {
                    alert("Username seems has incorrect Parameters");
                    document.frm.scru.focus();
                    return false;
                }
        
        if(document.frm.scru.value==""){
            alert("User Name should Not be Blank");
            document.frm.scru.focus();
            return false;
        }
        if(document.frm.scrp.value==""){
            alert("Password should Not be Blank");
            document.frm.scrp.focus();
            return false;
        }
        


    }
</script> 
            
</head>

<body onload="return noBack();" onunload="">
<div id="space"></div>
<div id="loginpage">
<p class="link">Please enter your user name and password to Login </p>
<div id="loginarea">

 <%--   <form action="login" name="frm" id="frm" method="post">--%>
        <form method="get" name="frm"  action="<%=response.encodeUrl("login")%>">
        <div class="loginrow"> <span class="label_logn">User Name : </span>
          <span class="forml_logn">
            <input name="scru"  class="input" type="text" title=" username should be between 5 and 25 characters"  size="18" />
          </span>        </div>
        <div class="loginrow"> <span class="label_logn">Password :</span> <span class="forml_logn">
          <input name="scrp" type="password"   class="input"  size="18"  />
        </span> </div>
        <div class="loginrow"> <span class="label_logn">&nbsp;</span>
        <span >
          <input type="submit" class="loginBtn"  value=""  title="Login" onclick="return checkvalid()"/>
          <%
	  System.out.println("hi");
          String sts=request.getParameter("sts");
          if(sts!=null){
          out.println("<center>"+sts+"</center>");
          }

           Object stslogout = session.getAttribute("sts");
           System.out.println("object session value"+stslogout);
            if(stslogout==null){
            System.out.println("if session value"+stslogout);
            session.removeAttribute("sts");
        //out.println("<center>"+sts+"</center>");
        }
        if(stslogout!=null){
          stslogout=   session.getAttribute("sts");
          out.println("<center>"+stslogout+"</center>");
        }
          %>
        </span> </div>
    </form>
  </div>
</div>

</body>
</html>
