<%-- 
    Document   : rejectscripts
    Created on : Mar 21, 2012, 12:25:13 PM
    Author     : Rani
--%>

<html><head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/style.css" rel="stylesheet" type="text/css"  media="screen"/>
        <script type="text/javascript" src="../scripts/menu.js"></script>
        <script type="text/javascript" src="../scripts/alternatetable.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/tcal.css" />
        <script type="text/javascript" src="../scripts/tcal.js"></script>
        <title>Rejected Scripts</title>
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        <div id="heading">Select The Dates For Existing Scripts </div>
        <form action="rejectscripts1.jsp" method="post" >
            <%@include file="datepicker2.jsp" %></form>
    </body>   </html>
