<%-- 
    Document   : test-response
    Created on : Aug 6, 2022, 6:03:59 PM
    Author     : rucha
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="com.app.dbconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Test Responses</title>
        <link rel="stylesheet" 
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
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
%>
        <form method="post" action="GoToDashboard">
            <button class="btn" style="border: solid black; width:60px; height:50px; background-color: skyblue;">
                    <i class="fa fa-arrow-left fa-2x"></i>
            </button>
            <input type="hidden"  name="usertype" value="<%=usertype %>">
            <input type="hidden"  name="userid" value="<%=userid %>">
        </form>
        
        <h1>
            <center>Test Responses</center>
        </h1>
        <hr>
        
        <center>
<%
        ResultSet testresponse_rs = null;
        String sql= "SELECT * FROM tests where teacher_id="+userid+";";
        dbconnection db = new dbconnection();
        testresponse_rs = db.mysqldbconnection(sql, 0);
        String subject = "";
        int count=1;
        
        while(testresponse_rs.next())
                {
                    subject = testresponse_rs.getString("subject");
%>
                    <h3><%=count%>. <%=subject%></h3> 
<%
                    String responses="SELECT student.id, student.first_name,"
                            + "student.last_name, student.email, "
                            +subject+"_responses.score, "
                            +subject+"_responses.totalmarks from student, "
                            +subject+"_responses where student.id="
                            +subject+"_responses.student_id;";
                    dbconnection db2 = new dbconnection();
                    ResultSet student_responses=null;
                    student_responses = db2.mysqldbconnection(responses, 0);
                    String id = "";
                    String first_name = "";
                    String last_name = "";
                    String email = "";
                    int score=0;
                    int totalmarks=0;

                    while(student_responses.next())
                    {
                        id = student_responses.getString("id");
                        first_name = student_responses.getString("first_name");
                        last_name = student_responses.getString("last_name");
                        email = student_responses.getString("email");
                        score = student_responses.getInt("score");
                        totalmarks = student_responses.getInt("totalmarks");
%>
                    
                    <table>
                        
                        <tr>
                            <th>STUDENT ID</th>
                            <th>FIRST NAME</th>
                            <th>LAST NAME</th>
                            <th>EMAIL</th>
                            <th>SCORE</th>
                            <th>TOTAL MARKS</th>
                            <th>PERCENTAGE</th>
                        </tr>
                        
                        <tr>
                            <td><%=id %></td>
                            <td><%=first_name %></td>
                            <td><%=last_name %></td>
                            <td><%=email %></td>
                            <td><%=score %></td>
                            <td><%=totalmarks %></td>
                            <td><%=(score*100)/totalmarks %>%</td>
                        </tr>
                        
                        <br><br>
<%
                    }
                    count++;
                }
%>
        </center>
    <body>
</html>