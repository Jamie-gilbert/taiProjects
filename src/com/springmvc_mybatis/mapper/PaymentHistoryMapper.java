package com.springmvc_mybatis.mapper;

import com.springmvc_mybatis.bean.PaymentHistory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PaymentHistoryMapper {

    List<PaymentHistory> queryBillsWithoutInterest(@Param(value = "dwid") String dwid,
                                           @Param(value = "pre") String pre,
                                           @Param(value = "next") String next);
}
