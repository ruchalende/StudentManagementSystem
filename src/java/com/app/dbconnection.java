package com.app;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author rucha
 */
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
public class dbconnection {
    
    public ResultSet mysqldbconnection(String sql, int choice) throws ClassNotFoundException, SQLException{
        Connection con = null;  
        Statement stmt = null;
        ResultSet rs = null;
        ResultSet r = null;
        Class.forName("com.mysql.jdbc.Driver");
        con =DriverManager.getConnection     
        ("jdbc:mysql://127.0.0.1:3306/ruchalende_studentmanangement","root",""); 
        stmt = con.createStatement();
        switch(choice){
            case 0:{
                rs=stmt.executeQuery(sql);
            }
                break;
                
            case 1:{
                stmt.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
                rs = stmt.getGeneratedKeys();
            }
                break;
                
            default:
                out.print("wrong choice!");
        }
        return rs;
    }
}
