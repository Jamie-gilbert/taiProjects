package com.springmvc_mybatis.controller;

import com.springmvc_mybatis.bean.Staff;
import com.springmvc_mybatis.json.JSONArray;
import com.springmvc_mybatis.json.JSONObject;
import com.springmvc_mybatis.mapper.StaffMapper;
import com.springmvc_mybatis.utils.PinYinUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.ArrayList;
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
        String type = request.getParameter("type");
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");

        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
//        String pre = String.valueOf(1 + (pageNum - 1) * countNum);
//        String next = String.valueOf(pageNum * countNum);
        int num = staffMapper.queryCount(dwid, type);
        List<Staff> staffList = new ArrayList<>();
        if (num > 0) {
            staffList = staffMapper.queryStaff(dwid, type, page, String.valueOf(countNum + pageNum));
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", num);
        JSONArray jsonArray = new JSONArray();
        for (Staff staff : staffList) {
            JSONObject object = new JSONObject(staff);
            jsonArray.put(object);
        }
        jsonObject.put("rows", jsonArray);
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
//        String ryid = request.getParameter("ryid");
//        String rydjid = request.getParameter("rydjid");
        String czbm = request.getParameter("czbm");
//        String ygrbh = request.getParameter("ygrbh");
        String jbjgid = request.getParameter("jbjgid");
        String xmpy = PinYinUtil.cn2Spell(xm);

        staffMapper.saveStaff(xm, cym, dwid, cbrylb, xb
                , sfzhm, csrq, sfxz, mz, tblb, tblbmc
                , cjgzsj, jfly, hkxz, dz, dh, grsf, rwsj
                , drsj, zyyy, jyyy, czbm
                , jbjgid, xmpy, bz);

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errorCode", "0");
        jsonObject.put("errorText", "");
        PrintWriter out = response.getWriter();
        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }

    @RequestMapping("/modifyStaff")
    public void modifyStaff(HttpServletRequest request, HttpServletResponse response) throws Exception {

        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        String xm = request.getParameter("xm");
        String cym = request.getParameter("cym");
//        String xb = request.getParameter("xb");
        String sfzhm = request.getParameter("sfzhm");
        String csrq = request.getParameter("csrq");
//        String sfxz = request.getParameter("sfxz");
//        String cbrylb = request.getParameter("cbrylb");
//        String mz = request.getParameter("mz");
//        String tblb = request.getParameter("tblb");
//        String tblbmc = request.getParameter("tblbmc");
//        String cjgzsj = request.getParameter("cjgzsj");
//        String jfly = request.getParameter("jfly");
//        String hkxz = request.getParameter("hkxz");
//        String dz = request.getParameter("dz");
//        String dh = request.getParameter("dh");
//        String grsf = request.getParameter("grsf");
//        String rwsj = request.getParameter("rwsj");
//        String drsj = request.getParameter("drsj");
//        String zyyy = request.getParameter("zyyy");
//        String jyyy = request.getParameter("jyyy");
//        String bz = request.getParameter("bz");
//        String ryid = request.getParameter("ryid");
//        String rydjid = request.getParameter("rydjid");
//        String czbm = request.getParameter("czbm");
//        String ygrbh = request.getParameter("ygrbh");
//        String jbjgid = request.getParameter("jbjgid");
//        String xmpy = PinYinUtil.cn2Spell(xm);
        String grbh = request.getParameter("grbh");
        staffMapper.modifyStaff(xm, cym, sfzhm, csrq,  grbh);

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errorCode", "0");
        jsonObject.put("errorText", "");
        PrintWriter out = response.getWriter();
        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }


    /**
     * 人员操作--查询人员信息
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/queryStaffInfo")
    public void queryStaffInfo(HttpServletRequest request, HttpServletResponse response) throws Exception {

        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        String grsfzhm = request.getParameter("grsfzhm");
        String grbh = request.getParameter("grbh");
        String grxm = request.getParameter("grxm");
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");


        String xmpy = "";
        if (grxm != null) {
            if (PinYinUtil.isEnglish(grxm)) {
                xmpy = grxm;
                grxm = "";
            }
        } else {
            grxm = "";
        }
        if (grbh == null) {
            grbh = "";
        }
        if (grsfzhm == null) {
            grsfzhm = "";
        }
        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
//        String pre = String.valueOf(1 + (pageNum - 1) * countNum);
//        String next = String.valueOf(pageNum * countNum);
        int num = staffMapper.queryStaffCount(grbh, grsfzhm, grxm, xmpy);
        JSONArray array = new JSONArray();
        if (num > 0) {
            List<Staff> staffList = staffMapper
                    .queryStaffInfo(grbh, grsfzhm, grxm, xmpy, page, String.valueOf(countNum + pageNum));
            for (Staff staff : staffList) {
                JSONObject object = new JSONObject(staff);
                array.put(object);
            }
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", num);
        jsonObject.put("rows", array);
        PrintWriter out = response.getWriter();
        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }

}
