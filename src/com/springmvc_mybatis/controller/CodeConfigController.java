package com.springmvc_mybatis.controller;

import com.springmvc_mybatis.bean.CodeConfig;
import com.springmvc_mybatis.bean.DepartmentBill;
import com.springmvc_mybatis.json.JSONArray;
import com.springmvc_mybatis.json.JSONObject;
import com.springmvc_mybatis.mapper.CodeConfigMapper;
import com.springmvc_mybatis.mapper.DepartmentBillMapper;
import com.springmvc_mybatis.mapper.PaymentHistoryMapper;
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
import java.util.Collections;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("/codeconfig")
public class CodeConfigController {

    @Autowired
    private CodeConfigMapper codeConfigMapper;


    @RequestMapping("/queryAllCode")
    public void queryAllCode(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");


        List<CodeConfig> codeConfigs = codeConfigMapper.queryAllCode();
        JSONArray array = new JSONArray();
        label:
        for (int i = 0; i < codeConfigs.size(); i++) {
            CodeConfig codeConfig = codeConfigs.get(i);
            JSONObject jsonObject = new JSONObject();
            String dmbh = codeConfig.getDmbh();
            jsonObject.put("dmbh", dmbh);
            for (int k = 0; k < array.length(); k++) {
                if (array.getJSONObject(k).getString("dmbh").equals(dmbh)) {
                    continue label;
                }
            }
            JSONArray jsonArray = new JSONArray();
            for (int j = 0; j < codeConfigs.size(); j++) {
                if (dmbh.equals(codeConfigs.get(j).getDmbh())) {
                    JSONObject object = new JSONObject();
                    object.put("code", codeConfigs.get(j).getCode());
                    object.put("content", codeConfigs.get(j).getContent());
                    jsonArray.put(object);

                }
            }
            jsonObject.put("value", jsonArray);
            array.put(jsonObject);
        }

        PrintWriter out = response.getWriter();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data", array);
        out.write(jsonObject.toString());
        out.flush();
        out.close();
    }


}
