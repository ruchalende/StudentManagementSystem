<%-- 
    Document   : dashboard
    Created on : Dec 26, 2021, 2:57:31 PM
    Author     : rucha
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
        String first_name=(String)session.getAttribute("first_name"); 
        String last_name=(String) session.getAttribute("last_name"); 
        String email=(String) session.getAttribute("email"); 
        String password=(String) session.getAttribute("password");
        
    Connection con = null;  
    Statement stmt = null;
    ResultSet rs = null;
    //int userid = Integer.parseInt(request.getParameter("userid"));
    String msg = (String) request.getAttribute("msg"); 
    int userid=(Integer) request.getAttribute("userid");
    if(msg!=null && msg!=""){ 
  
%> <script>
    var msg = " <%=msg %> ";
        if(msg!==""){
            alert(msg);
        }
    </script>
         
         <%
    }
        
    String usertype = (String) request.getAttribute("usertype"); 
    Class.forName("com.mysql.jdbc.Driver");
    con =DriverManager.getConnection      //opens the connection
    ("jdbc:mysql://127.0.0.1:3306/ruchalende_studentmanangement","root","");    //parameters
    stmt = con.createStatement();   //creates Statement object to send SQL statements to DB
    
            String admin="admin";
            String teacher="teacher";
            String student="student";  %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <% if(usertype.equals(admin)==true){ %>
        <title>Admin Dashboard</title>
        <% } else if(usertype.equals(student)==true){ %>
        <title>Student Dashboard</title>
        <% } else { %>
        <title>Teacher Dashboard</title>
        <% } %>
        <style>
            th, td {
                padding-top: 10px;
                padding-bottom: 10px;
                padding-left: 10px;
                padding-right: 10px;
                border: 2px black solid;
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
        <div align="right" style="position: relative;">
        <form method="post" action="LogoutUser" >
            <input type="hidden" name="usertype" value="<%=usertype%>">
            <input type="submit" value="Logout"  style="height:50px; width:100px;">
        </form>
        <form action="EmailForm.jsp" method="post">
             <button style="text-align:right;">Send Email</button>
             <input type="hidden" name="usertype" value="<%=usertype%>">
             <input type="hidden" name="userid" value="<%=userid%>">
             <input type="hidden" name="email" value="<%=email%>">
             <input type="hidden" name="password" value="<%=password%>">
         </form>
         </div>
    <center>
<%
    if((usertype.equals(admin)==true)){
    String sql="SELECT * FROM admin where id="+userid;
    rs = stmt.executeQuery(sql);   
%>

        <% if(email!=""){
            
         %>
         <label><center><h1>Hello, <%=first_name+" "+last_name %>! </h1></center> </label><hr><br>
        <% 
            }
            //get list of all classes- SELECT * from classes
            ResultSet class_rs=null;
            String sql2="SELECT * FROM classes;";
            class_rs = stmt.executeQuery(sql2);
            int year=0;
            int branch_id=0;
            %>
        <form action="DeleteRecord" method="post">
                    Enter Email To Delete A Teacher Record:&nbsp&nbsp&nbsp
                    <input type="text" name="fetch">
                    <input type="hidden" name="usertype" value="<%=usertype%>">
                    <input type="hidden" name="userid" value="<%=userid%>">
                    <input type="hidden" name="recordtype" value="teachers">
                    <input type="submit" name="submit" value="submit">
        </form> <br>
        <form action="search-record.jsp" method="post">
                    Enter Email To Search A Teacher Record:&nbsp&nbsp&nbsp
                    <input type="text" name="fetch">
                    <input type="hidden" name="usertype" value="<%=usertype%>">
                    <input type="hidden" name="userid" value="<%=userid%>">
                    <input type="hidden" name="recordtype" value="teachers">
                    <input type="submit" name="submit" value="submit">
        </form> <br>
            <table>
            <br><label><strong>TEACHER DETAILS</strong></label><br><br>
            <tr>
            <th>TEACHER ID</th>
            <th>TEACHER FIRST NAME</th>
                <th>TEACHER LAST NAME</th>
                <th>TEACHER EMAIL</th>
                <!-- following the should be in while list of classes 
                </% while(class_rs.next()){
                    year=class_rs.getInt("year");
                    branch_id=class_rs.getInt("branch_id");
                 %>
                <th></%=year+"_"+branch_id %></th>
                </% } %> -->
            </tr>
            <%
                
                String teacher_first_name=null;
                String teacher_last_name=null;
                String teacher_email=null;
                ResultSet teacher_rs=null;
                int teacher_id=0;
                Statement st=null;
                st = con.createStatement();
                String sql3="SELECT * FROM teachers;";
                teacher_rs = st.executeQuery(sql3);
                while(teacher_rs.next()){
                teacher_id=teacher_rs.getInt("id");
                teacher_first_name=teacher_rs.getString("first_name");
                teacher_last_name=teacher_rs.getString("last_name");
                teacher_email=teacher_rs.getString("email");   
            %>
                <tr>
                    <td> <%= teacher_id %> </td>
                    <td> <%= teacher_first_name %> </td>
                    <td> <%= teacher_last_name %> </td>
                    <td> <%= teacher_email %> </td>
                    <!-- while -->
        <!--            </% class_rs = stmt.executeQuery(sql2);   
                        while(class_rs.next()){ %>
                    <td> <input type="checkbox" name="chkteacher"></td>
                </% } %>  -->
                </tr>
            <%
                }
            ResultSet student_rs=null;
            String sql4="SELECT * FROM student;";
            student_rs = stmt.executeQuery(sql4);
            %>
            </table>
            <br><br><hr><br>
                <form action="DeleteRecord" method="post">
                    Enter Email To Delete A Student Record:&nbsp&nbsp&nbsp
                    <input type="text" name="fetch">
                    <input type="hidden" name="usertype" value="<%=usertype%>">
                    <input type="hidden" name="userid" value="<%=userid%>">
                    <input type="hidden" name="recordtype" value="student">
                    <input type="submit" name="submit" value="submit">
                    <br><br>
                </form>
                    <form action="search-record.jsp" method="post">
                    Enter Email To Search A Student Record:&nbsp&nbsp&nbsp
                    <input type="text" name="fetch">
                    <input type="hidden" name="usertype" value="<%=usertype%>">
                    <input type="hidden" name="userid" value="<%=userid%>">
                    <input type="hidden" name="recordtype" value="student">
                    <input type="submit" name="submit" value="submit">
                </form> <br>
                <label><strong>STUDENT DETAILS</strong></label><br><br>
        <table>
        <tr>
            <th>STUDENT ID</th>
            <th>STUDENT FIRST NAME</th>
            <th>STUDENT LAST NAME</th>
            <th>STUDENT EMAIL</th>
            <th>CLASS</th>
        </tr>
        <%
                int student_id=0;
                String student_first_name=null;
                String student_last_name=null;
                String student_email=null;
                int student_class=0;
                while(student_rs.next()){
                    student_id=student_rs.getInt("id");
                student_first_name=student_rs.getString("first_name");
                student_last_name=student_rs.getString("last_name");
                student_email=student_rs.getString("email"); 
                student_class=Integer.parseInt(student_rs.getString("class"));
            %>
                <tr>
                    <td> <%= student_id %> </td>
                    <td> <%= student_first_name %> </td>
                    <td> <%= student_last_name %> </td>
                    <td> <%= student_email %> </td>
                    <td> <%= student_class %> </td>
                </tr>
        <% 
            }
}
            else if(usertype.equals(student)==true){
            int stu_class=(Integer) session.getAttribute("class");
            ResultSet stu=null;
            String sql5="SELECT * FROM student where id="+userid;
            stu = stmt.executeQuery(sql5);
            while(stu.next()){
                first_name=stu.getString("first_name");
                last_name=stu.getString("last_name");
                email=stu.getString("email"); 
                stu_class=Integer.parseInt(stu.getString("class"));
            }
                if(email!=""){
        %>
        
        <label><h1>Hello, <%=first_name+" "+last_name %>!</h1></label><br><hr>
        <h3><label>STUDENT DETAILS</label><br><br>
        <p><br>
        <label>ID:<%=userid%></label><br><br>
        <label>First Name: <%=first_name%></label><br><br>
        <label>Last Name: <%=last_name%></label><br><br>
        <label>Email: <%=email%></label><br><br>
        <label>Class: <%=stu_class%></label><br><br></h3>
        
        
        <%
            }  %>
            
        <form action="edit-record.jsp" method="post">
                    Enter Email To Update Your Details:&nbsp&nbsp&nbsp
                    <input type="text" name="fetch">
                    <input type="hidden" name="usertype" value="<%=usertype%>">
                    <input type="hidden" name="userid" value="<%=userid%>">
                    <input type="hidden" name="recordtype" value="student">
                    <input type="submit" name="submit" value="submit">
                </form>
        <%
}
        
        else if(usertype.equals(teacher)==true){
            ResultSet teach=null;
            String sql6="SELECT * FROM teachers where id="+userid;
            teach = stmt.executeQuery(sql6);
            String teacher_class="";
            //int student_class=0;
            while(teach.next()){
                //teacher_class=teach.getString("classes");
                
                first_name=teach.getString("first_name");
                last_name=teach.getString("last_name");
                email=teach.getString("email");
            }
         if(email!=""){
            
         %>
         <h1><label>Hello, <%=first_name+" "+last_name %>!</label><br></h1><hr>
         <h3><br><br><label>TEACHER DETAILS</label><br><br><p><br><br>
         <label>ID:<%=userid%></label><br><br      
        <label>First Name:<%=first_name%></label><br><br>
        <label>Last Name:<%=last_name%></label><br><br>
        <label>Email:<%=email%></label></h3>
    <!--    <label>Class:</%=teacher_class%></label><br><br></h3>  -->
        <%
            } 
        %>
        <form action="edit-record.jsp" method="post">
                    Enter Email To Update Your Details:&nbsp&nbsp&nbsp
                    <input type="text" name="fetch">
                    <input type="hidden" name="usertype" value="<%=usertype%>">
                    <input type="hidden" name="userid" value="<%=userid%>">
                    <input type="hidden" name="recordtype" value="teachers">
                    <input type="submit" name="submit" value="submit">
                </form>
        <%
            //show list of students from the class allocated to teacher
//get branch and class from teacher table and then get list of students from that branch and class
        
            }
        else{
         out.print("not a valid user");
        }
%>
        </center>
        </body>
        
</html>
