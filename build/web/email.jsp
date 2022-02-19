<%-- 
    Document   : email
    Created on : Jan 24, 2022, 7:32:16 PM
    Author     : rucha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Email</title>
        <style>
            td{
                padding:10px;
            }
            .vl {
                border-left: 6px solid black;
                height: 577px;
                position: absolute;
                left: 60%;
                margin-left: -3px;
                top: 0;
            }
        </style>
    </head>
    <body>
        <% 
            String sender_email=request.getParameter("sender_email");
            String usertype = request.getParameter("usertype");
            String sender_password = request.getParameter("sender_password");
            int userid = Integer.parseInt (request.getParameter("userid"));
        %>
        <div class="vl"></div>
        <div class="container">
            <div>
                <h1>Compose an Email</h1>
            </div>
            <br>
            <form action="SendEmail" method="post">
                <table class="table table-hover">
                    <tr>
                        <td>From</td>
                        <td><input type="text" 
                                   style="width:603px"  
                                   value="<%=sender_email %>" 
                                   name="name" 
                                   class="form-control"></td>
                    </tr>

                    <tr>
                        <td>To</td>
                        <td><input type="email" 
                                   style="width:603px" 
                                   required="" 
                                   placeholder="Email" 
                                   name="receiver_email" 
                                   class="form-control"></td>
                    </tr>
                    <tr>
                        <td>Subject</td>
                        <td><input type="text" 
                                   style="width:603px" 
                                   required="" 
                                   placeholder="Subject" 
                                   name="subject" 
                                   class="form-control"></td>
                    </tr>
                    <tr>
                        <td>Message</td>
                        <td><textarea name="message" 
                                      required="" rows="5" 
                                      cols="80" 
                                      placeholder="Your Message"></textarea></td>
                    </tr>
                    <tr>
                        <td><input type="submit" 
                                   id="submit" 
                                   class="btn btn-primary" 
                                   value="Submit"></td>
                    </tr>
                </table>
                <input type="hidden"  name="usertype" value="<%=usertype %>">
                <input type="hidden"  name="userid" value="<%=userid %>">
                <input type="hidden"  name="sender_email" value="<%=sender_email %>">
                <input type="hidden"  name="sender_password" value="<%=sender_password %>">
            </form>
        </div>   
    </body>
</html>
