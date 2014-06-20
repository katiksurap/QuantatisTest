<%@page import="com.sql.connection.SQLManager"%><%@page
	import="java.sql.ResultSet"%><%@page
	import="java.sql.PreparedStatement"%><%@page
	import="java.sql.Connection"%><%
	System.out.println("ingetdiv");
	Connection con = null;
	PreparedStatement ps = null, psmain = null, pssubup = null, pstcheck = null;
	ResultSet rs = null, rscheck = null, rsexec = null;
	String sqlquery = "";
	String accid = request.getParameter("accid");
	String Account_name = request.getParameter("accname");
	String curamount = request.getParameter("curamount");
	String vamount = request.getParameter("vamount");
	String kamount = request.getParameter("kamount");
	String status = request.getParameter("status");
	String upload_fname = request.getParameter("upload_fname");
	String penddate = request.getParameter("penddate");
	System.out.println("accid" + accid);
	String totamount = "";
	String accname = "";
	String latamount = "";
	String accnid = "";
	int pendamount = 0;
	String Count = "";
	String acc_amoutn = "";
	String venkat_amount = "";
	String karthik_amount = "";
	String queryExec = "", queryExecCheck = "";
	try {
		con = SQLManager.getConnection();
		sqlquery = "SELECT COUNT(1) FROM account_subtab WHERE account_id = ? and firstupdate =0";
		ps = con.prepareStatement(sqlquery);
		ps.setString(1, accid);
		System.out.println("query-----" + ps.toString());
		rs = ps.executeQuery();
		if (rs.next()) {
			Count = rs.getString(1);
			System.out.println("----" + Count);
			if (Integer.parseInt(Count) == 1) {
				queryExec = "update account_subtab set updated_amount=?,venkat_update_amount=?,karthik_update_amount=?,upload_fname=?,penddate=?,firstupdate=? WHERE account_id = ?";
				psmain = con.prepareStatement(queryExec);
				psmain.setString(1, curamount);
				psmain.setString(2, vamount);
				psmain.setString(3, kamount);
				psmain.setString(4, upload_fname);
				psmain.setString(5, penddate);
				psmain.setString(6, "1");
				psmain.setString(7, accid);
				int h= psmain.executeUpdate();
				if(h > 0){
					System.out.println("Update to the Subtable with fields happened ");
					out.println("Update to the Subtable with fields happened ");
				}
				psmain =null;
			} else {
				queryExecCheck = "select acc_amount,venkat_amount,karthik_amount from account_subtab WHERE account_id = ? order by inserted_date";
				pstcheck = con.prepareStatement(queryExecCheck);
				pstcheck.setString(1, accid);
				rscheck = pstcheck.executeQuery();
				if (rscheck.next()) {
					acc_amoutn = rscheck.getString(1);
					venkat_amount = rscheck.getString(2);
					karthik_amount = rscheck.getString(3);
				}
				queryExec = "insert into account_subtab(account_id,status,acc_amount,updated_amount,venkat_amount,karthik_amount,venkat_update_amount,karthik_update_amount,upload_fname,firstupdate) values(?,?,?,?,?,?,?,?,?,?)";
				psmain= con.prepareStatement(queryExec);
				psmain.setString(1, accid);
				psmain.setString(2, status);
				psmain.setString(3, acc_amoutn);
				psmain.setString(4, curamount);
				psmain.setString(5, venkat_amount);
				psmain.setString(6, karthik_amount);
				psmain.setString(7, vamount);
				psmain.setString(8, kamount);
				psmain.setString(9, upload_fname);
				psmain.setString(10,"1");
				int g = psmain.executeUpdate();
				if(g > 0 ){
					System.out.println("Insertion to the Subtable with fields happened ");
					out.println("Insertion to the Subtable with fields happened ");
				}
				
			}

		}
	} catch (Exception ex) {
		ex.printStackTrace();
	} finally {
		con.close();
	}
%>