<%-- 
    Document   : EmailForm
    Created on : Jan 30, 2022, 8:38:35 PM
    Author     : rucha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Email</title>
        <style>
            form {
                border: 1px solid #023d6d;
                margin: auto;
                color: #023d6d;
            }
            
            input[type=text] {
                width: 365px;
                height: 5px;
                padding: 10px;
            }
            
            body{ 
                background-color: lavenderblush;
            }
            
            th, td {
                padding-top: 10px;
                padding-bottom: 10px;
                padding-left: 10px;
                padding-right: 10px;
            }
            
            p{
                border: 3px black solid;
                height: 250px;
                width: 500px;   
                background-color: blanchedalmond;
            }
        </style>
    </head>
    
    <body>
<%
    String usertype = request.getParameter("usertype");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    int userid = Integer.parseInt (request.getParameter("userid"));
%>
        <form action="EmailSendingServlet" method="post" enctype="multipart/form-data">
            <table border="0" width="50%" align="center" style="text-align:left;">

                <caption>
                    <h2>
                        Send E-mail<hr>
                    </h2>
                </caption>

                <tr>
                    <td>
                        Sender Address:
                    </td>
                    <td>
                        <input type="hidden" name="sender" value="<%=email%>"/><%=email%>
                    </td>
                </tr>

                <tr>
                    <td>
                        Recipient Address: 
                    </td>
                    <td>
                        <input type="text" name="recipient"/>
                    </td>
                </tr>

                <tr>
                    <td>
                        Subject: 
                    </td>
                    <td>
                        <input type="text" name="subject"/>
                    </td>
                </tr>

                <tr>
                    <td>
                        Content: 
                    </td>
                    <td>
                        <textarea rows="10" cols="50" name="content"></textarea> 
                    </td>
                </tr>

                <tr>
                    <td>
                        Attachments: 
                    </td>
                    <td>
                        <input type="file" name="file1" size="50" />
                    </td>
                    <br>
                </tr>

                <tr>
                    <td colspan="2" align="center"><input type="submit" value="Send"
                        style="background-color: #00cc00; height: 50px; width: 100px; border-radius: 15px;"/>
                    </td>
                </tr>
            </table>
            <input type="hidden"  name="usertype" value="<%=usertype %>">
            <input type="hidden"  name="userid" value="<%=userid %>">
            <input type="hidden"  name="password" value="<%=password %>">
        </form>
    </body>
</html>