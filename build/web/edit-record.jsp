<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Record</title>
    </head>
    <body>
        <form action="UpdateRecord" method="post">
       
        
        <%
       
        Connection con=null;
        ResultSet rs = null;
        Statement st=null;
        Class.forName("com.mysql.jdbc.Driver");
        con=DriverManager.getConnection
        ("jdbc:mysql://127.0.0.1:3306/ruchalende_studentmanangement","root","");      
              
        String email = request.getParameter("fetch");
        String usertype = request.getParameter("usertype");
        String recordtype = request.getParameter("recordtype");
        int userid = Integer.parseInt (request.getParameter("userid"));
         if(!con.isClosed())
            {   
        PreparedStatement ps=con.prepareStatement("select * from "+recordtype+" where email = ?;");
         ps.setString(1, email);
            rs=ps.executeQuery();
             while(rs.next())
             {
 %>

               <table align="center">
                   <tr>
                       <td><h2><u>Requested Records</u></h2></td>
                   </tr>
                   <tr>
                   <td width="60%">
                       <h3>Id:</h3>
                   </td>
                   <td width="60%">
                   <h4> <input type="hidden"  name="id" value="<%=rs.getString(1)%>"><%=rs.getString(1)%></h4>
                   </td>
                   </tr>
                    <tr>
                   <td width="60%">
                   <h3>First Name:</h3>
                   </td>
                   <td width="60%">
                   <h4><input type="text"  name="first name" value="<%=rs.getString(2)%>"></h4>
                   </td>
                   </tr> 
                   <tr>
                    <td width="50%">
                   <h3>Last Name:</h3>
                   </td>
                     <td width="60%">
                   <h4><input type="text" name="last name" value="<%=rs.getString(3)%>"></h4>
                   </td>
                   </tr>
                   <tr>
                   <td width="60%">
                   <h3>Email:</h3>
                   </td>
                    <td width="60%">
                   <h4><input type="text" name="email" value="<%=rs.getString(4)%>"></h4>
                   </td>
                   </tr>
                   <%
                       if(recordtype.equals("student")){
                   %>
                    <tr>
                   <td width="60%">
                   <h3>Class:</h3>
                   </td>
                    <td width="60%">
                   <h4><input type="text" name="class" value="<%=rs.getInt(6)%>"></h4>
                   </td>
                   </tr>  
                   <%
                       }
                   %>
                    <tr>
                    <td><input type="submit" value="Update" name="update"></td>
                    </tr>
                </table>
                   <input type="hidden"  name="usertype" value="<%=usertype %>"></h4>
                   <input type="hidden"  name="userid" value="<%=userid %>"></h4>
                   <input type="hidden"  name="recordtype" value="<%=recordtype %>"></h4>
            <%
                    }
                    }
            %>
 </form>
    </body>
</html>
