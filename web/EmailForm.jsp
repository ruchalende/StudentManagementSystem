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
    </head>
    <body>
        <%
            //HttpSession session = request.getSession();
            String usertype = request.getParameter("usertype");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            int userid = Integer.parseInt (request.getParameter("userid"));
        %>
        <form action="EmailSendingServlet" method="post">
        <table border="0" width="50%" align="center">
            <caption><h2>Send New E-mail</h2></caption>
            <tr>
                <td width="50%">Sender Address:</td>
                <td><input type="hidden" name="sender" size="53" value="<%=email%>"/><%=email%></td>
            </tr>
            <tr>
                <td width="50%">Recipient Address: </td>
                <td><input type="text" name="recipient" size="53"/></td>
            </tr>
            <tr>
                <td>Subject </td>
                <td><input type="text" name="subject" size="53"/></td>
            </tr>
            <tr>
                <td>Content </td>
                <td><textarea rows="10" cols="50" name="content"></textarea> </td>
            </tr>
            <tr>
                <td colspan="2" align="center"><input type="submit" value="Send"/></td>
            </tr>
        </table>
        <input type="hidden"  name="usertype" value="<%=usertype %>">
        <input type="hidden"  name="userid" value="<%=userid %>">
        <input type="hidden"  name="password" value="<%=password %>">
    </form>
    </body>
</html>
