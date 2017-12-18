package com.springmvc_mybatis.mapper;

import com.springmvc_mybatis.bean.DepartmentHistory;
import com.springmvc_mybatis.bean.PaymentHistory;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.List;

public interface PaymentHistoryMapper {

    List<PaymentHistory> queryBillsWithoutInterest(@Param(value = "dwid") String dwid,
                                                   @Param(value = "pre") String pre,
                                                   @Param(value = "next") String next);

    List<PaymentHistory> queryBillsWithInterest(@Param(value = "dwid") String dwid,
                                                @Param(value = "pre") String pre,
                                                @Param(value = "next") String next);

    List<PaymentHistory> queryByRyid(@Param(value = "ryid") String dwid,
                                     @Param(value = "pre") String pre,
                                     @Param(value = "next") String next);


    List<PaymentHistory> queryInterestByRyid(@Param(value = "ryid") String dwid,
                                             @Param(value = "pre") String pre,
                                             @Param(value = "next") String next);

    List<PaymentHistory> queryByRyidWithDate(@Param(value = "ryid") String dwid,
                                             @Param(value = "qsrq") String qsrq,
                                             @Param(value = "zzrq") String zzrq,
                                             @Param(value = "pre") String pre,
                                             @Param(value = "next") String next);

    int queryCountByRyidWithDate(@Param(value = "ryid") String ryid,
                                 @Param(value = "qsrq") String qsrq,
                                 @Param(value = "zzrq") String zzrq);

    int queryCountWithoutInterest(@Param(value = "dwid") String dwid);
    int queryCountByDWID(@Param(value = "dwid") String dwid, @Param(value = "qsrq") String qsrq,
                                 @Param(value = "zzrq") String zzrq);

    int queryCountByDWIDWithSjly(@Param(value = "dwid") String dwid, @Param(value = "qsrq") String qsrq,
                         @Param(value = "zzrq") String zzrq, @Param(value = "sjly") String sjly);

    int queryCountWithInterest(@Param(value = "dwid") String dwid);

    int queryCountByRyid(@Param(value = "ryid") String ryid);


    void modifyInterest(@Param(value = "list") List<PaymentHistory> list);

    List<PaymentHistory> queryPaymentHisByRyids(
            @Param(value = "dwid") String dwid,
            @Param(value = "ryids") List<String> ryids);

    void modifyPaymentHistory(@Param(value = "list") ArrayList<PaymentHistory> list);

    void addPaymentHistory(@Param(value = "list") ArrayList<PaymentHistory> list);

    void modifyInterestByRyid(@Param(value = "list") ArrayList<PaymentHistory> list);


    void clearInterest(@Param(value = "dwid") String dwid,
                       @Param(value = "ryids") List<String> ryids);

    int queryCountWithoutInterestByRyid(@Param(value = "ryid") String ryid);


    int queryCountWithoutInterestByRyidWithDate(@Param(value = "ryid") String ryid,
                                                @Param(value = "qsrq") String qsrq,
                                                @Param(value = "zzrq") String zzrq);

    int rebackPaymentByRyId(@Param(value = "ryid") String ryid,
                            @Param(value = "list") List<PaymentHistory> list);

    float queryAmountByRyidWithDate(@Param(value = "ryid") String ryid,
                                    @Param(value = "list") List<String> qsrqs);


    int queryCountWithInterestByRyid(@Param(value = "ryid") String ryid);

    int queryCountByZDLSH(@Param(value = "zdlsh") String zdlsh);

    List<PaymentHistory> queryAllHistoryByDWID(
            @Param(value = "dwid") String dwid,
            @Param(value = "qsrq") String qsrq,
            @Param(value = "zzrq") String zzrq,
            @Param(value = "pre") String pre,
            @Param(value = "next") String next);

    List<PaymentHistory> queryAllHistoryByDWIDWithSjly(
            @Param(value = "dwid") String dwid,
            @Param(value = "qsrq") String qsrq,
            @Param(value = "zzrq") String zzrq,
            @Param(value = "sjly") String sjly,
            @Param(value = "pre") String pre,
            @Param(value = "next") String next);

    List<PaymentHistory> queryPaymentHisByZDLSH(
            @Param(value = "zdlsh") String zdlsh,
            @Param(value = "pre") String pre,
            @Param(value = "next") String next);

    void cancelInterestByRyid(@Param(value = "ryid") String ryid);

    List<PaymentHistory> queryAmountByZDLSH(@Param(value = "ryid") String ryid);

    void rebackPaymentByDWID(@Param(value = "dwid") String dwid);

    float calPaymentByDWID(@Param(value = "dwid") String dwid);

    int queryCountWithRebackByDWID(@Param(value = "dwid") String dwid);

    int queryAllDepartmentCount();

    int queryDepartmentCountWithReback();

    int queryDepartmentCountWithoutReback();

    List<DepartmentHistory> queryRebackHistory(@Param(value = "pre") String pre,
                                               @Param(value = "next") String next);

    List<DepartmentHistory> exportRebackHistory();

    List<DepartmentHistory> queryNoRebackHistory(@Param(value = "pre") String pre,
                                                 @Param(value = "next") String next);

    List<DepartmentHistory> exportNoRebackHistory();

    DepartmentHistory queryNobackHistoryByDWID(@Param(value = "dwid") String dwid);

    List<PaymentHistory> extportHistoryByDWID(@Param(value = "dwid") String dwid);

    void cancelBill(@Param(value = "dwid") String dwid);
}
