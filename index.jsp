<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<!-- Include one of jTable styles. -->
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="css/metro/crimson/jtable.css" rel="stylesheet" type="text/css" />
<link href="css/jquery-ui-1.10.3.custom.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="css/tcal.css" />
        <script type="text/javascript" src="scripts/tcal.js"></script>
        
<!-- Include jTable script file. -->
<script src="js/jquery-1.8.2.js" type="text/javascript"></script>
<script src="js/jquery-ui-1.10.3.custom.js" type="text/javascript"></script>
<script src="js/jquery.jtable.js" type="text/javascript"></script>
<style type="text/css">
.ui-dialog.ui-widget.ui-widget-content.ui-corner-all.ui-front.ui-dialog-buttons.ui-draggable.ui-resizable{
width:500px;
}
</style>
<script type="text/javascript">
    $(document).ready(function () {
        $('#PersonTableContainer').jtable({
            title: 'Table of people',
            paging: true, //Enable paging
            pageSize: 10, //Set page size (default: 10)           
            actions: {
                listAction: 'CRUDController?action=list',
                createAction:'CRUDController?action=create',
                updateAction: 'CRUDController?action=update',
                deleteAction: 'CRUDController?action=delete'
            },
            fields: {
            	ac_id: {
                	title:'S.NO',
                    key: true,
                    list: true,
                    create:true
                },
                Account_name: {
                    title: 'Account Name',
                   edit:false
                }, createddate: {
                    title: 'Created Date',
                    edit:true
                },
                acc_description: {
                    title: 'Acc description',
                    edit: true
                },total_amount: {
                    title: 'Total Amount',
                    edit: true
                },venkat_amount: {
                    title: 'Venkat Amount',
                    edit: true
                },karthik_amount: {
                    title: 'Karthik Amount',
                    edit: true
                },status: {
                    title: 'Status',
                    edit: true
                },pending_dated: {
                    title: 'pending dated',
                    edit: true
                },email_alert: {
                    title: 'email alert',
                    edit: true
                },upload_fname: {
                    title: 'Attachment',
                    edit: true
                } ,amount_id: {
                    title: 'Unique ID',
                    edit: true
                    }               
            }
        });
        $('#PersonTableContainer').jtable('load');
    });
</script>
</head>
<body>
<div style="width:100%;text-align:center;">
<div id="PersonTableContainer"></div>
<div id="sub-div" style="display: none" class="OverLay" >
    <table class="attable" style="border-radius:10px">
     <tr>
         <th>Account Name</th>
         <th>Total Amount</th>
         <th>Last Modified Amount</th>
         <th>Current Amount</th>
         <th>Venkat Amount</th>
         <th>Karthik Amount</th>
         <th>Created Date</th>
         <th>Attachment</th>
         <th>Status</th>
     </tr>
        <tr id="sub-account">
            
        </tr>
        <tr>
            <td colspan="5"><input type="button" class="btn" value="update" onclick="closediv()"/></td>
        </tr>
    </table>
</div>
</div>
</body>
</html>