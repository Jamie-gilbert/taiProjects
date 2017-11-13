package com.springmvc_mybatis.mapper;

import com.springmvc_mybatis.bean.DepartmentBill;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

/**
 * 暂时不用
 */
public interface StaffBillMapper {

    List<DepartmentBill> queryBills(@Param(value = "dwid") String dwid,
                                    @Param(value = "txsj") Date time,
                                    @Param(value = "djzt") String type,
                                    @Param(value = "pre") String pre,
                                    @Param(value = "next") String next);

    int queryCount(@Param(value = "dwid") String dwid,
                   @Param(value = "txsj") Date time,
                   @Param(value = "djzt") String type);


}
