<%-- 
    Document   : search-record
    Created on : Jan 12, 2022, 10:11:03 PM
    Author     : rucha
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Search Record</title>
    </head>
    <body>
        <form action="SearchRecord" method="post">
            
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
                 <input type="hidden"  name="usertype" value="<%=usertype %>"></h4>
                 <input type="hidden"  name="recordtype" value="<%=recordtype %>"></h4>  
                 <input type="hidden"  name="userid" value="<%=userid %>"></h4>
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
                   <h4><input type="hidden"  name="first name" value="<%=rs.getString(2)%>"><%=rs.getString(2)%></h4>
                   </td>
                   </tr> 
                   <tr>
                    <td width="50%">
                   <h3>Last Name:</h3>
                   </td>
                     <td width="60%">
                   <h4><input type="hidden" name="last name" value="<%=rs.getString(3)%>"><%=rs.getString(3)%></h4>
                   </td>
                   </tr>
                   <tr>
                   <td width="60%">
                   <h3>Email:</h3>
                   </td>
                    <td width="60%">
                   <h4><input type="hidden" name="email" value="<%=rs.getString(4)%>"><%=rs.getString(4)%></h4>
                   </td>
                   </tr>
                   <%
                       if(recordtype.equals("student")){
                   %>
                    <tr>
                   <td width="60%">
                   <h3>Year:</h3>
                   </td>
                    <td width="60%">
                   <h4><input type="hidden" name="class" value="<%=rs.getInt(6)%>"><%=rs.getString(6)%></h4>
                   </td>
                   </tr>  
                   <%
                       }
                   %>
                    <tr>
                    <td><input type="submit" value="OK" name="return"></td>
                    </tr>
                 </table>
                    <%
                       }
}
                   %>
        </form>
    </body>
</html>
