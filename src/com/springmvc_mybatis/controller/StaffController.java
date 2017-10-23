package com.springmvc_mybatis.controller;

import com.springmvc_mybatis.bean.Staff;
import com.springmvc_mybatis.json.JSONObject;
import com.springmvc_mybatis.mapper.StaffMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.List;

@Controller
@RequestMapping("/staff")
public class StaffController {
    @Autowired
    private StaffMapper staffMapper;

    @RequestMapping("/queryStaff")
    public void queryStaff(HttpServletRequest request, HttpServletResponse response) throws Exception {

        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        String dwid = request.getParameter("dwid");
        String page = request.getParameter("page");
        String count = request.getParameter("count");
        String type = request.getParameter("type");
        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
        String pre = String.valueOf(1 + (pageNum - 1) * countNum);
        String next = String.valueOf(pageNum * countNum);
        List<Staff> staffList = staffMapper.queryStaff(dwid, type, pre, next);

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errorCode", "0");
        jsonObject.put("errorText", "");
        jsonObject.put("data", staffList);
        PrintWriter out = response.getWriter();
        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }
}
