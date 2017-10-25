package com.springmvc_mybatis.mapper;

import com.springmvc_mybatis.bean.Department;
import com.springmvc_mybatis.bean.DepartmentBill;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface DepartmentBillMapper {

    //value 必须与Bean 属性一致！
    List<DepartmentBill> queryBills(@Param(value = "dwid") String dwid,
                                    @Param(value = "txsj") String time,
                                    @Param(value = "djzt") String type,
                                    @Param(value = "pre") String pre,
                                    @Param(value = "next") String next);


}
