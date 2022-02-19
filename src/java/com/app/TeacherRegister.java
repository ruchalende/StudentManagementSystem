/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.app;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author rucha
 */
public class TeacherRegister extends HttpServlet {

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
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Connection con = null;  
        Statement stmt = null;
        ResultSet rs = null;
        try {
            /* TODO output your page here. You may use following sample code. */
            String first_name=request.getParameter("fn");
            String last_name=request.getParameter("ln");
            String email=request.getParameter("e");
            String password=request.getParameter("p");
            Class.forName("com.mysql.jdbc.Driver");
            con =DriverManager.getConnection     
            ("jdbc:mysql://127.0.0.1:3306/ruchalende_studentmanangement","root",""); 
            stmt = con.createStatement();
            String check_email="SELECT * from teachers where email='"+email+"'";
            rs=stmt.executeQuery(check_email);
            String dbmail="";
            int count=0;
            while(rs.next())
            {

            count++;
            }

            if(count>0)
            {
            out.println("<script type=\"text/javascript\">"); 
            out.println("alert('Email already exists!');"); 
            out.println("location='admin-register.html';"); 
            out.println("</script>");
            //response.sendRedirect("admin-register.html"); 
            }
            else{
            String sql="INSERT INTO teachers (first_name, last_name, email, password) VALUES('"+first_name+"','"+last_name+"','"+email+"','"+password+"');";   
            stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
            rs = stmt.getGeneratedKeys();
            int userid=1;
            if (rs.next()) {
                userid = rs.getInt(1);
            }
            //response.sendRedirect("dashboard.jsp?userid="+userid+"&usertype=teacher");
            HttpSession session=request.getSession();  
            session.setAttribute("first_name",first_name); 
            session.setAttribute("last_name",last_name); 
            session.setAttribute("email",email);
            request.setAttribute("userid", userid);
            request.setAttribute("usertype", "teacher");
            request.getRequestDispatcher("teacher-login.html").forward(request, response);
            }
        }catch (SQLException e) {
                throw new ServletException("Servlet Could not display records.", e);
            }
        catch (ClassNotFoundException e) {
  throw new ServletException("JDBC Driver not found.", e);
  }
        finally {
  try {
  if(rs != null) {
  rs.close();
  }
  if(stmt != null) {
  stmt.close();
  }
  if(con != null) {
  con.close();
  }
  } catch (SQLException e) {}
  }
  out.close();
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
        processRequest(request, response);
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
        processRequest(request, response);
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
