package com.springmvc_mybatis.mapper;

import com.springmvc_mybatis.bean.DepartmentBill;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;


public interface DepartmentBillMapper {

    List<DepartmentBill> queryBills(@Param(value = "dwid") String dwid,
                                    @Param(value = "txsj") Date time,
                                    @Param(value = "djzt") String type,
                                    @Param(value = "pre") String pre,
                                    @Param(value = "next") String next);

    int queryCount(@Param(value = "dwid") String dwid,
                   @Param(value = "txsj") Date time,
                   @Param(value = "djzt") String type);

    void addRebackBill(
            @Param(value = "zdlsh") String zdlsh,
            @Param(value = "dwid") String dwid,
            @Param(value = "jbjgid") String jbjgid,
            @Param(value = "txr") String txr,
            @Param(value = "txsj") String txsj,
            @Param(value = "qrr") String qrr,
            @Param(value = "qrsj") String qrsj,
            @Param(value = "zje") float zje,
            @Param(value = "ryid") String ryid
    );

}
