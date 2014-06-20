<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet" type="text/css" />
        <link rel="stylesheet" type="text/css" href="../css/tcal.css" />
         <script type="text/javascript" src="../scripts/alternatetable.js"></script>
	<script type="text/javascript" src="../scripts/tcal.js"></script>
    </head>
    <body>
       <script language="javascript" type="text/javascript">
            function date_checkbharathi()
            {

                var mnew=""; var dnew="";
                var curdate= new Date();
                var dd,mm,yyyy;
                dd=curdate.getDate();
                mm=curdate.getMonth()+1;
                var stdate = new Date();
                if (dd <= 9) {
                    dnew = "0" + dd;
                }
                if (mm <= 9) {
                    mnew = "0" + mm;
                }
                yyyy=curdate.getFullYear();
                var cur=yyyy+"-"+mnew+"-"+dnew;
                var a=document.getElementById("sdate").value;
                var b=document.getElementById("edate").value;
                var as=a.split("-");
                var ad=as[2];
                var am=as[1]-1;
                var ay=as[0];
                var stdate=new Date(ay,am,ad,00,00,00,00);
                var bs=b.split("-");
                var bd=bs[2];
                var bm=bs[1]-1;
                var by=bs[0];
                var eddate = new Date(by,bm,bd,00,00,00,00);
                var diff=eddate-stdate;
                var  daysDiff = Math.ceil(diff / (1000 * 60 * 60 * 24));
                //var stdate = new Date(a);
                //var eddate = new Date(b);
                //var diff = Math.ceil(stdate.getMonth()-eddate.getMonth());
                //if(diff!=0){
                    //alert("Please Select the Dates with in the same month.");
                    //return false;
                //}
                //alert(daysDiff);
           //     if(daysDiff>30)
             //   {
               //     alert("Selected Dates Exceed More Than A 31 Days");
                 //   return false;
               // }
                var curdate = new Date;
                curdate.getDate();
                var cd = curdate.getDate();
                var cm = curdate.getMonth()+1;
                var cy = curdate.getFullYear();
                var diff2 = stdate-curdate;
              //  if(diff2>0){
                //    alert("Start Date Exceeds The Current Date")
                  //  return false
               // }
                var diff3 = eddate-curdate;
                
              //  if(diff3>0){
                //    alert("End Date Exceeds The Current Date")
                  //  return false
               // }
       
                if(a=="" || b==""){
                    alert("Please select both Start Date and End Date ");
                    return false;
                } else  if(a > b ) {
                  //  alert("Hello");
                    alert(" Start Date should not be greater than End Date");
                     document.getElementById("sdate").value='';
                      document.getElementById("edate").value='';
                      document.getElementById("sdate").focus();
                  //  form.sdate1.value='';
                   // form.sdate1.focus();
                    return false;
                }
                    return true;
                  }
                        </script>
<div id="content">

<p></p>
        <table align="center" style="width:100px" border="0" cellpadding="0" cellspacing="1" >
            
            <tr>
                <td width="100px" nowrap>Start Date:</td>
                <td width="170px"> <input name="sdate" id="sdate" value="" class="tcal">
            
                <td width="100px" nowrap>End Date:</td>
                <td width="160px"> <input name="edate" id="edate" value="" class="tcal">
                 </td>

                <td align="left" width="100px">  <input type="submit" name="Cancel" class="Btn"  value="Submit" onclick="return date_checkbharathi(this)"/> </td>
                <td></td>

            </tr>
        </table>
 
</body>
</html>
