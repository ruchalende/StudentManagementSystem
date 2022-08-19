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
public class AdminLogin extends HttpServlet {

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
        
        String email=request.getParameter("email");  
        String password=request.getParameter("password"); 
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            con =DriverManager.getConnection     
            ("jdbc:mysql://127.0.0.1:3306/ruchalende_studentmanangement","root",""); 
            stmt = con.createStatement();

            String mail="SELECT * from admin where email='"+email+"';";
            rs = stmt.executeQuery(mail);
            
            String dbmail=null;
            String dbpassword=null;
            String first_name=null;
            String last_name=null;
            int userid=0;
            
            while(rs.next())
            {
                first_name=rs.getString("first_name");
                last_name=rs.getString("last_name");
                dbmail=rs.getString("email");
                dbpassword=rs.getString("password");
                userid = rs.getInt("id");
            }
            
            if((email.equals(dbmail)) && (password.equals(dbpassword)))
            {  
                HttpSession session=request.getSession();  
                session.setAttribute("first_name",first_name); 
                session.setAttribute("last_name",last_name); 
                session.setAttribute("email",email);
                session.setAttribute("password",password); 
                //response.sendRedirect("dashboard.jsp?userid="+userid+"&usertype=admin");
                request.setAttribute("userid", userid);
                request.setAttribute("usertype", "admin");
                request.getRequestDispatcher("dashboard.jsp").forward(request, response);
            }  
            else
            {
                response.sendRedirect("admin-login.html?loggedin=0");
            }
        }
        catch (SQLException e) 
        {
            throw new ServletException("Servlet Could not display records.", e);
        }
        catch (ClassNotFoundException e) 
        {
            throw new ServletException("JDBC Driver not found.", e);
        }
        finally 
        {
            try 
            {
                if(rs != null) 
                {
                    rs.close();
                }
                if(stmt != null) 
                {
                    stmt.close();
                }
                if(con != null) 
                {
                    con.close();
                }
            } 
            catch (SQLException e) 
            {
            }
        }
        out.close();
    }
   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
    
}

