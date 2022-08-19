<%-- 
    Document   : results
    Created on : Apr 10, 2022, 8:59:45 PM
    Author     : rucha
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="com.app.dbconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Test Results</title>
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
%>
        <form method="post" action="GoToDashboard">
            <button class="btn" style="border: solid black; width:60px; height:50px; background-color: skyblue;">
                    <i class="fa fa-arrow-left fa-2x"></i>
            </button>
                <input type="hidden"  name="usertype" value="<%=usertype %>">
                <input type="hidden"  name="userid" value="<%=userid %>">
        </form>
        <center><h1>Your Test Results!</h1><hr>
        <table>
            <tr>
            <th>STUDENT ID</th>
            <th>TEST ID</th>
            <th>SUBJECT</th>
            <th>TEST DATE</th>
            <th>TEST TIME</th>
            <th>MARKS SECURED</th>
            <th>TOTAL MARKS</th>
            <th>PERCENTAGE</th>
        </tr>
    
<%      
    ResultSet testresults_rs = null;
    String sql= "SELECT * FROM tests where branch="+student_branch+" AND class="+student_class+";";
    dbconnection db = new dbconnection();
    testresults_rs = db.mysqldbconnection(sql, 0);
    
    while(testresults_rs.next())
    {
        String subject=testresults_rs.getString("subject");
        String test_date=testresults_rs.getString("test_date");
        String test_time=testresults_rs.getString("start_time");
        int test_id=testresults_rs.getInt("id");

        ResultSet studentresult_rs = null;
        String sql2= "SELECT * FROM "+subject+"_responses where student_id="+userid;
        dbconnection db2 = new dbconnection();
        studentresult_rs = db.mysqldbconnection(sql2, 0);

        int score=0;
        int totalmarks=0;

        while(studentresult_rs.next())
        {
            score = studentresult_rs.getInt("score");
            totalmarks = studentresult_rs.getInt("totalmarks");
%>
        <tr>
            <td><%=userid %></td>
            <td><%=test_id %></td>
            <td><%=subject %></td>
            <td><%=test_date %></td>
            <td><%=test_time %></td>
            <td><%=score %></td>
            <td><%=totalmarks %></td>
            <td><%=(score*100)/totalmarks %>%</td>
        </tr>
<%
        }
    }
%>
        </table>
        </center>
    </body>
</html>
