<%-- 
    Document   : test-page
    Created on : Apr 8, 2022, 9:52:30 PM
    Author     : rucha
--%>
<%@page import="java.sql.*"%>
<%@page import="com.app.dbconnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Test</title>
        <style>
            table, th, td 
            {
              border:1px solid black;
              border-collapse: seperate;
              width:500px;
              padding:10px;
              margin:30px;
              border-spacing:10px;
              cellspacing: 10px;
            }
        </style>
    </head>
    
    <body>
<%
        String msg="";
        String usertype = request.getParameter("usertype");
        int userid = Integer.parseInt (request.getParameter("userid"));
     
        int test_id = Integer.parseInt (request.getParameter("test_id"));
        String subject = request.getParameter("subject");
        int year = Integer.parseInt (request.getParameter("year"));
        String student_branch = request.getParameter("branch_name");
        String test_date = request.getParameter("test_date");
        String start_time = request.getParameter("start_time");
        String end_time = request.getParameter("end_time");
        
        try
        {
%>
    
    <center>
        <h2><%=subject %> Test<h2>
    </center>
    <hr>
    <form method="post" action="ResultCalculation">
        <table style="width:900px;">
            <col style="width:20%">
            <col style="width:70%">
            <col style="width:30%">
            
            <tr>
                <th style="width:30%">Question Number</th>
                <th>Questions</th>
                <th>Marks</th>
            </tr>
<%
            String questions="";
            questions="SELECT * FROM "+subject;
            ResultSet questions_rs = null;
            dbconnection db = new dbconnection();
            questions_rs = db.mysqldbconnection(questions, 0);

            int question_no=0;
            String question="";
            String a="";
            String b="";
            String c="";
            String d="";
            String answer="";
            int marks=0;
            while(questions_rs.next())
            {
                question_no=questions_rs.getInt("question_no");
                question=questions_rs.getString("question");
                a=questions_rs.getString("a");
                b=questions_rs.getString("b");
                c=questions_rs.getString("c");
                d=questions_rs.getString("d");
                answer=questions_rs.getString("answer");
                marks=questions_rs.getInt("marks");
%>
                <tr>
                    <td>
                        <center><%=question_no %></center>
                    </td>
                    <td style: "width: 400px;"><b><%=question %></b><br><br>
                        <input type="radio" id="a" name="<%=question_no %>_options" value="a">A: <%=a %><br>
                        <input type="radio" id="b" name="<%=question_no %>_options" value="b">B: <%=b %><br>
                        <input type="radio" id="c" name="<%=question_no %>_options" value="c">C: <%=c %><br>
                        <input type="radio" id="d" name="<%=question_no %>_options" value="d">D: <%=d %><br>
                        <input type="hidden"  name="<%=question_no %>_answer" value="<%=answer %>">
                    </td>
                    <td>
                        <center>
                            <%=marks%>
                        </center>
                    </td>
                </tr>
<%
            }
            msg="Test submitted successfully";
            } catch(Exception ex)
            {
                ex.printStackTrace();
                msg="There was an error: "+ex.getMessage();
            }
%>
        </table>
        
        <input type="hidden"  name="test_id" value="<%=test_id %>">
        <input type="hidden"  name="start_time" value="<%=start_time %>">
        <input type="hidden"  name="test_date" value="<%=test_date %>">
        <input type="hidden"  name="subject" value="<%=subject %>">
        <input type="hidden"  name="usertype" value="<%=usertype %>">
        <input type="hidden"  name="year" value="<%=year %>">
        <input type="hidden"  name="userid" value="<%=userid %>">
        <input type="hidden"  name="msg" value="<%=msg %>">
        <center>
            <input type="submit" name="submit" value="Submit" 
               style="border: solid black; width:100px; height:50px; background-color: mediumaquamarine;">
        </center>
    </form>
    </body>
</html>
