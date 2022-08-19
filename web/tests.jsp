<%-- 
    Document   : tests
    Created on : Apr 3, 2022, 4:35:00 PM
    Author     : rucha
--%>

<%@page import="com.app.dbconnection"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tests</title>
        <link rel="stylesheet" 
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>  
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />  
        
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        
        <style>
            table, th, td 
            {
                padding-top: 10px;
                padding-bottom: 10px;
                padding-left: 10px;
                padding-right: 10px;
                border: 2px black solid;
                width: 1000px; 
                text-align: center;
            }
        </style>
    </head>
    
    <body>
<%
    String usertype = request.getParameter("usertype");
    int userid = Integer.parseInt (request.getParameter("userid"));
    int student_class = Integer.parseInt (request.getParameter("student_class"));
    int student_branch = Integer.parseInt (request.getParameter("student_branch"));

    ResultSet tests_rs = null;
    String sql= "SELECT * FROM tests where branch="+student_branch+" AND class="+student_class+";";
    dbconnection db = new dbconnection();
    tests_rs = db.mysqldbconnection(sql, 0);
%>
        <form method="post" action="GoToDashboard">
        <button class="btn" style="border: solid black; width:60px; height:50px; background-color: skyblue;">
                <i class="fa fa-arrow-left fa-2x"></i>
        </button>
        <input type="hidden"  name="usertype" value="<%=usertype %>">
        <input type="hidden"  name="userid" value="<%=userid %>">
        </form>
        
        <center>
            <h1>Upcoming Tests</h1><hr>
        
            <table>
                
                <tr>
                    <th>ID</th>
                    <th>SUBJECT</th>
                    <th>TEST DATE</th>
                    <th>STARTS AT</th>
                    <th>ENDS AT</th>
                    <th>BRANCH</th>
                    <th>YEAR</th>
                    <th>ACTION</th>
                </tr>
                
<%
                    int test_id = 0;
                    String subject = "";
                    String test_date = "";
                    String start_time = "";
                    String end_time = "";
                    String branch = "";
                    String year = "";

                    while(tests_rs.next())
                    {
                        test_id = tests_rs.getInt("id");
                        subject = tests_rs.getString("subject");
                        test_date = tests_rs.getString("test_date");
                        start_time = tests_rs.getString("start_time");
                        end_time = tests_rs.getString("end_time");
                        branch = tests_rs.getString("branch");
                        year = tests_rs.getString("class");
                        ResultSet branch_name = null;
                        String sql2 = "SELECT branch_name FROM branches WHERE id = "+branch+";";
                        dbconnection db2 = new dbconnection();
                        branch_name = db2.mysqldbconnection(sql2, 0);
                        String b_name = "";
                        while(branch_name.next())
                        {
                            b_name = branch_name.getString("branch_name");
%>
                <tr>
                    <td><%=test_id %></td>
                    <td><%=subject %></td>
                    <td><%=test_date %></td>
                    <td><%=start_time %></td>
                    <td><%=end_time %></td>
                    <td><%=b_name %></td>
                    <td><%=year %></td>
                    
                    <form action="test-page.jsp" method="post">
                        <td><input type="submit" value="START" name="submit"></td>

                        <input type="hidden"  name="subject" value="<%=subject %>">
                        <input type="hidden"  name="test_id" value="<%=test_id %>">
                        <input type="hidden"  name="start_time" value="<%=start_time %>">
                        <input type="hidden"  name="end_time" value="<%=end_time %>">
                        <input type="hidden"  name="test_date" value="<%=test_date %>">
                        <input type="hidden"  name="branch_name" value="<%=b_name %>">
                        <input type="hidden"  name="year" value="<%=year %>">
                        <input type="hidden"  name="usertype" value="<%=usertype %>">
                        <input type="hidden"  name="userid" value="<%=userid %>">
                    </form>
                </tr>
<%
                        }
                    }
%>
            </table>
        </center>
    </body>
</html>