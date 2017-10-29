package com.springmvc_mybatis.controller;

import com.springmvc_mybatis.bean.DepartmentBill;
import com.springmvc_mybatis.json.JSONObject;
import com.springmvc_mybatis.mapper.DepartmentBillMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("/departmentBills")
public class DepartmentBillController {

    @Autowired
    private DepartmentBillMapper departmentBillMapper;


    @RequestMapping("/querydepartmentbils")
    public void queryDepartmentBils(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        String dwid = request.getParameter("dwid");
        String page = request.getParameter("page");
        String count = request.getParameter("count");
        String type = request.getParameter("type");
        String time = request.getParameter("time");

        int pageNum = Integer.parseInt(page);
        int countNum = Integer.parseInt(count);
        String pre = String.valueOf(1 + (pageNum - 1) * countNum);
        String next = String.valueOf(pageNum * countNum);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        try {
            if (time != null && !"".equals(time)) {
                date = simpleDateFormat.parse(time);
            }else {
                date=simpleDateFormat.parse("1800-12-12");

            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<DepartmentBill> departmentBills = departmentBillMapper.queryBills(dwid, date, type, pre, next);
        PrintWriter out = null;
        out = response.getWriter();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errorCode", "0");
        jsonObject.put("errorText", "");
        jsonObject.put("data",departmentBills);
        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }
}
