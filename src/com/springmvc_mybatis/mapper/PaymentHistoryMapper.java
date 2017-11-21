package com.springmvc_mybatis.mapper;

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
                            @Param(value = "list") List<String> qsrqs);

    float queryAmountByRyidWithDate(@Param(value = "ryid") String ryid,
                                    @Param(value = "list") List<String> qsrqs);


    int queryCountWithInterestByRyid(@Param(value = "ryid") String ryid);

    int queryCountByZDLSH(@Param(value = "zdlsh") String zdlsh);

    List<PaymentHistory> queryPaymentHisByZDLSH(
            @Param(value = "zdlsh") String zdlsh,
            @Param(value = "pre") String pre,
            @Param(value = "next") String next);


    void cancelInterestByRyid(@Param(value = "ryid") String ryid);
}
