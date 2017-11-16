package com.springmvc_mybatis.controller;

import com.springmvc_mybatis.bean.Department;
import com.springmvc_mybatis.json.JSONArray;
import com.springmvc_mybatis.json.JSONObject;
import com.springmvc_mybatis.mapper.DepartmentMapper;
import com.springmvc_mybatis.utils.PinYinUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;


@Controller
@RequestMapping("/department")
public class DepartmentController {

    @Autowired
    private DepartmentMapper departmentMapper;

    /**
     * 查询单位
     *
     * @param request
     * @param response
     * @throws Exception
     */
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
            if (PinYinUtil.isEnglish(dwmc)) {
                dwmcpy = dwmc;
                dwmc = "";
            }
        } else {
            dwmc = "";
        }
        if (dwbh == null) {
            dwbh = "";
        }
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");
        List<Department> departments = new ArrayList<>();
        int num = departmentMapper.queryCountByKey(dwbh, dwmc, dwmcpy);
        if (num > 0) {
            int countNum = Integer.parseInt(count);
            int pageNum = Integer.parseInt(page);
            departments = departmentMapper.queryByKey(dwbh, dwmc, dwmcpy, page, String.valueOf(countNum + pageNum));
        }

        JSONArray jsonArray = new JSONArray();
        for (Department department : departments) {
            JSONObject object = new JSONObject(department);
            jsonArray.put(object); }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", num);
        jsonObject.put("rows", jsonArray);
        PrintWriter out = response.getWriter();

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


}
