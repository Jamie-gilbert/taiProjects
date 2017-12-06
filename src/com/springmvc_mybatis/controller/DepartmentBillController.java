package com.springmvc_mybatis.controller;

import com.springmvc_mybatis.bean.DepartmentBill;
import com.springmvc_mybatis.json.JSONArray;
import com.springmvc_mybatis.json.JSONObject;
import com.springmvc_mybatis.mapper.DepartmentBillMapper;
import com.springmvc_mybatis.mapper.PaymentHistoryMapper;
import netscape.javascript.JSObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("/departmentBills")
public class DepartmentBillController {

    @Autowired
    private DepartmentBillMapper departmentBillMapper;
    @Autowired
    private PaymentHistoryMapper paymentHistoryMapper;

    @RequestMapping("/querydepartmentbils")
    public void queryDepartmentBils(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        String dwid = request.getParameter("dwid");

        String type = request.getParameter("type");
        String time = request.getParameter("time");

        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");

        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
        Date date = new Date();
        try {
            if (time != null && !"".equals(time)) {
                date = simpleDateFormat.parse(time);
            } else {
                date = simpleDateFormat.parse("1800-12-12");

            }
        } catch (ParseException e) {
            e.printStackTrace();
        }
        List<DepartmentBill> departmentBills = new ArrayList<>();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
        String times = dateFormat.format(date);
        int counts = departmentBillMapper.queryCount(dwid, times, type);
        if (counts > 0) {
            departmentBills = departmentBillMapper.queryBills(dwid, times, type, page, String.valueOf(countNum + pageNum));
        }

        PrintWriter out = response.getWriter();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", counts);
        JSONArray jsonArray = new JSONArray();
        for (DepartmentBill bill : departmentBills) {
            JSONObject object = new JSONObject(bill);
            jsonArray.put(object);
        }
        jsonObject.put("rows", jsonArray);
//        jsonObject.put("errorCode", "0");
//        jsonObject.put("errorText", "");
//        jsonObject.put("data", departmentBills);
        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }

    /**
     * 将选中的未确认单据改为已确认或者作废,将选中的已确认单据改为冲销
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/modifyStatusByZDLSH")
    public void modifyStatusByZDLSH(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String dwid = request.getParameter("dwid");
        String zdlsh = request.getParameter("zdlsh");
        String djzt = request.getParameter("djzt");
        departmentBillMapper.modifyStatusByZDLSH(zdlsh, dwid, djzt);
       /*
       作废
        */
        if (djzt.equals("2")) {
            paymentHistoryMapper.cancelBill(dwid);
        }
        PrintWriter out = response.getWriter();
        JSONObject jsonObject = new JSONObject();

        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }


}
