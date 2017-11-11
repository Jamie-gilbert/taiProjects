package com.springmvc_mybatis.mapper;

import com.springmvc_mybatis.bean.PaymentHistory;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface PaymentHistoryMapper {

    List<PaymentHistory> queryBillsWithoutInterest(@Param(value = "dwid") String dwid,
                                                   @Param(value = "pre") String pre,
                                                   @Param(value = "next") String next);

    List<PaymentHistory> queryBillsWithInterest(@Param(value = "dwid") String dwid,
                                                @Param(value = "pre") String pre,
                                                @Param(value = "next") String next);

    int queryCountWithoutInterest(@Param(value = "dwid") String dwid);
    int queryCountWithInterest(@Param(value = "dwid") String dwid);

    void modifyInterest(@Param(value = "dwid") String dwid,
                        @Param(value = "lx") float lx,
                        @Param(value = "ryids") List<String> ryids);

    void clearInterest(@Param(value = "dwid") String dwid,
                       @Param(value = "ryids") List<String> ryids);

}
