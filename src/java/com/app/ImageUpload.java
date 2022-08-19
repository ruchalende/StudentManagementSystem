/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.app;

import java.io.IOException;
import java.io.InputStream;
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
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
 
@MultipartConfig(maxFileSize = 16177215) 
/**
 *
 * @author rucha
 */
public class ImageUpload extends HttpServlet {

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
        
        String usertype = request.getParameter("usertype");
        int userid = Integer.parseInt (request.getParameter("userid"));
        Part filePart = request.getPart("photo");

        InputStream inputStream = null;
        if (filePart != null) 
        {
            inputStream = filePart.getInputStream();
        }
        String msg="";
        Connection con = null;  
        Statement stmt = null;
        ResultSet rs = null;
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            con =DriverManager.getConnection     
            ("jdbc:mysql://127.0.0.1:3306/ruchalende_studentmanangement","root",""); 

            String user="";
            if(usertype.equals("teacher")==true);
                user="teachers";

            String sql="UPDATE "+user+" SET photo = (?) WHERE id="+userid+";";
            PreparedStatement statement = con.prepareStatement(sql);
            if (inputStream != null) 
            {
                statement.setBlob(1, inputStream);
            }
            statement.executeUpdate();
            msg="Profile Photo Uploaded!";
        } 
        catch (SQLException ex) 
        {
            msg = "ERROR: " + ex.getMessage();
            ex.printStackTrace();
        } 
        finally 
        {
            if (con != null) 
            {
                // closes the database connection
                try 
                {
                    con.close();
                } 
                catch (SQLException ex) 
                {
                    ex.printStackTrace();
                }
            }
            request.setAttribute("msg", msg);
            request.setAttribute("userid", userid);
            request.setAttribute("usertype", usertype);
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
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
        } catch (SQLException ex) {
            Logger.getLogger(ImageUpload.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ImageUpload.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ImageUpload.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ImageUpload.class.getName()).log(Level.SEVERE, null, ex);
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
