<%-- 
    Document   : sameet
    Created on : 7 Jul, 2012, 8:11:50 PM
    Author     : katik
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            function validate(){
                alert("came to javascript");
                var id=document.getElementById("name").value;
                if(id==null||id==" "||id==""){
                    alert("Kidly enter username");
                    document.getElementById("name").value="";
                    document.getElementById("name").focus();
                    return false;
                    
                }
                
                
                
            }
            
            
        </script>
        
    </head>
    <body>
        <%
String sts=request.getParameter("sts");
if(sts!=null){
out.println("Status"+sts);
}       

%>
        <form action="sameet.jsp" method="post" onsubmit="return validate()">
           <table class="attable">
               <tr><td>
                      User name :
                       
                       
                   </td>
                   <td>
                       <input type="text" autocomplete="off" id="name" name="name"/>
                       
                   </td>
                   <td><input type="submit" value="sameet goo=---"></td>
              </tr> 
               
           </table>
            <%
            if(request.getParameter("name")!=null){
String username=request.getParameter("name");
            String ipaddress=request.getRemoteAddr();
            System.out.println("Username is +"+username+"and ipaddress is "+ipaddress);
            response.sendRedirect("sameet.jsp?sts=you have type "+username+" and "+ipaddress+"");
           }
%>
            
            
        </form>
    </body>
</html>
