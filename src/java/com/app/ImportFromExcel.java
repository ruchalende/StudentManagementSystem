/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.app;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.*;
import static java.lang.Integer.parseInt;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.sql.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.Part;
 
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.*;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2,   // 2MB
                maxFileSize = 1024 * 1024 * 10,         // 10MB
                maxRequestSize = 1024 * 1024 * 50)      // 50MB

public class ImportFromExcel extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, ClassNotFoundException {
        response.setContentType("text/html;charset=UTF-8");
        
        int userid = Integer.parseInt (request.getParameter("userid"));
        String usertype =request.getParameter("usertype");
        String tableName=request.getParameter("tablename");
        String message="";
         
        try 
        {
            Part filePart = request.getPart("importedfile");
            String fileName = filePart.getSubmittedFileName();

            String filePath = getServletContext().getInitParameter("file-upload").concat(fileName);

            InputStream is = filePart.getInputStream();

            Files.copy(is, Paths.get(filePath),
                    StandardCopyOption.REPLACE_EXISTING);

            String jdbcURL = "jdbc:mysql://127.0.0.1:3306/ruchalende_studentmanangement";
            String username = "root";
            String password = "";
            
            int batchSize = 20;
            Connection connection = null;
            connection = DriverManager.getConnection(jdbcURL, username, password);
            connection.setAutoCommit(false);
            long start = System.currentTimeMillis();
            String sql="";
            if(tableName.equals("teachers"))
            {
                sql = "INSERT INTO teachers (id, first_name, last_name, email, password) VALUES (?, ?, ?, ?, ?);";
            }
            else if(tableName.equals("student"))
            {
                sql = "INSERT INTO student (id, first_name, last_name, email, password, class, branch_id) VALUES (?, ?, ?, ?, ?, ?, ?);";
            }

            PreparedStatement statement = connection.prepareStatement(sql);   

            BufferedReader lineReader=new BufferedReader(new FileReader(filePath));

            String lineText=null;
            int count=0;

            lineReader.readLine();
            
            while ((lineText=lineReader.readLine())!=null)
            {
                String[] data=lineText.split(",");

                String id=data[0];
                String first_name=data[1];
                String last_name=data[2];
                String email=data[3];
                String pass=data[4];
                if(tableName.equals("student"))
                {
                    String stu_class=data[5];
                    String branch_id=data[6];
                    statement.setInt(6, parseInt(stu_class));
                    statement.setInt(7, parseInt(branch_id));
                }
                statement.setInt(1,parseInt(id));
                statement.setString(2,first_name);
                statement.setString(3,last_name);
                statement.setString(4, email);
                statement.setString(5, pass);

                statement.addBatch();

                if(count%batchSize==0){
                    statement.executeBatch();
                }
            }
            lineReader.close();
            statement.executeBatch();

            connection.commit();
            connection.close();

            long end = System.currentTimeMillis();
            message="Import done in "+(end - start)+"  ms.";

        } 
        catch(Exception e)
        {
           e.printStackTrace();
           message = "There was an error: " + e.getMessage();
        }
        finally
        {
           request.setAttribute("msg", message);
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
            Logger.getLogger(ImportFromExcel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ImportFromExcel.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ImportFromExcel.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ImportFromExcel.class.getName()).log(Level.SEVERE, null, ex);
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
