package com.springmvc_mybatis.controller;

import com.springmvc_mybatis.bean.PaymentHistory;
import com.springmvc_mybatis.json.JSONArray;
import com.springmvc_mybatis.json.JSONObject;
import com.springmvc_mybatis.mapper.PaymentHistoryMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

@Controller
@RequestMapping("/paymentHistory")
public class PaymentHistoryController {
    @Autowired
    private PaymentHistoryMapper paymentHistoryMapper;

    @RequestMapping("/interestPaymentHistory")
    public String interestPaymentHistory(HttpServletRequest request, Model model) throws Exception {


        String dwid = request.getParameter("dwid");
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");

        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
//        String pre = String.valueOf(1 + (pageNum - 1) * countNum);
//        String next = String.valueOf(pageNum * countNum);
        List<PaymentHistory> paymentHistories = new ArrayList<>();
        int num = paymentHistoryMapper.queryCountWithoutInterest(dwid);
        if (num > 0) {
            paymentHistories = paymentHistoryMapper.queryBillsWithoutInterest(dwid, page, String.valueOf(countNum + pageNum));
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", num);
        JSONArray jsonArray = new JSONArray();

        for (PaymentHistory paymentHistory : paymentHistories) {
            JSONObject object = new JSONObject(paymentHistory.getStaff());
            jsonArray.put(object);
        }
        jsonObject.put("rows", jsonArray);
        model.addAttribute("data", jsonObject);

        return "dempartment_interest";
    }

    @RequestMapping("/clearPaymentHistory")
    public String clearPaymentHistory(HttpServletRequest request, Model model) throws Exception {

        String dwid = request.getParameter("dwid");
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");

        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
        List<PaymentHistory> paymentHistories = new ArrayList<>();
        int num = paymentHistoryMapper.queryCountWithInterest(dwid);
        if (num > 0) {
            paymentHistories = paymentHistoryMapper.queryBillsWithInterest(dwid, page, String.valueOf(countNum + pageNum));
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", num);
        JSONArray jsonArray = new JSONArray();

        for (PaymentHistory paymentHistory : paymentHistories) {
            JSONObject object = new JSONObject(paymentHistory.getStaff());
            jsonArray.put(object);
        }
        jsonObject.put("rows", jsonArray);
        model.addAttribute("data", jsonObject);

        return "dempartment_clear_interest";
    }

    @RequestMapping("/interest")
    public void interest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");


        try {
            String dwid = request.getParameter("dwid");
            String ryids = request.getParameter("ryids");
            JSONArray jsonArray = new JSONArray(ryids);
            ArrayList<String> ryidArray = new ArrayList<>();
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject object = jsonArray.getJSONObject(i);
                ryidArray.add(object.getString("ryid"));
            }
            float lx = 0;
            paymentHistoryMapper.modifyInterest(dwid, lx, ryidArray);
            JSONObject object = new JSONObject();
            object.put("errorCode", 0);
            object.put("errorText", "");
            Writer writer = response.getWriter();
            writer.write(object.toString());
        } catch (Exception e) {
            throw e;
        }

    }

    @RequestMapping("/clear")
    public void clearInterest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");


        try {
            String dwid = request.getParameter("dwid");
            String ryids = request.getParameter("ryids");
            JSONArray jsonArray = new JSONArray(ryids);
            ArrayList<String> ryidArray = new ArrayList<>();
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject object = jsonArray.getJSONObject(i);
                ryidArray.add(object.getString("ryid"));
            }
            paymentHistoryMapper.clearInterest(dwid,ryidArray);
            JSONObject object = new JSONObject();
            object.put("errorCode", 0);
            object.put("errorText", "");
            Writer writer = response.getWriter();
            writer.write(object.toString());
        } catch (Exception e) {
            throw e;
        }

    }

    private float calInterest(int year, float payment) {
        float finalInterest = 0f;
        float scale = 0.03f;
        Calendar calendar = Calendar.getInstance();
        int currentYear = calendar.get(Calendar.YEAR);
        finalInterest = payment * scale * (currentYear - year);
        return finalInterest;
    }
}
