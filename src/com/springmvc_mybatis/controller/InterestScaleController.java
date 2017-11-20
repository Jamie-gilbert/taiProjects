package com.springmvc_mybatis.controller;

import com.springmvc_mybatis.bean.InterestScale;
import com.springmvc_mybatis.json.JSONArray;
import com.springmvc_mybatis.json.JSONObject;
import com.springmvc_mybatis.mapper.InterestScaleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.Writer;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/interestScale")
public class InterestScaleController {
    @Autowired
    InterestScaleMapper interestScaleMapper;

    /**
     * 查询所有的利率
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("/queryAllInterestScales")
    public void queryAllInterestScales(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        List<InterestScale> interestScales = interestScaleMapper.queryAllInterestScales();

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", interestScales.size());
        JSONArray jsonArray = new JSONArray();

        for (InterestScale interestScale : interestScales) {
            JSONObject object = new JSONObject(interestScale);
            jsonArray.put(object);
        }
        jsonObject.put("rows", jsonArray);
        Writer writer = response.getWriter();
        writer.write(jsonArray.toString());
        writer.flush();
        writer.close();

    }

    /**
     * 添加利率
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("/addInterestScale")
    public void addInterestScale(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String year = request.getParameter("year");
        String scale = request.getParameter("ll");
        float ll = 0f;
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errorCode", 0);
        try {
            ll = Float.parseFloat(scale);
        } catch (Exception e) {
            e.printStackTrace();
            jsonObject.put("errorCode", 1);
            jsonObject.put("errorText", "输入的利率格式不正确，请重新输入");

        }

        try {
            interestScaleMapper.addInterestScale(year, ll);

        } catch (Exception e) {
            e.printStackTrace();
            jsonObject.put("errorCode", 1);
            jsonObject.put("errorText", "改年份的利率已存在");
        }


        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();

    }

    /**
     * 添加利率
     *
     * @param request
     * @throws Exception
     */
    @RequestMapping("/modifyInterestScale")
    public void modifyInterestScale(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String data = request.getParameter("data");
        JSONArray array = new JSONArray(data);
        List<InterestScale> interestScales = new ArrayList<>();
        for (int i = 0; i < array.length(); i++) {
            JSONObject o = array.getJSONObject(i);
            InterestScale interestScale = new InterestScale();
            interestScale.setCurrent_year(String.valueOf(o.get("current_year")));
            String scaleStr = String.valueOf(o.get("interest_scale"));
            float scale = 0f;

            try {
                scale = Float.parseFloat(scaleStr);
            } catch (Exception e) {

            }

            interestScale.setInterest_scale(scale);
            interestScales.add(interestScale);
        }

        interestScaleMapper.modifyInterestScale(interestScales);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errorCode", 0);
        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();

    }
}
