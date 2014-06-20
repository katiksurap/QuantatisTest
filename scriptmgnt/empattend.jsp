<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<!-- Include one of jTable styles. -->
<link href="../css/style.css" rel="stylesheet" type="text/css" />
<link href="../css/metro/crimson/jtable.css" rel="stylesheet"
	type="text/css" />
<link href="../css/jquery-ui-1.10.3.custom.css" rel="stylesheet"
	type="text/css" />
<link rel="stylesheet" type="text/css" href="../css/tcal.css" />
<script type="text/javascript" src="../scripts/tcal.js"></script>
<!-- Include jTable script file. -->
<script src="../js/jquery-1.8.2.js" type="text/javascript"></script>
<script src="../js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>
<script src="../js/jquery.jtable.js" type="text/javascript"></script>
<style type="text/css">
.ui-dialog.ui-widget.ui-widget-content.ui-corner-all.ui-front.ui-dialog-buttons.ui-draggable.ui-resizable
	{
	width: 500px;
}
</style>
<script type="text/javascript">
    $(document).ready(function () {
        $('#PersonTableContainer').jtable({
            title: 'Table of Account Details',
            paging: true, //Enable paging
            pageSize: 10, //Set page size (default: 10)           
            actions: {
                listAction: '../CRUDController?action=getattend',
                createAction:'../CRUDController?action=create',
                updateAction: '../CRUDController?action=update',
                deleteAction: '../CRUDController?action=delete'
            },
            fields: {
            	Sno: {
                	title:'S.NO',
                    key: true,
                    list: true,
                    create:true
                },
                Emp_Sal: {
                    title: 'Employee Salary',
                   edit:false
                }, Emp_Sal_pm: {
                    title: 'PerMonth Salary',
                    width : '15%' ,
                    edit:true
                },
                Emp_Name: {
                    title: 'Emp Name',
                    edit: true
                },Emp_ID: {
                    title: 'Emp ID',
                    edit: true
                },Emp_address: {
                    title: 'Emp address',
                    edit: true
                },Emp_Mob: {
                    title: 'Mobile',
                    edit: true
                },Status: {
                    title: 'Status',
                    edit: true
                },Emp_Desc: {
                    title: 'Emp Desc',
                    edit: true
                },Emp_Dept: {
                    title: 'Emp Dept',
                    edit: true
                },Emp_addby: {
                    title: 'Emp addby',
                    edit: true
                } ,uploadfilepath: {
                    title: 'uploadfilepath',
                    edit: true
                },Emp_Created: {
                        title: 'Emp Created',
                        edit: true
                },Emp_joined: {
                    title: 'Emp joined',
                    edit: true
               },Emp_prb: {
                   title: 'prohibition period',
                   edit: true
               },Emp_prb_lev: {
                   title: 'prob leave',
                   edit: true
               },Emp_perm_leve: {
                   title: 'permnt_leave',
                   edit: true
               },Emp_Unq_num: {
                   title: 'Uniq_num',
                   edit: true
              },Emp_Prb_Enddate: {
                  title: 'Probatn End',
                  edit: true
             },Emp_rep: {
                 title: 'reporting to',
                 edit: true
            }              
            }
        });
        $('#PersonTableContainer').jtable('load');
    });
    function getcurrency(x){
  	  var pending = document.getElementById('pendamount').value;
  	  var pendval = x ;
  	 if(parseInt(pending) >= parseInt(x)){
        x=parseInt(x)/2;
        x=x.toString();
        document.getElementById("vamount").value = x;
        document.getElementById("kamount").value = x;
        var pend = parseInt(document.getElementById('pendamounthidden').value) - parseInt(pendval) ;
        document.getElementById("pendamount").value = pend;
  	  }else {
            alert("Kindly Check the Amount limit");
            document.getElementById("curamount").focus();
          return false ;
  		  }
      return true ;
        }
   function addSubAccounts(){
    var acc_name = document.getElementById("accname").value;
    var totamount = document.getElementById("totamount").value;
    var latamount = document.getElementById("latamount").value;
    var curamount = document.getElementById("curamount").value;
    var vamount = document.getElementById("vamount").value;
    var kamount = document.getElementById("kamount").value;
    var pendamount = document.getElementById("pendamount").value;
    var accid = document.getElementById("accid").value;
    var status = document.getElementById("transcomplete").value;
    var mainaccid = document.getElementById("mainaccid").value;
    var penddate = document.getElementById("acc_date").value;
    /////////////////////////////////////
    var xmlhttp;
	if (window.XMLHttpRequest)
	{
	
	    xmlhttp=new XMLHttpRequest();
	
	}
	else
	{
		xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
	}
	xmlhttp.onreadystatechange=function() //This part is actually executed last
	{
	
	    if (xmlhttp.readyState==4 && xmlhttp.status==200) // Was the request processed successfully?
	    {
	        alert(xmlhttp.responseText);
	        document.getElementById("sub-account").innerHTML = xmlhttp.responseText;
	        document.getElementById("sub-div").style.display = "none";
	    }
	}
	xmlhttp.open("GET","addSubAccount.jsp?accid="+mainaccid+"&accname="+acc_name+"&curamount="+curamount+"&vamount="+vamount+"&kamount="+kamount+"&status="+status+"&upload_fname=nothing"+"&penddate="+penddate);
	xmlhttp.send();
	   }
</script>
</head>
<body>
<jsp:include page="menu.jsp"></jsp:include>
<div id="content">
<div id="heading">Edit Existing Account</div>
<div style="width: 100%; text-align: center;">
<div id="PersonTableContainer"></div>
<div id="sub-div" style="display: none" class="OverLay"><img
	src="../images/close_box_red.png" width="20"
	style="margin-left: 400px; margin-top: -5px; position: absolute; cursor: pointer;"
	onclick="javascript:if(confirm('Are you Sure you want to Close ?')){document.getElementById('sub-div').style.display='none'}" />
<br>
<div id="sub-account" style="border-radius: 10px"></div>
<table class="attable" align="left" id="sub-account-tab">
	<tr>
		<td>
		<table>
			<tr>
				<th>Attachment</th>
				<th>Pending Date</th>
				<th>Status</th>
			</tr>
			<tr>
				<td><input name='uploadfile' id='uploadfile' type='file' /></td>
				<td><input type='text' name='acc_date' id='acc_date'
					class='tcal' /></td>
				<td>Complete <input type="radio" id="transcomplete"
					name="transcomplete" value="0" /> &nbsp;&nbsp;Pending <input
					type="radio" id="transcomplete" name="transcomplete" value="1"
					checked /></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><input type="button" align="center" class="btn"
			style="margin-left: 400px; cursor: pointer; width: 60px; height: 30px; border-radius: 5px"
			value="update" onclick="addSubAccounts()" /></td>
	</tr>
</table>
</div>
</div>
</br>
</br>
<div id="footer">© 2014 All Rights Reserved by Quantatis</div>

</div>
</body>
</html>