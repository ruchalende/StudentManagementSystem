/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.app;

import java.io.*;
import java.sql.*;
import java.text.*;
import java.util.Date;
 
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
//import org.apache.commons.io.output;
  

public class ExportToExcelMethods {
     
    private String getFileName(String baseName) 
    {
        DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd_HH-mm-ss");
        String dateTimeInfo = dateFormat.format(new Date());
        return baseName.concat(String.format("_%s.xlsx", dateTimeInfo));
    }
 
    public void export(String table) 
    {
        String jdbcURL = "jdbc:mysql://127.0.0.1:3306/ruchalende_studentmanangement";
        String username = "root";
        String password = "";
 
        String excelFileName = getFileName(table.concat("_Export"));
        String excelFilePath = "C:\\Users\\rucha\\Downloads\\".concat(excelFileName);
 
        try (Connection connection = DriverManager.getConnection(jdbcURL, username, password)) 
        {
            String sql = "SELECT * FROM ".concat(table);
 
            Statement statement = connection.createStatement();
 
            ResultSet result = statement.executeQuery(sql);
 
            XSSFWorkbook workbook = new XSSFWorkbook();
            XSSFSheet sheet = workbook.createSheet(table);
 
            writeHeaderLine(result, sheet);
 
            writeDataLines(result, workbook, sheet);
 
            FileOutputStream outputStream = new FileOutputStream(excelFilePath);
            workbook.write(outputStream);
            workbook.close();
 
            statement.close();
 
        } 
        catch (SQLException e) 
        {
            System.out.println("Database error:");
            e.printStackTrace();
        } 
        catch (IOException e) 
        {
            System.out.println("File IO error:");
            e.printStackTrace();
        }
    }
 
    private void writeHeaderLine(ResultSet result, XSSFSheet sheet) throws SQLException 
    {
        // writes header line containing column names
        ResultSetMetaData metaData = result.getMetaData();
        int numberOfColumns = metaData.getColumnCount();
 
        Row headerRow = sheet.createRow(0);
 
        // exclude the first column which is the ID field
        for (int i = 1; i <= numberOfColumns; i++) 
        {
            String columnName = metaData.getColumnName(i);
            Cell headerCell = headerRow.createCell(i-1);
            headerCell.setCellValue(columnName);
        }
    }
 
    private void writeDataLines(ResultSet result, XSSFWorkbook workbook, XSSFSheet sheet)
            throws SQLException
    {
        ResultSetMetaData metaData = result.getMetaData();
        int numberOfColumns = metaData.getColumnCount();
 
        int rowCount = 1;
 
        while (result.next()) 
        {
            Row row = sheet.createRow(rowCount++);
 
            for (int i = 1; i <= numberOfColumns; i++) {
                Object valueObject = result.getObject(i);
 
                Cell cell = row.createCell(i - 1);
 
                if (valueObject instanceof Boolean)
                    cell.setCellValue((Boolean) valueObject);
                else if (valueObject instanceof Integer)
                    cell.setCellValue((int) valueObject);
                else if (valueObject instanceof Double)
                    cell.setCellValue((double) valueObject);
                else if (valueObject instanceof Float)
                    cell.setCellValue((float) valueObject);
                else if (valueObject instanceof Date) {
                    cell.setCellValue((Date) valueObject);
                    formatDateCell(workbook, cell);
                } else cell.setCellValue((String) valueObject);
            }
        }
    }
 
    private void formatDateCell(XSSFWorkbook workbook, Cell cell) 
    {
        CellStyle cellStyle = workbook.createCellStyle();
        CreationHelper creationHelper = workbook.getCreationHelper();
        cellStyle.setDataFormat(creationHelper.createDataFormat().getFormat("yyyy-MM-dd HH:mm:ss"));
        cell.setCellStyle(cellStyle);
    }
}
