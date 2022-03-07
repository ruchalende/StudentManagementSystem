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
        <link rel="stylesheet" 
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>  
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />  
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </head>
    <body>
        <table align="center" height="20px" width="100px">
            <tr> 
                <form action="email-form.jsp" method="post">
                    <td style="border:none;">
                        <button class="btn" style="width:100px; height:50px; background-color: skyblue;">
                            <i class="fa fa-envelope fa-2x"></i>
                        </button> 
                    </td>
                     <input type="hidden" name="usertype" value="<%=usertype%>">
                     <input type="hidden" name="userid" value="<%=userid%>">
                     <input type="hidden" name="email" value="<%=email%>">
                     <input type="hidden" name="password" value="<%=password%>">
                </form>
                <td style="border:none;">
                    <form method="post" action="LogoutUser" align="right">
                        <input type="hidden" name="usertype" value="<%=usertype%>">
                        <button class=logout" style="width:100px; height:50px; background-color: red;">
                        <i class="fa fa-sign-out fa-2x"></i>
                        </button>
                    </form>
                </td>
            </tr>
        </table>
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
                    <input type="submit" name="submit" value="Submit" style="background-color: #00cc00;">
        </form> <br>
        <form action="search-record.jsp" method="post">
                    Enter Email To Search A Teacher Record:&nbsp&nbsp&nbsp
                    <input type="text" name="fetch">
                    <input type="hidden" name="usertype" value="<%=usertype%>">
                    <input type="hidden" name="userid" value="<%=userid%>">
                    <input type="hidden" name="recordtype" value="teachers">
                    <input type="submit" name="submit" value="Submit" style="background-color: #00cc00;">
        </form> <br>
        <form action="ExportToExcel" method="post">
            <input type="submit" name="submit" value="Export To Excel File"> 
            <input type="hidden" name="usertype" value="<%=usertype%>">
            <input type="hidden" name="userid" value="<%=userid%>">
            <input type="hidden" name="tablename" value="teachers">
        </form>
            <table>
            <br><label><strong>TEACHER DETAILS</strong></label><br><br>
            <tr>
            <th>TEACHER ID</th>
            <th>TEACHER FIRST NAME</th>
                <th>TEACHER LAST NAME</th>
                <th>TEACHER EMAIL</th>
                <!-- following the should be in while list of classes -->
                <% while(class_rs.next()){
                    year=class_rs.getInt("year");
                    branch_id=class_rs.getInt("branch_id");
                 %>
                <th><%=branch_id+"_"+year %></th>
                <% } %>
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
                <form method="post" id="checkbox-form">
                    <% 
                       int id=0;
                       class_rs=stmt.executeQuery(sql2);
                       while(class_rs.next()){ 
                       id=class_rs.getInt("id");
                    %>
                    <td> <input type="checkbox" name="chkteacher" value="<%=teacher_id %>" id="<%=id %>"></td>
                <% } %>  
                </tr>
            <%
                }
            %>
                    <button id="submit">Submit</button>
                    <div id="result"></div>  
                </form>
                <script>
                    $(document).ready(function(){  
                        $('#checkbox-form').submit(function(e){  
                            var classes_id = [];
                            var teacher_id = [];
                            $('.get_value').each(function(){  
                                if($(this).is(":checked"))  
                                {  
                                    classes_id.push($(this).attr('id'));
                                    teacher_id.push($(this).val());
                                }  
                            }); 
                            $.ajax({  
                                url:"insert-assigned-class.php",  
                                method:"POST",  
                                data:{classes_id:classes_id, teacher_id:teacher_id},  
                                success:function(data){  
                                    $('#result').html(data);  
                                }  
                            });  
                        });  
                    }); 
                </script>
            <%             
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
                    <input type="submit" name="submit" value="Submit" style="background-color: #00cc00;">
                    <br><br>
                </form>
                    <form action="search-record.jsp" method="post">
                    Enter Email To Search A Student Record:&nbsp&nbsp&nbsp
                    <input type="text" name="fetch">
                    <input type="hidden" name="usertype" value="<%=usertype%>">
                    <input type="hidden" name="userid" value="<%=userid%>">
                    <input type="hidden" name="recordtype" value="student">
                    <input type="submit" name="submit" value="Submit" style="background-color: #00cc00;">
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
        <label>ID:<%=userid%></label><br>
        <label>First Name: <%=first_name%></label><br>
        <label>Last Name: <%=last_name%></label><br>
        <label>Email: <%=email%></label><br>
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
         <h3><br><br><label>TEACHER DETAILS</label><br><br><p><br>
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
