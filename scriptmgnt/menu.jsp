<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Script Management System</title>
        <link href="../css/style.css" rel="stylesheet" type="text/css"  media="screen"/>
        <script type="text/javascript" src="../scripts/menu.js"></script>
        <script type="text/javascript" src="../scripts/alternatetable.js"></script>
    </head>
    <body>
        <!--content starts here-->
        <div id="mainBody">
        <div id="logo"><img src="../images/logo1.gif" width="291" height="63" /></div>
            <div style=" text-align:right;width:550px; padding-top:25px; font-size:15px; float: left"><center><strong> Hi,Welcome to :</strong>  <span style="color:red"><%=session.getAttribute("uname")%></span></center></div>
            <%  
            if(session.getAttribute("uname")!=null){
            String username = (String) session.getAttribute("uname");
                String user_type = (String) session.getAttribute("user_type");
                System.out.println("menu user type-->" + user_type);%>
            <!--navigation starts here-->
            <div id="tabsbg">
                <div class="suckertreemenu">
                    <ul id="treemenu1">
                        <% if (user_type.equalsIgnoreCase("1")) {%>
                        <li><a href="home.jsp" title="home" class="active">Home</a></li>
                        <li><a href="#" title="UserManagement">User Management</a>
                            <ul>
                                <li><a href="AddUser.jsp">Add Users</a></li>
                                <li><a href="viewUser.jsp">Show Users</a></li>
                            </ul>
                        </li>
                        
                        <li><a href="#" title="Data">Data Management</a>
                            <ul>
                                <li><a href="addnewscript.jsp" title="Add Accounts">Add Account</a> </li>
                                <li><a href="account_report.jsp" title="View Accounts">View Accounts</a></li>
                             </ul>
                        </li>
						<li>
						<a href="#" title="Employee Management">Employee Management</a>
                            <ul>
                                 <li><a title="Employee Management" href="empleave.jsp">Employee Creation</a></li>
                                 <li><a title="Employee Attendance" href="empattend.jsp">Employee Attendance</a></li>
                            </ul>
                        </li>
                        <li><a href="#" title="settings">Settings</a>
                            <ul>
                                 <li><a href="ChngPassword.jsp">Change Password</a></li>
                               <%--  <li><a href="Reset.jsp">Reset Password</a></li>---%>
                            </ul>
                        </li>
                            
                        <%}}else{
                        	response.sendRedirect("logout.jsp");
                        }%>
                        <li><a href="logout.jsp" title="Logout">Logout</a> </li></ul>
                </div>
            </div>
        </div>
        <!--content end here-->

        <!--fotter -->


    </body>
</html>
