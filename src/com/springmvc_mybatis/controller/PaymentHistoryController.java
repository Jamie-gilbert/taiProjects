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
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/paymentHistory")
public class PaymentHistoryController {
    @Autowired
    private PaymentHistoryMapper paymentHistoryMapper;

    @RequestMapping("/queryPaymentHistory")
    public String queryBillsWithoutInterest(HttpServletRequest request, Model model) throws Exception {


        String dwid = request.getParameter("dwid");
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");

        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
//        String pre = String.valueOf(1 + (pageNum - 1) * countNum);
//        String next = String.valueOf(pageNum * countNum);
        List<PaymentHistory> paymentHistories=new ArrayList<PaymentHistory>();
        int num=paymentHistoryMapper.queryCount(dwid);
        if(num>0) {
            paymentHistories = paymentHistoryMapper.queryBillsWithoutInterest(dwid, page, String.valueOf(countNum+pageNum));
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", num);
        JSONArray jsonArray = new JSONArray();

        for (PaymentHistory paymentHistory : paymentHistories) {
            JSONObject object = new JSONObject(paymentHistory.getStaff());
            jsonArray.put(object);
        }
        jsonObject.put("rows", jsonArray);
       model.addAttribute("data",jsonObject);

       return "dempartment_interest";
    }
    @RequestMapping("/interest")
    public void interest(HttpServletRequest request,HttpServletResponse response){
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        String dwid = request.getParameter("dwid");
        String ryids = request.getParameter("ryids");
        JSONArray jsonArray=new JSONArray(ryids);



    }
}
