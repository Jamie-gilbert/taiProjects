package com.springmvc_mybatis.controller;

import com.springmvc_mybatis.bean.Department;
import com.springmvc_mybatis.json.JSONObject;
import com.springmvc_mybatis.mapper.DepartmentBillMapper;
import com.springmvc_mybatis.mapper.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;


@Controller
@RequestMapping("/department")
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
        try {

        } catch (Exception e) {
            if (e instanceof ClassCastException) {

            } else {
                throw e;
            }
        }
        PrintWriter out = null;
        out = response.getWriter();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errorCode", "0");
        jsonObject.put("errorText", "");
        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }
}
