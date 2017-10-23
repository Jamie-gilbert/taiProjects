package com.springmvc_mybatis.controller;

import com.springmvc_mybatis.bean.Department;
import com.springmvc_mybatis.json.JSONObject;
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
public class DepartmentController {

    @Autowired
    private DepartmentMapper departmentMapper;

    @RequestMapping("/querybykey")
    public void queryByKey(HttpServletRequest request, HttpServletResponse response) throws Exception {

        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String dwbh = request.getParameter("dwbh");
        String dwmc = request.getParameter("dwmc");
        String dwmcpy = "";
        if (dwmc != null) {
            if (isEnglish(dwmc)) {
                dwmcpy = dwmc;
            }
        } else {
            dwmc = "";
        }
        if (dwbh == null) {
            dwbh = "";
        }
        String page = request.getParameter("page");
        String count = request.getParameter("count");
        int pageNum = Integer.parseInt(page);
        int countNum = Integer.parseInt(count);
        String pre = String.valueOf(1 + (pageNum - 1) * countNum);
        String next = String.valueOf(pageNum * countNum);
        List<Department> departments = departmentMapper.queryByKey(dwbh, dwmc, dwmcpy, pre, next);

        PrintWriter out = null;
        out = response.getWriter();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errorCode", "0");
        jsonObject.put("errorText", "");
        jsonObject.put("data", departments);
        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }

    @RequestMapping("/modifydepartment")
    public void modifyDepartmentInfo(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        String dwmc = request.getParameter("dwmc");
        String dwid = request.getParameter("dwid");
        String tblb = request.getParameter("tblb");
        String tblbmc = request.getParameter("tblbmc");
        try {
            String result = departmentMapper.modifyDepartment(dwid + "", dwmc + "", tblb + "", tblbmc + "");

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

    @RequestMapping("/querybydwid")
    public String queryByDWBH(HttpServletRequest request, Model model) throws Exception {

        String dwid = request.getParameter("dwid");
        if (dwid == null && "".equals(dwid)) {
            throw new Exception("选择的单位不存在，请重新选择");
        }
        Department department = departmentMapper.queryByDWID(dwid);
        model.addAttribute("department", department);
        return "modify_department_info";
    }


    private boolean isEnglish(String charaString) {

        return charaString.matches("^[a-zA-Z]*");

    }
}
