<%-- 
    Document   : add-test
    Created on : Apr 3, 2022, 5:00:11 PM
    Author     : rucha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Tests</title>
        
        <style>
            th, td {
                padding-top: 10px;
                padding-bottom: 10px;
                padding-left: 10px;
                padding-right: 10px;
                align: center;
            }
        </style>
    </head>
    <body>
        <%
            String usertype = request.getParameter("usertype");
            int userid = Integer.parseInt (request.getParameter("userid"));
        %>
        <h1><center>Add Tests<hr></center></h1>
        <form method="post" action="AddTest" enctype="multipart/form-data">
            <table>
                <tr>
                    <td>Test ID:</td>
                    <td><input type="text" name="test_id"></td>
                </tr>
                <tr>
                    <td>Subject:</td>
                    <td><input type="text" name="subject"></td>
                </tr>
                <tr>
                    <td>Date:</td>
                    <td><input type="date" name="date"></td>
                </tr>
                <tr>
                    <td>Start Time:</td>
                    <td><input type="time" name="start_time"></td>
                </tr>
                <tr>
                    <td>End Time:</td>
                    <td><input type="time" name="end_time"></td>
                </tr>
                <tr>
                    <td>Branch:</td>
                    <td>
                        <select name="branch">
                            <option>- Select -</option>
                            <option value="3">COMP</option>
                            <option value="1">IT</option>
                            <option value="2">ENTC</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>Year:</td>
                    <td>
                        <select name="year">
                            <option>- Select -</option>
                            <option value="1">First</option>
                            <option value="2">Second</option>
                            <option value="3">Third</option>
                            <option value="4">Fourth</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td><input type="file" name="testquestions" size="50" multiple/></td>
                </tr>
                <tr>
                    <td><input type="submit" name="submit" value="Submit"></td>
                </tr>
                <input type="hidden"  name="usertype" value="<%=usertype %>">
                <input type="hidden"  name="userid" value="<%=userid %>">
            </table>
        </form>
    </body>
</html>
