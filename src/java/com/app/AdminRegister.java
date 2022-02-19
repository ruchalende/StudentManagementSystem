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
public class AdminRegister extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Connection con = null;  
        Statement stmt = null;
        ResultSet rs = null;
        ResultSet r = null;
        try {
            /* TODO output your page here. You may use following sample code. */
            String first_name=request.getParameter("fn");
            String last_name=request.getParameter("ln");
            String email=request.getParameter("e");
            String password=request.getParameter("p");
            //String admin="admin";
            /*Class.forName("com.mysql.jdbc.Driver");
            con =DriverManager.getConnection     
            ("jdbc:mysql://127.0.0.1:3306/ruchalende_studentmanangement","root",""); 
            stmt = con.createStatement();   
            
            rs=stmt.executeQuery(check_email);  */
            String check_email="SELECT * from admin where email='"+email+"'";
            dbconnection db=new dbconnection();
            rs=db.mysqldbconnection(check_email, 0);
            
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
            String sql="INSERT INTO admin (first_name, last_name, email, password) VALUES('"+first_name+"','"+last_name+"','"+email+"','"+password+"');";      
            /*stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
            rs = stmt.getGeneratedKeys();  */
            //rs=new dbconnection(sql, "update");
            dbconnection db2=new dbconnection();
            r=db2.mysqldbconnection(sql, 1);
            int userid=1;
            if (r.next()) {
                userid = r.getInt(1);
            }
            HttpSession session=request.getSession(); 
            session.setAttribute("first_name",first_name); 
            session.setAttribute("last_name",last_name); 
            session.setAttribute("email",email);
            request.setAttribute("userid", userid);
            request.setAttribute("usertype", "admin");
            request.getRequestDispatcher("admin-login.html").forward(request, response);
            //response.sendRedirect("dashboard.jsp?userid="+userid+"&usertype=admin");
            }
        }catch (SQLException e) {
                throw new ServletException("Servlet Could not display records.", e);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(AdminRegister.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AdminRegister.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(AdminRegister.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(AdminRegister.class.getName()).log(Level.SEVERE, null, ex);
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
