<%-- 
    Document   : Settings
    Created on : Apr 2, 2022, 5:33:16 PM
    Author     : rucha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Settings</title>
        <link rel="stylesheet" 
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />  
        
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </head>
    
    <body>
<%
    String usertype = request.getParameter("usertype");
    int userid = Integer.parseInt (request.getParameter("userid"));
%>
        <form action="GoToDashboard" method="post">
            <button class="btn" style="border: solid black; width:60px; height:50px; background-color: skyblue;">
                    <i class="fa fa-arrow-left fa-2x"></i>
            </button>
            <input type="hidden"  name="usertype" value="<%=usertype %>">
            <input type="hidden"  name="userid" value="<%=userid %>">
        </form>
        
        <h1>
            <center>Settings</center>
        </h1>
        <hr>
        
        <form action="GoToDashboard" method="post">
            <h3>
                Set Theme:
            </h3>
            <input type="color" id="theme" name="theme">
            <input type="submit" value="Apply">
            <input type="hidden"  name="usertype" value="<%=usertype %>">
            <input type="hidden"  name="userid" value="<%=userid %>">
        </form>
        <hr>
        
        <h3>
            Upload Profile Picture
        </h3>
        <form method="post" action="ImageUpload" enctype="multipart/form-data">
            <input type="file" name="photo" size="50"/>
            <input type="submit" value="Submit">
            <input type="hidden"  name="usertype" value="<%=usertype %>">
            <input type="hidden"  name="userid" value="<%=userid %>">
        </form>
    </body>
</html>