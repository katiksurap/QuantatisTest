<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/style.css" rel="stylesheet" type="text/css"  media="screen"/>
        <script type="text/javascript" src="../scripts/menu.js"></script>
        <script type="text/javascript" src="../scripts/alternatetable.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/tcal.css" />
        <script type="text/javascript" src="../scripts/tcal.js"></script> 
        <title>Approved Scripts</title>
        <script type="text/javascript"> 
        function checkMobno()
            {
                //alert("hi");
                var iChars = "~!@#$%^&*(){}`?><,?/[]\|'.;:+=-_[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ] ";
                for(var i=0;i<document.getElementById('search').value.length;i++){
           
       
                    if(iChars.indexOf(document.getElementById('search').value.charAt(i))!=-1){
                        alert("These Characters are not allowed...Enter only Number");
                        document.getElementById('search').focus();
                        document.getElementById('search').value="";
                        return false;
                    }
                   
                }
    
            }
            
                    </script>
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        <div id="heading">Script ID Wise Search for All Scripts </div>
        <form action="searchidresult.jsp" method="post" onsubmit="return checkMobno()">
            <%---<%@include file="datepicker2.jsp" %>---%>
            <font style="color: red"> <h3><center>Enter Script Id : <input type="text" class="active" maxlenth="15" name="search" id="search"/> 
                        <input type="submit"  id="submit" value="Search" class="btn"></center></h3></font>
           
        </form>
    </body>   </html>
