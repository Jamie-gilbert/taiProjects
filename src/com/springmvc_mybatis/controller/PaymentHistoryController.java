package com.springmvc_mybatis.controller;

import com.springmvc_mybatis.bean.*;
import com.springmvc_mybatis.json.JSONArray;
import com.springmvc_mybatis.json.JSONObject;
import com.springmvc_mybatis.mapper.DepartmentBillMapper;
import com.springmvc_mybatis.mapper.InterestScaleMapper;
import com.springmvc_mybatis.mapper.PaymentHistoryMapper;
import com.springmvc_mybatis.mapper.StaffMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.Writer;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/paymentHistory")
public class PaymentHistoryController {
    @Autowired
    private PaymentHistoryMapper paymentHistoryMapper;
    @Autowired
    private InterestScaleMapper interestScaleMapper;
    @Autowired
    private StaffMapper staffMapper;
    @Autowired
    private DepartmentBillMapper departmentBillMapper;

    /**
     * 根据单位id查询缴费历史
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/interestPaymentHistory")
    public void interestPaymentHistory(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

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
            object.put("zje", paymentHistory.getZJE());
            jsonArray.put(object);
        }
        jsonObject.put("rows", jsonArray);
        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();

//        model.addAttribute("data", jsonObject);
//
//        return "dempartment_interest";

    }


    /**
     * 根据单位id查询缴费明细
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping("/queryAllHistory")
    public void queryAllHistory(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        String dwid = request.getParameter("dwid");
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");
        String sort = request.getParameter("sort");
        String sortOrder = request.getParameter("sortOrder");

        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
        List<PaymentHistory> paymentHistories = new ArrayList<>();
        int num = paymentHistoryMapper.queryCountByDWID(dwid);
        if (num > 0) {
            paymentHistories = paymentHistoryMapper.queryAllHistoryByDWID(dwid, page, String.valueOf(countNum + pageNum));
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", num);
        JSONArray jsonArray = new JSONArray();

        for (PaymentHistory paymentHistory : paymentHistories) {
            JSONObject object = new JSONObject(paymentHistory.getStaff());
            object.put("QSNY", paymentHistory.getQSNY());
            object.put("ZZNY", paymentHistory.getZZNY());
            object.put("GRJFE", paymentHistory.getGRJFE());
            object.put("LX", paymentHistory.getLX());
            jsonArray.put(object);
        }
        jsonObject.put("rows", jsonArray);
        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();


    }

//    /**
//     * 根据单位id查询缴费明细
//     *
//     * @param request
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping("/extportHistory")
//    public void extportHistory(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        response.setContentType("application/json");
//        response.setHeader("Pragma", "No-cache");
//        response.setHeader("Cache-Control", "no-cache");
//        response.setCharacterEncoding("UTF-8");
//
//        String dwid = request.getParameter("dwid");
//
//        List<PaymentHistory> paymentHistories = new ArrayList<>();
//
//        paymentHistories = paymentHistoryMapper.extportHistoryByDWID(dwid);
//        List<ExtportBean> extportBeans = new ArrayList<>();
//        for (int i = 0; i < paymentHistories.size(); i++) {
//            PaymentHistory paymentHistory = paymentHistories.get(i);
//            ExtportBean bean = new ExtportBean();
//            bean.setXh(String.valueOf(i));
//            bean.setXm(paymentHistory.getStaff().getXM());
//            bean.setGrjfe(paymentHistory.getGRJFE() + " 元");
//            bean.setLx(paymentHistory.getLX() + " 元");
//            bean.setQsny(paymentHistory.getQSNY());
//            bean.setZzny(paymentHistory.getZZNY());
//            extportBeans.add(bean);
//
//        }
//        String[] headers = {"序号", "姓名", "起始年月", "终至年月","个人缴费额","利息"};
//        String fileName = "个人缴费明细";
//        ExportExcel<ExtportBean> exportExcel=new ExportExcel<>();
//        exportExcel.exportExcel(headers,extportBeans,fileName,response);
//
//    }


    /**
     * 根据dwid 查询需要已经计息的人员
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/clearPaymentHistory")
    public void clearPaymentHistory(HttpServletRequest request, HttpServletResponse response) throws Exception {
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
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
            object.put("zje", paymentHistory.getZJE());
            jsonArray.put(object);
        }
        jsonObject.put("rows", jsonArray);
        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();

    }

    /**
     * 根据dwid 进行计息
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/interest")
    public void interest(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String dwid = request.getParameter("dwid");
        String infos = request.getParameter("infos");
        JSONArray jsonArray = new JSONArray(infos);
        List<PaymentHistory> params = new ArrayList();
        Calendar calendar = Calendar.getInstance();
//        int currentYear = calendar.get(Calendar.YEAR);
        int currentYear = 2016;
        float scale = interestScaleMapper.queryInterestScale((String.valueOf(currentYear)).trim());
        List<String> ryids = new ArrayList<>();
        JSONObject object = new JSONObject();
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            String ryid = jsonObject.getString("ryid");
            ryids.add(ryid);
        }
        params = paymentHistoryMapper.queryPaymentHisByRyids(dwid, ryids);
        if (params != null) {
            for (PaymentHistory paymentHistory : params) {
                String zzny = paymentHistory.getZZNY();
                int zznyNum = Integer.parseInt(zzny.substring(0, 4));
                float lx = calInterest(zznyNum, currentYear, scale, paymentHistory.getGRJFE());
                paymentHistory.setLX(lx);

            }
            paymentHistoryMapper.modifyInterest(params);
            object.put("errorCode", 0);
            object.put("errorText", "");
        } else {
            object.put("errorCode", 1);
            object.put("errorText", "计息失败");
        }


        Writer writer = response.getWriter();
        writer.write(object.toString());
        writer.flush();
        writer.close();
    }


    /**
     * 根据dwid 进行退费
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/rebackPaymentByDWID")
    public void rebackPaymentByDWID(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String dwid = request.getParameter("dwid");
        String txr = request.getParameter("txr");
        String jbjgid = request.getParameter("jbjgid");
        int count = paymentHistoryMapper.queryCountWithoutInterest(dwid);
        JSONObject jsonObject = new JSONObject();
        if (count == 0) {
            paymentHistoryMapper.rebackPaymentByDWID(dwid);
            double zje = paymentHistoryMapper.calPaymentByDWID(dwid);
            String zdlsh = departmentBillMapper.queryZDLSH();
            DepartmentBill departmentBill = new DepartmentBill();
            departmentBill.setZje(zje);
            departmentBill.setDwid(dwid);
            departmentBill.setDjzt("0");
            departmentBill.setDjlb("SI1002");
            departmentBill.setZdlsh(zdlsh);
            departmentBill.setTxr(txr);
            departmentBill.setQrr(txr);
            Date date = new Date();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM");
            String dateStr = simpleDateFormat.format(date);
            departmentBill.setTxsj(dateStr);
            departmentBill.setQrsj(dateStr);
            departmentBill.setJbjgid(jbjgid);
            SimpleDateFormat simpleDateFormat1 = new SimpleDateFormat("yyyyMM");
            departmentBillMapper.addBillDel(zdlsh, "102", "AL1", simpleDateFormat1.format(date)
                    , simpleDateFormat1.format(date), (float) zje);
            departmentBillMapper.rebackPaymentByDWID(departmentBill);
            int rebackCount = paymentHistoryMapper.queryCountWithRebackByDWID(dwid);
            jsonObject.put("errorCode", "0");
            jsonObject.put("errorText", "");
            jsonObject.put("count", rebackCount);
        } else {

            jsonObject.put("errorCode", "1");
            jsonObject.put("errorText", "单位中存在未计息的人员，请先计息");
        }

        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();

    }

    /**
     * 修改人员的缴费历史记录
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/modifyPaymentHistory")
    public void modifyPaymentHistory(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        String infos = request.getParameter("data");
        JSONArray jsonArray = new JSONArray(infos);
        ArrayList<PaymentHistory> updateParams = new ArrayList();
//        ArrayList<PaymentHistory> insetParams = new ArrayList();
        for (int i = 0; i < jsonArray.length(); i++) {

            JSONObject jsonObject = jsonArray.getJSONObject(i);
//            String flag = jsonObject.getString("flag");

            String JFRQ = jsonObject.getString("JFRQ");
            String qsny = jsonObject.getString("QSNY");
            String zzny = jsonObject.getString("ZZNY");
            String XZBZ = jsonObject.getString("XZBZ");
            String ryid = jsonObject.getString("RYID");
            String JFLSID = jsonObject.getString("JFLSID");

            double DWJFE = jsonObject.getDouble("DWJFE");
            double GRJFE = jsonObject.getDouble("GRJFE");

//            String zdlsh = jsonObject.getString("zdlsh");
            PaymentHistory paymentHistory = new PaymentHistory();
//            if ("isUpate".equalsIgnoreCase(flag)) {
            paymentHistory.setQSNY(qsny);
            paymentHistory.setRYID(ryid);
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss");
            paymentHistory.setJFRQ(dateFormat.parse(JFRQ));
            paymentHistory.setFSRQ(dateFormat.parse(JFRQ));
            paymentHistory.setGRJFE(GRJFE);
            paymentHistory.setDWJFE(DWJFE);
            paymentHistory.setZZNY(zzny);
            paymentHistory.setXZBZ(XZBZ);
            paymentHistory.setJFLSID(JFLSID);
            updateParams.add(paymentHistory);
//            } else {
//                String fsrq = jsonObject.getString("fsrq");
//                double dwjfbl = jsonObject.getDouble("dwjfbl");
//                double grjfbl = jsonObject.getDouble("grjfbl");
//                double grjfjs = jsonObject.getDouble("grjfbl");
//                String jbjgid = jsonObject.getString("jbjgid");
//                String jbr = jsonObject.getString("jbr");
//                String jbsj = jsonObject.getString("jbsj");
//                String jfrq = jsonObject.getString("jfrq");
//                String bz = jsonObject.getString("bz");
//                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
//                paymentHistory.setDWJFBL(dwjfbl);
//                paymentHistory.setGRJFBL(grjfbl);
//                paymentHistory.setGRJFJS(grjfjs);
//                paymentHistory.setJBJGID(jbjgid);
//                paymentHistory.setJBR(jbr);
//                paymentHistory.setJBSJ(simpleDateFormat.parse(jbsj));
//                paymentHistory.setFSRQ(simpleDateFormat.parse(fsrq));
//                paymentHistory.setJFLSID(jflsid);
//                paymentHistory.setJFRQ(simpleDateFormat.parse(jfrq));
//                paymentHistory.setZDLSH(zdlsh);
//                paymentHistory.setBZ(bz);
//                paymentHistory.setQSNY(qsny);
//                paymentHistory.setRYID(ryid);
//                paymentHistory.setLX(lx);
//                paymentHistory.setDWJFJS(dwjfjs);
//                paymentHistory.setDWJFE(dwjfe);
//                paymentHistory.setDWJFZE(dwjfze);
//                paymentHistory.setZZNY(zzny);
//                paymentHistory.setLX(lx);
//                paymentHistory.setXGBZ(1);
//                insetParams.add(paymentHistory);
//            }
        }
        if (updateParams.size() > 0) {
            paymentHistoryMapper.modifyPaymentHistory(updateParams);
        }
//        if (insetParams.size() > 0) {
//            paymentHistoryMapper.addPaymentHistory(insetParams);
//        }
        JSONObject object = new JSONObject();
        object.put("errorCode", 0);
        object.put("errorText", "");
        Writer writer = response.getWriter();
        writer.write(object.toString());
        writer.flush();
        writer.close();

    }


    /**
     * 添加人员的缴费历史记录
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/addPaymentHistory")
    public void addPaymentHistory(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        String infos = request.getParameter("data");
        JSONObject jsonObject = new JSONObject(infos);
        String qsny = jsonObject.getString("QSNY");
        String zzny = jsonObject.getString("ZZNY");

        String ryid = jsonObject.getString("RYID");
        String dwid = String.valueOf(jsonObject.get("dwid"));
        double DWJFE = jsonObject.getDouble("DWJFE");
        double GRJFE = jsonObject.getDouble("GRJFE");

        PaymentHistory paymentHistory = new PaymentHistory();
        ArrayList<PaymentHistory> paymentHistories = new ArrayList<>();
        String jbr = jsonObject.getString("jbr");
        Date jbsj = new Date();
        String jfrq = jsonObject.getString("jfrq");

        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss");
        paymentHistory.setDWJFBL(0);
        paymentHistory.setGRJFBL(0);
        paymentHistory.setDWID(dwid);
        paymentHistory.setRYDJID(ryid);
        paymentHistory.setJBR(jbr);
        paymentHistory.setJBSJ(jbsj);
        paymentHistory.setFSRQ(simpleDateFormat.parse(jfrq));
        paymentHistory.setJBJGID("37091103");
        paymentHistory.setJFRQ(simpleDateFormat.parse(jfrq));
        paymentHistory.setQSNY(qsny);
        paymentHistory.setDWJFJS(0);
        paymentHistory.setGRJFJS(0);
        paymentHistory.setXZBZ("102");
        paymentHistory.setGRJFE(GRJFE);
        paymentHistory.setGRJFZE(GRJFE);
        paymentHistory.setDWJFE(DWJFE);
        paymentHistory.setDWJFZE(DWJFE);
        paymentHistory.setRYID(ryid);
        paymentHistory.setZZNY(zzny);
        paymentHistories.add(paymentHistory);

        paymentHistoryMapper.addPaymentHistory(paymentHistories);

        JSONObject object = new JSONObject();
        object.put("errorCode", 0);
        object.put("errorText", "");
        Writer writer = response.getWriter();
        writer.write(object.toString());
        writer.flush();
        writer.close();

    }

    /**
     * 撤销单位中需要撤销计息人员的利息
     *
     * @param request
     * @param response
     * @throws IOException
     */
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
            paymentHistoryMapper.clearInterest(dwid, ryidArray);
            JSONObject object = new JSONObject();
            object.put("errorCode", 0);
            object.put("errorText", "");
            Writer writer = response.getWriter();
            writer.write(object.toString());
            writer.flush();
            writer.close();
        } catch (Exception e) {
            throw e;
        }

    }

    /**
     * 对某个人员进行计息
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/modifyInterestByRyid")
    public void modifyInterestByRyid(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        try {

            String infos = request.getParameter("infos");
            JSONArray jsonArray = new JSONArray(infos);
            ArrayList<PaymentHistory> params = new ArrayList();
            Calendar calendar = Calendar.getInstance();
//            int currentYear = calendar.get(Calendar.YEAR);
            int currentYear = 2016;
            float scale = interestScaleMapper.queryInterestScale((String.valueOf(currentYear)).trim());
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                String qsny = jsonObject.getString("qsny");
                String zzny = jsonObject.getString("zzny");
                String ryid = jsonObject.getString("ryid");
                float payment = jsonObject.getFloat("payment");
                int zznyNum = Integer.parseInt(zzny.substring(0, 4));

                float lx = calInterest(zznyNum, currentYear, scale, payment);
                PaymentHistory paymentHistory = new PaymentHistory();
                paymentHistory.setQSNY(qsny);
                paymentHistory.setRYID(ryid);
                paymentHistory.setLX(lx);
                params.add(paymentHistory);

            }

            paymentHistoryMapper.modifyInterestByRyid(params);
            JSONObject object = new JSONObject();
            object.put("errorCode", 0);
            object.put("errorText", "");
            Writer writer = response.getWriter();
            writer.write(object.toString());
            writer.flush();
            writer.close();
        } catch (Exception e) {
            throw e;
        }

    }

    /**
     * 查询某个人员的缴费历史记录
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/queryByRyid")
    public void qyeryByRyid(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");
        String ryid = request.getParameter("ryid");
        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
        List<PaymentHistory> paymentHistories = new ArrayList<>();

        int num = paymentHistoryMapper.queryCountByRyid(ryid);
        if (num > 0) {
            paymentHistories = paymentHistoryMapper.queryByRyid(ryid, page, String.valueOf(countNum + pageNum));
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", num);
        JSONArray jsonArray = new JSONArray();
        for (PaymentHistory paymentHistory : paymentHistories) {
            paymentHistory.setStaff(null);
            JSONObject object = new JSONObject(paymentHistory);

            jsonArray.put(object);

        }
        jsonObject.put("rows", jsonArray);
        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();
    }


    /**
     * 查询某个人员的没有计息的历史记录
     *
     * @param request
     * @param model
     * @throws IOException
     */
    @RequestMapping("/qyeryInterestByRyid")
    public String qyeryInterestByRyid(HttpServletRequest request, Model model) throws IOException {
        //设置页面不缓存
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");
        String ryid = request.getParameter("ryid");
        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
        List<PaymentHistory> paymentHistories = new ArrayList<>();

        int num = paymentHistoryMapper.queryCountWithoutInterestByRyid(ryid);
        if (num > 0) {
            paymentHistories = paymentHistoryMapper.queryInterestByRyid(ryid, page, String.valueOf(countNum + pageNum));
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", num);
        JSONArray jsonArray = new JSONArray();
        for (PaymentHistory paymentHistory : paymentHistories) {
            paymentHistory.setStaff(null);
            JSONObject object = new JSONObject(paymentHistory);
            jsonArray.put(object);

        }
        jsonObject.put("rows", jsonArray);
        model.addAttribute("data", jsonObject);

        return "staff_interest";
    }


    /**
     * 查询某个人员的指定时间段的缴费历史记录
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/qyeryByRyidWithDate")
    public void qyeryByRyidWithDate(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");
        String grbh = request.getParameter("grbh");
        String qsrq = request.getParameter("qsrq");
        String zzrq = request.getParameter("zzrq");
        qsrq = qsrq.replace("-", "").trim();
        zzrq = zzrq.replace("-", "").trim();
        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
        String ryid = staffMapper.queryStaffByGRBH(grbh);
        List<PaymentHistory> paymentHistories = new ArrayList<>();
        int num = paymentHistoryMapper.queryCountByRyidWithDate(ryid
                , qsrq, zzrq);

        if (num > 0) {
            paymentHistories = paymentHistoryMapper.queryByRyidWithDate(ryid
                    , qsrq, zzrq, page, String.valueOf(countNum + pageNum));
        }

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", num);
        JSONArray jsonArray = new JSONArray();
        for (PaymentHistory paymentHistory : paymentHistories) {

            JSONObject object = new JSONObject(paymentHistory);
            object.put("XM", paymentHistory.getStaff().getXM());
            Date date = paymentHistory.getJFRQ();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy.MM.dd hh:mm:ss");
            object.put("JFRQ", simpleDateFormat.format(date));
            paymentHistory.setStaff(null);
            jsonArray.put(object);


        }
        jsonObject.put("rows", jsonArray);
        jsonObject.put("ryid", ryid);

        System.out.println(jsonObject.toString());
        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();
    }

    /**
     * 撤销某个人员的计息
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/cancelInterestByRyid")
    public void cancelInterestByRyid(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        String ryid = request.getParameter("ryid");
        paymentHistoryMapper.cancelInterestByRyid(ryid);
        Writer writer = response.getWriter();
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("canceled", true);
        writer.flush();
        writer.close();
    }

    /**
     * 查询某个人员是否存在没有计息的缴费记录
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/queryCountWithoutInterestByRyid")
    public void queryCountWithoutInterestByRyid(HttpServletRequest request, HttpServletResponse response) throws
            IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String ryid = request.getParameter("ryid");
        int num = paymentHistoryMapper.queryCountWithoutInterestByRyid(ryid);
        JSONObject jsonObject = new JSONObject();
        if (num > 0) {
            jsonObject.put("needInterest", true);
        } else {
            jsonObject.put("needInterest", false);
        }

        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();
    }

    /**
     * 查询某个人员在指定时间段中是否存在没有计息的缴费记录
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/queryCountWithoutInterestByRyidWithDate")
    public void queryCountWithoutInterestByRyidWithDate(HttpServletRequest request, HttpServletResponse response) throws
            IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String ryid = request.getParameter("ryid");
        String qsrq = request.getParameter("qsrq");
        String zzrq = request.getParameter("zzrq");
        qsrq = qsrq.replace("-", "").trim();
        zzrq = zzrq.replace("-", "").trim();
        int num = paymentHistoryMapper.queryCountWithoutInterestByRyidWithDate(ryid, qsrq, zzrq);
        JSONObject jsonObject = new JSONObject();
        if (num > 0) {
            jsonObject.put("needInterest", true);
        } else {
            jsonObject.put("needInterest", false);
        }

        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();
    }

    /**
     * 根据人员id和缴费开始的时间段退费
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/rebackPaymentByRyIdWithDate")
    public void rebackPaymentByRyIdWithDate(HttpServletRequest request, HttpServletResponse response) throws
            IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String ryid = request.getParameter("ryid");
        String qsrqs = request.getParameter("qsrqs");
        JSONArray array = new JSONArray(qsrqs);
        List<String> qsrqList = new ArrayList<>();
        List<PaymentHistory> list = new ArrayList<>();
        for (int i = 0; i < array.length(); i++) {
            JSONObject object = array.getJSONObject(i);
            qsrqList.add(String.valueOf(object.get("qsrq")));
            PaymentHistory paymentHistory = new PaymentHistory();
            paymentHistory.setQSNY(String.valueOf(object.get("qsrq")));
            paymentHistory.setGRJFE(0 - object.getFloat("grjfe"));
            paymentHistory.setGRJFZE(0 - object.getFloat("grjfze"));
            paymentHistory.setLX(0 - object.getFloat("lx"));
            list.add(paymentHistory);
        }
        String zzny = Collections.max(qsrqList);
        String qsny = Collections.min(qsrqList);
        Staff staff = staffMapper.queryStaffByRyid(ryid);
        float amount = paymentHistoryMapper.queryAmountByRyidWithDate(ryid, qsrqList);
        String txr = request.getParameter("txr");
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM");
        String dateStr = simpleDateFormat.format(date);
        String zdlsh = departmentBillMapper.queryZDLSH();
        departmentBillMapper.addRebackBill(zdlsh, staff.getDWID()
                , staff.getJBJGID(), txr, dateStr, txr, dateStr, amount, ryid);
        departmentBillMapper.addBillDel(zdlsh, "102", "AL1", qsny, zzny, amount);
        paymentHistoryMapper.rebackPaymentByRyId(ryid, list);

        JSONObject jsonObject = new JSONObject();
        jsonObject.put("errorCode", 0);
        jsonObject.put("errorText", "");
        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();
    }


    /**
     * 查询某个人员是否存在已经计息的缴费记录
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/queryCountWithInterestByRyid")
    public void queryCountWithInterestByRyid(HttpServletRequest request, HttpServletResponse response) throws
            IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String ryid = request.getParameter("ryid");
        int num = paymentHistoryMapper.queryCountWithInterestByRyid(ryid);
        JSONObject jsonObject = new JSONObject();
        if (num > 0) {
            jsonObject.put("needCancel", true);
        } else {
            jsonObject.put("needCancel", false);
        }

        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();
    }


    /**
     * 根据zdlsh查询缴费记录
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/queryByZDLSH")
    public void queryByZDLSH(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String zdlsh = request.getParameter("zdlsh");
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");
        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
        JSONObject jsonObject = new JSONObject();
        int num = paymentHistoryMapper.queryCountByZDLSH(zdlsh);
        JSONArray jsonArray = new JSONArray();
        if (num > 0) {
            List<PaymentHistory> paymentHistories = paymentHistoryMapper.queryPaymentHisByZDLSH(zdlsh
                    , page, String.valueOf(countNum + pageNum));

            for (PaymentHistory paymentHistory : paymentHistories) {
                JSONObject object = new JSONObject(paymentHistory.getStaff());
                object.put("zje", paymentHistory.getGRJFE());
                object.put("qsny", paymentHistory.getQSNY());
                object.put("zzny", paymentHistory.getZZNY());
                object.put("xzbz", paymentHistory.getXZBZ());
                object.put("lx", paymentHistory.getLX());
                jsonArray.put(object);
            }
        }
        jsonObject.put("total", num);

        jsonObject.put("rows", jsonArray);

        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();
    }

    /**
     * 查询缴费历史这得数量
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/queryCountInPaymentHistory")
    public void queryCountInPaymentHistory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");

        JSONObject jsonObject = new JSONObject();
        int allCount = paymentHistoryMapper.queryAllDepartmentCount();
        int rebackCount = paymentHistoryMapper.queryDepartmentCountWithReback();
        int noRebackCount = paymentHistoryMapper.queryDepartmentCountWithoutReback();
        jsonObject.put("all", allCount);
        jsonObject.put("reback", rebackCount);
        jsonObject.put("noReback", noRebackCount);
        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();
    }

    /**
     * 查询已退费的单位记录
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/queryRebackHistory")
    public void queryRebackHistory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");
        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
        JSONObject jsonObject = new JSONObject();
        int rebackCount = paymentHistoryMapper.queryDepartmentCountWithReback();
        JSONArray jsonArray = new JSONArray();
        if (rebackCount > 0) {
            List<DepartmentHistory> departmentHistories = paymentHistoryMapper.queryRebackHistory(page
                    , String.valueOf(countNum + pageNum));
            if (departmentHistories != null) {
                for (DepartmentHistory departmentHistory : departmentHistories) {
                    JSONObject object = new JSONObject(departmentHistory);
                    jsonArray.put(object);
                }
            }

        }
        jsonObject.put("total", rebackCount);
        jsonObject.put("rows", jsonArray);
        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();
    }

    /**
     * 根据dwid查询已退费的单位记录
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/queryNobackHistoryByDWID")
    public void queryNobackHistoryByDWID(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String dwid = request.getParameter("dwid");
        JSONArray jsonArray = new JSONArray();
        DepartmentHistory departmentHistories = paymentHistoryMapper.queryNobackHistoryByDWID(dwid);
        JSONObject object = new JSONObject(departmentHistories);
        jsonArray.put(object);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("total", jsonArray.length());
        jsonObject.put("rows", jsonArray);
        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());

        writer.flush();
        writer.close();
    }

    /**
     * 查询未退费的单位记录
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/queryNoRebackHistory")
    public void queryNoRebackHistory(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");
        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
        JSONObject jsonObject = new JSONObject();
        int noRebackCount = paymentHistoryMapper.queryDepartmentCountWithoutReback();
        JSONArray jsonArray = new JSONArray();
        if (noRebackCount > 0) {
            List<DepartmentHistory> departmentHistories = paymentHistoryMapper.queryNoRebackHistory(page
                    , String.valueOf(countNum + pageNum));
            if (departmentHistories != null) {
                for (DepartmentHistory departmentHistory : departmentHistories) {
                    JSONObject object = new JSONObject(departmentHistory);
                    jsonArray.put(object);
                }
            }

        }
        jsonObject.put("total", noRebackCount);
        jsonObject.put("rows", jsonArray);
        Writer writer = response.getWriter();
        writer.write(jsonObject.toString());
        writer.flush();
        writer.close();
    }


    /**
     * 根据ryid 查询退费记录
     *
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/queryBillByRyid")
    public void queryBillByRyid(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //设置页面不缓存
        response.setContentType("application/json");
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setCharacterEncoding("UTF-8");
        String grbh = request.getParameter("grbh");
        String page = request.getParameter("pageNumber");
        String count = request.getParameter("pageSize");
//        int countNum = Integer.parseInt(count);
//        int pageNum = Integer.parseInt(page);
        JSONObject jsonObject = new JSONObject();
        String ryid = staffMapper.queryStaffByGRBH(grbh);
        int num = departmentBillMapper.queryCountByRyid(ryid);
        JSONArray jsonArray = new JSONArray();
//        if (num > 0) {
//            List<DepartmentBill> departmentBills = departmentBillMapper.queryBillsByRyid(ryid
//                    , page, String.valueOf(countNum + pageNum));
        List<PaymentHistory> paymentHistorys = paymentHistoryMapper.queryAmountByZDLSH(ryid);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        for (PaymentHistory departmentBill : paymentHistorys) {
            JSONObject object = new JSONObject(departmentBill);
            object.put("dwjfes", departmentBill.getDwjfes());
            object.put("lxs", departmentBill.getLxs());
            object.put("grjfes", departmentBill.getDwjfes());
            object.put("JBR", departmentBill.getJBR());

            object.put("JBSJ", simpleDateFormat.format(departmentBill.getJBSJ()));
            object.put("zje", departmentBill.getGrjfes() + departmentBill.getLxs());

            jsonArray.put(object);

//            }
        }
//        jsonObject.put("total", num);
//
//        jsonObject.put("rows", jsonArray);
        System.out.println(jsonArray.toString());
        Writer writer = response.getWriter();
        writer.write(jsonArray.toString());
        writer.flush();
        writer.close();
    }


    /**
     * 计息算法
     *
     * @param year
     * @param currentYear
     * @param scale
     * @param payment
     * @return
     */

    private float calInterest(int year, int currentYear, float scale, double payment) {
        float finalInterest = 0f;

        finalInterest = (float) (payment * scale * (currentYear - year));
        return finalInterest;
    }
}
