package com.app;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author rucha
 */
public class ResultCalculation extends HttpServlet {

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
        
        String usertype = request.getParameter("usertype");
        String msg = request.getParameter("msg");
        int userid = Integer.parseInt (request.getParameter("userid"));
        
        int test_id = Integer.parseInt (request.getParameter("test_id"));
        String subject = request.getParameter("subject");
        int year = Integer.parseInt (request.getParameter("year"));
        String student_branch = request.getParameter("branch_name");
        String test_date = request.getParameter("test_date");
        String start_time = request.getParameter("start_time");
        
        try
        {
            int totalMarksObtained=0;
            int totalMarks=0;
            String questions="";
            questions="SELECT * FROM "+subject;
            ResultSet questions_rs = null;
            dbconnection db = new dbconnection();
            questions_rs = db.mysqldbconnection(questions, 0);

            int question_no=0;
            String answer="";
            int marks=0;
            
            while(questions_rs.next())
            {
                question_no=questions_rs.getInt("question_no");
                answer=questions_rs.getString("answer");
                marks=questions_rs.getInt("marks");

                totalMarks+=marks;

                String student_answer=request.getParameter(question_no+"_options");
                
                if(student_answer.equals(answer))
                {
                    totalMarksObtained+=marks;
                }
            }
            int score=totalMarksObtained;
            String sql="INSERT INTO "+subject+"_responses (student_id, score, totalmarks) VALUES ("+userid+", "+score+", "+totalMarks+");";

            ResultSet studentTestResults = null;
            dbconnection studentTestResultsInsertion = new dbconnection();
            studentTestResults = studentTestResultsInsertion.mysqldbconnection(sql, 1);
        }
        catch(Exception ex)
        {
            ex.printStackTrace();
            msg = "There were an error: " + ex.getMessage();
        }
        
        HttpSession session=request.getSession();  
        session.setAttribute("class",year);
        request.setAttribute("msg", msg);
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
            Logger.getLogger(ResultCalculation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ResultCalculation.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ResultCalculation.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ResultCalculation.class.getName()).log(Level.SEVERE, null, ex);
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
