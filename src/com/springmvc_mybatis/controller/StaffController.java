package com.springmvc_mybatis.controller;

import com.springmvc_mybatis.bean.Staff;
import com.springmvc_mybatis.json.JSONObject;
import com.springmvc_mybatis.mapper.StaffMapper;
import com.springmvc_mybatis.utils.PinYinUtil;
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

    @RequestMapping("/saveStaff")
    public void saveStaff(HttpServletRequest request, HttpServletResponse response) throws Exception {

        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        String dwid = request.getParameter("dwid");
        String xm = request.getParameter("xm");
        String cym = request.getParameter("cym");
        String xb = request.getParameter("xb");
        String sfzhm = request.getParameter("sfzhm");
        String csrq = request.getParameter("csrq");
        String sfxz = request.getParameter("sfxz");
        String cbrylb = request.getParameter("cbrylb");
        String mz = request.getParameter("mz");
        String tblb = request.getParameter("tblb");
        String tblbmc = request.getParameter("tblbmc");
        String cjgzsj = request.getParameter("cjgzsj");
        String jfly = request.getParameter("jfly");
        String hkxz = request.getParameter("hkxz");
        String dz = request.getParameter("dz");
        String dh = request.getParameter("dh");
        String grsf = request.getParameter("grsf");
        String rwsj = request.getParameter("rwsj");
        String drsj = request.getParameter("drsj");
        String zyyy = request.getParameter("zyyy");
        String jyyy = request.getParameter("jyyy");
        String bz = request.getParameter("bz");
        String ryid = request.getParameter("ryid");
        String rydjid = request.getParameter("rydjid");
        String czbm = request.getParameter("czbm");
        String ygrbh = request.getParameter("ygrbh");
        String jbjgid = request.getParameter("jbjgid");
        String xmpy = PinYinUtil.cn2Spell(xm);

        staffMapper.saveStaff(xm, cym, dwid, cbrylb, xb
                , sfzhm, csrq, sfxz, mz, tblb, tblbmc
                , cjgzsj, jfly, hkxz, dz, dh, grsf, rwsj
                , drsj, zyyy, jyyy, ryid, rydjid, czbm
                , ygrbh, ygrbh, jbjgid, xmpy, bz);

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errorCode", "0");
        jsonObject.put("errorText", "");
        PrintWriter out = response.getWriter();
        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }
}
