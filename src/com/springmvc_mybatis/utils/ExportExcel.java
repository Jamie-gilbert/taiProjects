package com.springmvc_mybatis.utils;


import com.springmvc_mybatis.bean.ExtportBean;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Date;
import java.util.List;

public class ExportExcel {
    public void exportExcel(String[] headers, List<ExtportBean> dataset,String fileName, HttpServletResponse response) throws IOException {
        // 声明一个工作薄
        SXSSFWorkbook wb = new SXSSFWorkbook(-1);
        // 生成一个表格
        Sheet sh = wb.createSheet();

        for (int rownum = 0; rownum < dataset.size(); rownum++) {
            Row row = sh.createRow(rownum);
            for (int cellnum = 0; cellnum < headers.length; cellnum++) {
                Cell cell = row.createCell(cellnum);

                switch (cellnum) {
                    case 0:
                        cell.setCellValue(dataset.get(rownum).getXh());
                        break;
                    case 1:
                        cell.setCellValue(dataset.get(rownum).getXm());
                        break;
                    case 2:
                        cell.setCellValue(dataset.get(rownum).getQsny());
                        break;
                    case 3:
                        cell.setCellValue(dataset.get(rownum).getZzny());
                        break;
                    case 4:
                        cell.setCellValue(dataset.get(rownum).getGrjfe());
                        break;
                    case 5:
                        cell.setCellValue(dataset.get(rownum).getLx());
                        break;

                }
            }

            // manually control how rows are flushed to disk
            if (rownum % 100 == 0) {
                ((SXSSFSheet) sh).flushRows(100); // retain 100 last rows and flush all others

                // ((SXSSFSheet)sh).flushRows() is a shortcut for ((SXSSFSheet)sh).flushRows(0),
                // this method flushes all rows
            }

        }

//        fileName = fileName + ".xlsx";
//        response.setContentType("multipart/form-data");
//        response.setHeader("Content-Disposition", "attachment;filename=" + new String(fileName.getBytes("utf-8"), "utf-8"));
//        BufferedOutputStream fos = new BufferedOutputStream(response.getOutputStream());
//        wb.write(fos);
//        fos.flush();
//        fos.close();
        Date date = new Date();
        File file = new File("../" + File.separator + date.getTime() + fileName );
        if (!file.exists()) {
            file.createNewFile();
        }
        FileOutputStream out = new FileOutputStream(file);

        wb.write(out);
        wb.dispose();
        wb.close();
        out.close();
//        fos.flush();
//        fos.close();
        response.setContentType("multipart/form-data");
//        response.setContentType("application/octet-stream;charset=UTF-8");
        response.setHeader("Content-Length", String.valueOf(file.length()));
        response.addHeader("Content-Disposition", "attachment;filename="+fileName);
        ServletOutputStream outputStream = response.getOutputStream();
        FileInputStream fileInputStream = new FileInputStream(file);

        byte[] buffer = new byte[1024 * 1024];
        int len = 0;
        while ((len = fileInputStream.read(buffer)) != -1) {

            outputStream.write(buffer, 0, len);
        }
        outputStream.flush();
        out.close();
        fileInputStream.close();
       file.delete();


    }


//    /**
//     * 方法说明: 指定路径下生成EXCEL文件
//     *
//     * @return
//     */
//    public void getExportedFile(XSSFWorkbook workbook, String name, HttpServletResponse response) throws Exception {
//        BufferedOutputStream fos = null;
//        try {
//            String fileName = name + ".xlsx";
//            response.setContentType("application/x-msdownload");
//            response.setHeader("Content-Disposition", "attachment;filename=" + new String(fileName.getBytes("gb2312"), "ISO8859-1"));
//            fos = new BufferedOutputStream(response.getOutputStream());
//            workbook.write(fos);
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (fos != null) {
//                fos.close();
//            }
//        }
//    }

}

