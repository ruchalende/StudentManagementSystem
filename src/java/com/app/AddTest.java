/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.app;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import static java.lang.Integer.parseInt;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,   // 2MB
                maxFileSize = 1024 * 1024 * 10,         // 10MB
                maxRequestSize = 1024 * 1024 * 50)      // 50MB
/**
 *
 * @author rucha
 */
public class AddTest extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        
        String message="";
        String usertype = request.getParameter("usertype");
        int userid = Integer.parseInt (request.getParameter("userid"));
        
        try
        {
            String test_id = request.getParameter("test_id");
            String subject = request.getParameter("subject");
            String date = request.getParameter("date");
            String start_time = request.getParameter("start_time");
            String end_time = request.getParameter("end_time");
            String branch = request.getParameter("branch");
            String year = request.getParameter("year");
            
            Part filePart = request.getPart("testquestions");
            String fileName = filePart.getSubmittedFileName();
            //String filePath = getServletContext().getRealPath(File.separator+fileName);
            // to create table to insert mcq question and answer from uploaded file to newly 
            // created database table 
            
            //table columns: question_no, question, option_a, option_b, option_c, option_d, answer
            
            String filePath = getServletContext().getInitParameter("file-upload").concat(fileName);
          
            InputStream is = filePart.getInputStream();

            Files.copy(is, Paths.get(filePath),
                    StandardCopyOption.REPLACE_EXISTING);

            
            String createTable = "CREATE TABLE "+subject+
                " (question_no int, question varchar(500), a varchar(100), "+
                "b varchar(100), c varchar(100), d varchar(100), "+
                "answer varchar(100), marks int, primary key(question_no));";
            
            String createTestResponsesTable = "CREATE TABLE "+subject+
                "_responses (student_id int, score int, totalmarks int, primary key(student_id));";
            
            ResultSet testresponses = null;
            dbconnection testresponsesdbtable = new dbconnection();
            testresponses = testresponsesdbtable.mysqldbconnection(createTestResponsesTable, 1);
            
            int batchSize = 50;
            ResultSet questionsTable = null;
            Connection con = null;
            String jdbcURL = "jdbc:mysql://127.0.0.1:3306/ruchalende_studentmanangement";
            String username = "root";
            String password = "";
            con = DriverManager.getConnection(jdbcURL, username, password);
            con.setAutoCommit(false);
            
            dbconnection questions = new dbconnection();
            questionsTable = questions.mysqldbconnection(createTable, 1);
            
            String insertQuestions = "insert into "+subject+" VALUES (?,?,?,?,?,?,?,?);";
            PreparedStatement ps = con.prepareStatement(insertQuestions);
           
            BufferedReader lineReader=new BufferedReader(new FileReader(filePath));
            String lineText=null;
            int count=0;

            lineReader.readLine();
            while ((lineText=lineReader.readLine())!=null)
            {
                String[] data=lineText.split(",");

                String question_no=data[0];
                String question=data[1];
                String a=data[2];
                String b=data[3];
                String c=data[4];
                String d=data[5];
                String answer=data[6];
                String marks=data[7];

                ps.setInt(1,parseInt(question_no));
                ps.setString(2,question);
                ps.setString(3,a);
                ps.setString(4, b);
                ps.setString(5, c);
                ps.setString(6, d);
                ps.setString(7, answer);
                ps.setInt(8, parseInt(marks));
                ps.addBatch();

                if(count%batchSize==0){
                    ps.executeBatch();
                }
            }
            lineReader.close();
            ps.executeBatch();
  
            con.commit();
            con.close();       
            
            // to add test in tests table 
            
            ResultSet add_test_rs=null;
            String sql = "INSERT INTO tests (id, subject, test_date, start_time,end_time, branch, class, teacher_id) "
                    + "VALUES ("+test_id+", '"+subject+"', '"+date+"', '"+start_time+"', '"+end_time+"', "
                    +branch+", "+year+", "+userid+");";
            dbconnection db = new dbconnection();
            add_test_rs = db.mysqldbconnection(sql, 1);
            message="Test added successfully!";
        } catch(Exception e)
        {
            e.printStackTrace();
            message = "There were an error: " + e.getMessage();
        }

        
        request.setAttribute("msg", message);
        request.setAttribute("userid", userid);
        request.setAttribute("usertype", usertype);
        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
}

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddTest.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AddTest.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AddTest.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(AddTest.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
