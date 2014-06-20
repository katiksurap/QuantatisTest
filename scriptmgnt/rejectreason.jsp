<%-- 
    Document   : rejectreason
    Created on : Mar 15, 2012, 6:18:02 PM
    Author     : wifibharathi
--%>


        <%
            String userid = request.getParameter("userid");
             System.out.println("In rejectreason1 user "+userid);
            String cname = request.getParameter("cname");
             System.out.println("In rejectreason1 cname"+cname);
            String status = request.getParameter("status");
             System.out.println("In rejectreason1"+status);
            String rowVal=request.getParameter("rowVal");
             System.out.println("In rejectreason1 rowval"+rowVal);
            String assaignedto=request.getParameter("assignedto");
             System.out.println("In rejectreason1 ass===="+assaignedto);
            String rejby=request.getParameter("rejby");
             System.out.println("In rejectreason1 rej==="+rejby);
            int scriptid=Integer.parseInt(request.getParameter("scriptid"));
             System.out.println("In rejectreason1 sid===="+scriptid);
            System.out.println("Row value"+rowVal);
            System.out.println("------" + request.getParameter("userid") + "----" + request.getParameter("cname") + "----" + request.getParameter("status"));
        %>
      
        
            Reject Reason:
                <textarea name="reason" id="reason" rows="1"> </textarea>
               
                <input type="button" value="submit" onclick="return rejectSubmit('<%=request.getParameter("userid")%>','<%=request.getParameter("cname")%>','<%=request.getParameter("status")%>',<%=rowVal%>,'<%=assaignedto%>','<%=rejby%>',<%=scriptid%>)"/>
                
       
        <% out.println();%>
   
