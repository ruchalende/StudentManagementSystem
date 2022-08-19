<%-- 
    Document   : dashboard
    Created on : Dec 26, 2021, 2:57:31 PM
    Author     : rucha
--%>


<%@page import="java.util.Base64"%>
<%@page import="java.io.ByteArrayOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="com.app.dbconnection"%>
<%@page import="javax.swing.JFrame"%>
<%@page import="javax.swing.ImageIcon"%>
<%@page import="javax.swing.JLabel"%>
<%@page import="java.awt.EventQueue"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
    String first_name=(String)session.getAttribute("first_name"); 
    String last_name=(String) session.getAttribute("last_name"); 
    String email=(String) session.getAttribute("email"); 
    String password=(String) session.getAttribute("password");
    String color = (String) request.getAttribute("color");  
    String msg = (String) request.getAttribute("msg"); 
    int userid=(Integer) request.getAttribute("userid");
    String usertype = (String) request.getAttribute("usertype"); 
    
    Connection con = null;  
    Statement stmt = null;
    ResultSet rs = null;
    
    if(msg!=null && msg!="")
    {  
%> 

<script>
    var msg = " <%=msg %> ";
        if(msg!==""){
            alert(msg);
        }
</script>
         
<%
    }

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
        
<%          if(usertype.equals(admin)==true)
            { 
%>
        <title>Admin Dashboard</title>
<%          } 
            else if(usertype.equals(student)==true)
            {
%>
        <title>Student Dashboard</title>    
<%          } 
            else 
            {
%>  
        <title>Teacher Dashboard</title>       
<%          }
%>
        
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
            
            #dateTime {
            text-align: center;
            border: 2px solid black;
            height:25px; 
            background-color: antiquewhite;
        }
        </style>
        
        <link rel="stylesheet" 
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>  
        
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />  
        
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
        
        <script src="https://code.jquery.com/jquery-1.10.2.js" type="text/javascript"></script>      
    </head>
    
    <body style="background-color:<%=color%>;">
        <div id="dateTime"></div>
            <script>
                setInterval(showTime, 1000);
                
                function showTime() 
                {
                    let time = new Date();
                    let hour = time.getHours();
                    let min = time.getMinutes();
                    let sec = time.getSeconds();
                    am_pm = "AM";

                    if (hour > 12) {
                        hour -= 12;
                        am_pm = "PM";
                    }
                    if (hour == 0) {
                        hr = 12;
                        am_pm = "AM";
                    }
                    
                    hour = hour < 10 ? "0" + hour : hour;
                    min = min < 10 ? "0" + min : min;
                    sec = sec < 10 ? "0" + sec : sec;

                    let currentTime = hour + ":" 
                        + min + ":" + sec + am_pm;
                    var dateTime = time;
                    document.getElementById("dateTime").innerHTML = dateTime;
                }

                showTime();
            </script>
            
        <!-- Display profile picture -->
<%
        ResultSet image_rs = null;
        Blob image = null;
        byte[ ] imgData = null ;

        String user="";
        user=usertype;

        if(usertype.equals(teacher)==true)
        {
            user="teachers";
        }

        dbconnection dbimage = new dbconnection();
        String image_sql = "SELECT photo from "+user+" WHERE id="+userid;
        image_rs = dbimage.mysqldbconnection(image_sql, 0);

        if (image_rs.next()) 
        {
            image = image_rs.getBlob("photo");
        }

        if(image!=null)
        {
            imgData = image.getBytes(1,(int)image.length());
            InputStream inputStream = image.getBinaryStream();
            ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead = -1;

            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);                  
            }

            byte[] imageBytes = outputStream.toByteArray();
            String base64Image = Base64.getEncoder().encodeToString(imageBytes);              
%>
            
            <img src="data:image/jpg;base64,<%=base64Image%>" 
                style="clip-path: circle(); top:50px; left:50px; width:100px; 
                    height:100px; position: relative;"> 
            
<%      }
        else
        {
%>
            <i class="fa fa-solid fa-user fa-5x"
                style="clip-path: circle();">
            </i>
            
<%
        }
%>
        
        <table align="center" height="20px" width="100px">
            <tr>
<%
                if(usertype.equals(teacher)==true)
                {
%>
                
                    <form action="add-test.jsp" method="post">
                        <td style="border:none;">
                            <button class="btn" style="border: solid black; width:100px; height:50px; background-color: skyblue;">
                            Add A Test</button> 
                        </td>
                         <input type="hidden" name="usertype" value="<%=usertype%>">
                         <input type="hidden" name="userid" value="<%=userid%>">
                    </form>

                    <form action="test-response.jsp" method="post">
                        <td style="border:none;">
                            <button class="btn" style="border: solid black; width:100px; height:50px; background-color: skyblue;">
                            View Test Results</button> 
                        </td>
                         <input type="hidden" name="usertype" value="<%=usertype%>">
                         <input type="hidden" name="userid" value="<%=userid%>">
                    </form>
<%
                }

                if(usertype.equals(student)==true)
                {
                    String sql6="";
                    sql6="SELECT class, branch_id from student where id="+userid;
                    ResultSet class_branch=null;
                    class_branch = stmt.executeQuery(sql6);
                    int student_class=0;
                    int student_branch=0;

                    while(class_branch.next())
                    {
                        student_class = Integer.parseInt(class_branch.getString("class"));
                        student_branch = Integer.parseInt(class_branch.getString("branch_id"));
                    }  
%>
                    
                    <form action="tests.jsp" method="post">
                        <td style="border:none;">
                            <button class="btn" style="border: solid black; width:100px; height:50px; background-color: skyblue;">
                            Tests</button> 
                        </td>
                        <input type="hidden" name="student_class" value="<%=student_class%>">
                        <input type="hidden" name="student_branch" value="<%=student_branch%>">
                        <input type="hidden" name="usertype" value="<%=usertype%>">
                        <input type="hidden" name="userid" value="<%=userid%>">
                    </form>
                    
                    <form action="results.jsp" method="post">
                        <td style="border:none;">
                            <button class="btn" style="border: solid black; width:100px; height:50px; background-color: skyblue;">
                            Results</button> 
                        </td>
                        <input type="hidden" name="student_class" value="<%=student_class%>">
                        <input type="hidden" name="student_branch" value="<%=student_branch%>">
                        <input type="hidden" name="usertype" value="<%=usertype%>">
                        <input type="hidden" name="userid" value="<%=userid%>">
                    </form>
                    
<%
                }
%>
                
                <form action="email-form.jsp" method="post">
                    <td style="border:none;">
                        <button class="btn" style="border: solid black; width:100px; height:50px; background-color: skyblue;">
                            <i class="fa fa-envelope fa-2x"></i>
                        </button> 
                    </td>
                     <input type="hidden" name="usertype" value="<%=usertype%>">
                     <input type="hidden" name="userid" value="<%=userid%>">
                     <input type="hidden" name="email" value="<%=email%>">
                     <input type="hidden" name="password" value="<%=password%>">
                </form>
                
                <form action="settings.jsp" method="post">
                    <td style="border:none;">
                        <button class="btn" style="border: solid black; width:100px; height:50px; background-color: skyblue;">
                            <i class="fa fa-gear fa-2x"></i>
                        </button> 
                    </td>
                     <input type="hidden" name="usertype" value="<%=usertype%>">
                     <input type="hidden" name="userid" value="<%=userid%>">
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

<%  if(email!="")
    {         
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
    </form> 
    <br>
        
    <form action="search-record.jsp" method="post">
        Enter Email To Search A Teacher Record:&nbsp&nbsp&nbsp
        <input type="text" name="fetch">
        <input type="hidden" name="usertype" value="<%=usertype%>">
        <input type="hidden" name="userid" value="<%=userid%>">
        <input type="hidden" name="recordtype" value="teachers">
        <input type="submit" name="submit" value="Submit" style="background-color: #00cc00;">
    </form>
    <br>
        
    <form action="ExportToExcel" method="post">
        <input type="submit" name="submit" value="Export To Excel File"> 
        <input type="hidden" name="usertype" value="<%=usertype%>">
        <input type="hidden" name="userid" value="<%=userid%>">
        <input type="hidden" name="tablename" value="teachers">
    </form>
    <br>

    <form action="ImportFromExcel" method="post" enctype="multipart/form-data">
        <input type="file" name="importedfile" size="50" multiple/><br>
        <input type="hidden" name="usertype" value="<%=usertype%>">
        <input type="hidden" name="userid" value="<%=userid%>">
        <input type="hidden" name="tablename" value="teachers">
        <input type="submit" name="submit" value="Import From Excel File"> 
    </form>
            
    <table>
        <br><label><strong>TEACHER DETAILS</strong></label><br><br>
        <tr>
            <th>TEACHER ID</th>
            <th>TEACHER FIRST NAME</th>
            <th>TEACHER LAST NAME</th>
            <th>TEACHER EMAIL</th>
        
<%          while(class_rs.next())
            {
                year=class_rs.getInt("year");
                branch_id=class_rs.getInt("branch_id");
%>
        
            <th><%=branch_id+"_"+year %></th>
        
<%          } 
%>
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

    while(teacher_rs.next())
    {
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
                while(class_rs.next())
                { 
                    id=class_rs.getInt("id");
%>
                    <td> <input type="checkbox" class="get_value" name="chkteacher" value="<%=teacher_id %>" id="<%=id %>"></td>
<% 
                } 
%>  
        </tr>
                
<%
    }
%>

                <button id="submit" name="submit">Submit</button>
                <h4 id="result"></h4>
            </form>
        
            <script>
                    $(document).ready(function(){  
                        $('#submit').click(function(){  
                            var classes_id = [];
                            var teacher_id = [];
                            $('.get_value').each(function(){  
                                if($(this).is(":checked"))  
                                {  
                                    teacher_id.push($(this).val());
                                    classes_id.push($(this).attr("id"));
                                }  
                            }); 
                            classes_id = classes_id.toString();
                            teacher_id = teacher_id.toString();
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
    </table>

<%             
    ResultSet student_rs=null;
    String sql4="SELECT * FROM student;";
    student_rs = stmt.executeQuery(sql4);
%>
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
    
    <form action="ExportToExcel" method="post">
        <input type="submit" name="submit" value="Export To Excel File"> 
        <input type="hidden" name="usertype" value="<%=usertype%>">
        <input type="hidden" name="userid" value="<%=userid%>">
        <input type="hidden" name="tablename" value="student">
    </form><br>
        
    <form action="ImportFromExcel" method="post" enctype="multipart/form-data">
        <input type="file" name="importedfile" size="50" multiple/><br>
        <input type="submit" name="submit" value="Import From Excel File"> 
        <input type="hidden" name="usertype" value="<%=usertype%>">
        <input type="hidden" name="userid" value="<%=userid%>">
        <input type="hidden" name="tablename" value="student">
    </form>
        
    <label><strong>STUDENT DETAILS</strong></label><br><br>
    <table>
        <tr>
            <th>STUDENT ID</th>
            <th>STUDENT FIRST NAME</th>
            <th>STUDENT LAST NAME</th>
            <th>STUDENT EMAIL</th>
            <th>CLASS</th>
            <th>BRANCH ID</th>
        </tr>
<%
        int student_id=0;
        String student_first_name=null;
        String student_last_name=null;
        String student_email=null;
        int student_class=0;
        int student_branch_id=0;

        while(student_rs.next())
        {
            student_id=student_rs.getInt("id");
            student_first_name=student_rs.getString("first_name");
            student_last_name=student_rs.getString("last_name");
            student_email=student_rs.getString("email"); 
            student_class=Integer.parseInt(student_rs.getString("class"));
            student_branch_id=Integer.parseInt(student_rs.getString("branch_id"));;
%>
        <tr>
            <td> <%= student_id %> </td>
            <td> <%= student_first_name %> </td>
            <td> <%= student_last_name %> </td>
            <td> <%= student_email %> </td>
            <td> <%= student_class %> </td>
            <td> <%= student_branch_id %> </td>
        </tr>
<% 
        }
    }

    else if(usertype.equals(student)==true){
        int stu_class=(Integer) session.getAttribute("class");
        int stu_branch_id=0;

        ResultSet stu=null;
        String sql5="SELECT * FROM student where id="+userid;
        stu = stmt.executeQuery(sql5);   

        while(stu.next())
        {
            first_name=stu.getString("first_name");
            last_name=stu.getString("last_name");
            email=stu.getString("email"); 
            stu_class=Integer.parseInt(stu.getString("class"));
            stu_branch_id=Integer.parseInt(stu.getString("branch_id"));
        }

        if(email!="")
        {
%>
        
        <label><h1>Hello, <%=first_name+" "+last_name %>!</h1></label><br><hr>
        <h3>
            <label>STUDENT DETAILS</label><br><br><p><br>                
            <label>ID:<%=userid%></label><br>
            <label>First Name: <%=first_name%></label><br>
            <label>Last Name: <%=last_name%></label><br>
            <label>Email: <%=email%></label><br>
            <label>Class: <%=stu_class%></label><br>
            <label>Branch: <%=stu_branch_id%></label><br><br>
        </h3>
        
<%
        }  
%>
            
        <form action="edit-record.jsp" method="post">
            Enter Email To Update Your Details:&nbsp&nbsp&nbsp
            <input type="text" name="fetch">
            <input type="hidden" name="usertype" value="<%=usertype%>">
            <input type="hidden" name="userid" value="<%=userid%>">
            <input type="hidden" name="recordtype" value="student">
            <input type="submit" name="submit" value="Submit">
        </form>
                    
<%
    }
        
    else if(usertype.equals(teacher)==true){
        ResultSet teach=null;
        String sql6="SELECT * FROM teachers where id="+userid;
        teach = stmt.executeQuery(sql6);
        String teacher_class="";
        //int student_class=0;
        while(teach.next())
        {
            //teacher_class=teach.getString("classes");

            first_name=teach.getString("first_name");
            last_name=teach.getString("last_name");
            email=teach.getString("email");
        }

        if(email!=""){
            
%>
        <h1><label>Hello, <%=first_name+" "+last_name %>!</label><br></h1><hr>
        <h3><br><br>
            <label>TEACHER DETAILS</label><br><br><p><br>
            <label>ID:<%=userid%></label><br><br      
            <label>First Name:<%=first_name%></label><br><br>
            <label>Last Name:<%=last_name%></label><br><br>
            <label>Email:<%=email%></label>
        </h3>
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
            <input type="submit" name="submit" value="Submit">
        </form>
<%        
    }
    else
    {
%>
        <h3>Not a valid user!</h3>
<%
    }
%>
        </center>
    </body>      
</html>