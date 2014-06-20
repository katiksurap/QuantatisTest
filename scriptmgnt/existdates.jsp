<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../css/style.css" rel="stylesheet" type="text/css"  media="screen"/>
        <script type="text/javascript" src="../scripts/menu.js"></script>
        <script type="text/javascript" src="../scripts/alternatetable.js"></script>
        <link rel="stylesheet" type="text/css" href="../css/tcal.css" />
        <script type="text/javascript" src="../scripts/tcal.js"></script> 
        <title>Approved Scripts</title>
    </head>
    <body>
        <jsp:include page="menu.jsp"></jsp:include>
        <%
            if (request.getParameter("sts") != null) {
                String status = request.getParameter("sts");
                out.println("<font color='Red'>" + status + "</font>");
            }
        %>
        <div id="heading">Select The Dates For the Scripts </div>
        <form action="existdatesres.jsp" method="post" >
            <%@include file="datepicker2.jsp" %>
        </form>
    </body>   
</html>
