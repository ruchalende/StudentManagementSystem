/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.app;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
public class UpdateRecord extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        Connection con=null;
        Class.forName("com.mysql.jdbc.Driver");
        con=DriverManager.getConnection
        ("jdbc:mysql://127.0.0.1:3306/ruchalende_studentmanangement","root","");
        HttpSession session = request.getSession();
        String id=request.getParameter("id");
        String first_name =request.getParameter("first name");
        String last_name =request.getParameter("last name");
        String email =request.getParameter("email");
        String stu_class =request.getParameter("class");
        int userid = Integer.parseInt(request.getParameter("userid"));
        String usertype =request.getParameter("usertype");
        String recordtype =request.getParameter("recordtype");
            Statement stmt = null;
        ResultSet rs = null;
        PreparedStatement ps=null;
                stmt=con.createStatement();
          if(!con.isClosed())
           {
                if(recordtype.equals("teachers")){
                    ps=con.prepareStatement
                    ("update "+recordtype+ " set first_name=?,last_name=?,email=? where id=?");
                    ps.setString(1,first_name);
                    ps.setString(2,last_name);
                    ps.setString(3,email);
                    ps.setString(4,id);
                    int a = ps.executeUpdate();
                    String msg="";
                    
                    if(a>0)
                    {
                        msg="Record Updated!";
                        request.setAttribute("userid", userid);
                        request.setAttribute("usertype", usertype);
                    }
                    else
                        {
                             msg="Something Went Wrong!";
                        }
                        
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
               }
               
                if(recordtype.equals("student")){
                    ps=con.prepareStatement
                    ("update "+recordtype+ " set first_name=?,last_name=?,email=?, class=? where id=?");
                    ps.setString(1,first_name);
                    ps.setString(2,last_name);
                    ps.setString(3,email);
                    ps.setString(4, stu_class);
                    ps.setString(5,id);
                    int a = ps.executeUpdate();
                    String msg="";
                    
                    if(a>0)
                    {
                        msg="Record Updated!";
                        request.setAttribute("userid", userid);
                        request.setAttribute("usertype", usertype);
                    }
                    else
                        {
                             msg="Something Went Wrong!";
                        }
                        
                        request.setAttribute("msg", msg);
                        request.getRequestDispatcher("dashboard.jsp").forward(request, response);
                }
                    
           
            }
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
            Logger.getLogger(UpdateRecord.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateRecord.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(UpdateRecord.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(UpdateRecord.class.getName()).log(Level.SEVERE, null, ex);
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
