package com.springmvc_mybatis.controller;

import com.springmvc_mybatis.bean.PaymentHistory;
import com.springmvc_mybatis.bean.Staff;
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
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

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
        int currentYear = calendar.get(Calendar.YEAR);
        float scale = interestScaleMapper.queryInterestScale((String.valueOf(currentYear)).trim());
        List<String> ryids = new ArrayList<>();
        JSONObject object = new JSONObject();
        for (int i = 0; i < jsonArray.length(); i++) {
            JSONObject jsonObject = jsonArray.getJSONObject(i);
            String ryid = jsonObject.getString("ryid");
            ryids.add(ryid);
        }
        params = paymentHistoryMapper.queryPaymentHisByRyids(dwid,ryids);
        if (params != null) {
            for (PaymentHistory paymentHistory : params) {
                String qsny = paymentHistory.getQSNY();
                int qsnyNum = Integer.parseInt(qsny.substring(0, 4));
                float lx = calInterest(qsnyNum, currentYear, scale, paymentHistory.getGRJFE());
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
     * 修改单位中人员的缴费历史记录或插入缴费记录
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
        String dwid = request.getParameter("dwid");
        String infos = request.getParameter("infos");
        JSONArray jsonArray = new JSONArray(infos);
        ArrayList<PaymentHistory> updateParams = new ArrayList();
        ArrayList<PaymentHistory> insetParams = new ArrayList();
        for (int i = 0; i < jsonArray.length(); i++) {

            JSONObject jsonObject = jsonArray.getJSONObject(i);
            String flag = jsonObject.getString("flag");

            String qsny = jsonObject.getString("qsny");
            String zzny = jsonObject.getString("zzny");
            String ryid = jsonObject.getString("ryid");
            double dwjfjs = jsonObject.getDouble("dwjfjs");
            double dwjfe = jsonObject.getDouble("dwjfe");
            double lx = jsonObject.getDouble("lx");
            double dwjfze = jsonObject.getDouble("dwjfze");
            String zdlsh = jsonObject.getString("zdlsh");
            String jflsid = jsonObject.getString("jflsid");
            PaymentHistory paymentHistory = new PaymentHistory();
            if ("isUpate".equalsIgnoreCase(flag)) {
                paymentHistory.setQSNY(qsny);
                paymentHistory.setRYID(ryid);
                paymentHistory.setDWID(dwid);
                paymentHistory.setLX(lx);
                paymentHistory.setDWJFJS(dwjfjs);
                paymentHistory.setDWJFE(dwjfe);
                paymentHistory.setDWJFZE(dwjfze);
                paymentHistory.setZZNY(zzny);
                paymentHistory.setLX(lx);
                paymentHistory.setXGBZ(1);
                paymentHistory.setZDLSH(zdlsh);
                paymentHistory.setJFLSID(jflsid);
                updateParams.add(paymentHistory);
            } else {
                String fsrq = jsonObject.getString("fsrq");
                double dwjfbl = jsonObject.getDouble("dwjfbl");
                double grjfbl = jsonObject.getDouble("grjfbl");
                double grjfjs = jsonObject.getDouble("grjfbl");
                String jbjgid = jsonObject.getString("jbjgid");
                String jbr = jsonObject.getString("jbr");
                String jbsj = jsonObject.getString("jbsj");
                String jfrq = jsonObject.getString("jfrq");
                String bz = jsonObject.getString("bz");
                SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
                paymentHistory.setDWJFBL(dwjfbl);
                paymentHistory.setGRJFBL(grjfbl);
                paymentHistory.setGRJFJS(grjfjs);
                paymentHistory.setJBJGID(jbjgid);
                paymentHistory.setJBR(jbr);
                paymentHistory.setJBSJ(simpleDateFormat.parse(jbsj));
                paymentHistory.setFSRQ(simpleDateFormat.parse(fsrq));
                paymentHistory.setJFLSID(jflsid);
                paymentHistory.setJFRQ(simpleDateFormat.parse(jfrq));
                paymentHistory.setZDLSH(zdlsh);
                paymentHistory.setBZ(bz);
                paymentHistory.setQSNY(qsny);
                paymentHistory.setRYID(ryid);
                paymentHistory.setDWID(dwid);
                paymentHistory.setLX(lx);
                paymentHistory.setDWJFJS(dwjfjs);
                paymentHistory.setDWJFE(dwjfe);
                paymentHistory.setDWJFZE(dwjfze);
                paymentHistory.setZZNY(zzny);
                paymentHistory.setLX(lx);
                paymentHistory.setXGBZ(1);
                insetParams.add(paymentHistory);
            }
        }
        if (updateParams.size() > 0) {
            paymentHistoryMapper.modifyPaymentHistory(updateParams);
        }
        if (insetParams.size() > 0) {
            paymentHistoryMapper.addPaymentHistory(insetParams);
        }
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
            String ryid = request.getParameter("ryid");
            String infos = request.getParameter("infos");
            JSONArray jsonArray = new JSONArray(infos);
            ArrayList<PaymentHistory> params = new ArrayList();
            Calendar calendar = Calendar.getInstance();
            int currentYear = calendar.get(Calendar.YEAR);
            float scale = interestScaleMapper.queryInterestScale((String.valueOf(currentYear)).trim());
            for (int i = 0; i < jsonArray.length(); i++) {
                JSONObject jsonObject = jsonArray.getJSONObject(i);
                String qsny = jsonObject.getString("qsny");
                float payment = jsonObject.getFloat("payment");
                int qsnyNum = Integer.parseInt(qsny.substring(0, 4));

                float lx = calInterest(qsnyNum, currentYear, scale, payment);
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
        String sfzhm = request.getParameter("sfzhm");
        String qsrq = request.getParameter("qsrq");
        String zzrq = request.getParameter("zzrq");
        qsrq = qsrq.replace("-", "").trim();
        zzrq = zzrq.replace("-", "").trim();
        int countNum = Integer.parseInt(count);
        int pageNum = Integer.parseInt(page);
        String ryid = staffMapper.queryStaffBySFZHM(sfzhm);
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
            paymentHistory.setStaff(null);
            JSONObject object = new JSONObject(paymentHistory);
            jsonArray.put(object);

        }
        jsonObject.put("rows", jsonArray);
        jsonObject.put("ryid", ryid);
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
    public void queryCountWithoutInterestByRyid(HttpServletRequest request, HttpServletResponse response) throws IOException {
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
    public void queryCountWithoutInterestByRyidWithDate(HttpServletRequest request, HttpServletResponse response) throws IOException {
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
    public void rebackPaymentByRyIdWithDate(HttpServletRequest request, HttpServletResponse response) throws IOException {
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
        Staff staff = staffMapper.queryStaffByRyid(ryid);
        float amount = paymentHistoryMapper.queryAmountByRyidWithDate(ryid, qsrq, zzrq);
        String txr = request.getParameter("txr");
        Date date = new Date();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM");
        String dateStr = simpleDateFormat.format(date);
        String zdlsh = departmentBillMapper.queryZDLSH();
        departmentBillMapper.addRebackBill(zdlsh, staff.getDWID()
                , staff.getJBJGID(), txr, dateStr, txr, dateStr, amount, ryid);
        departmentBillMapper.addBillDel(zdlsh, "102", "AL1", qsrq, zzrq, amount);
        paymentHistoryMapper.rebackPaymentByRyId(ryid, qsrq, zzrq);

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
    public void queryCountWithInterestByRyid(HttpServletRequest request, HttpServletResponse response) throws IOException {
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
