package com.springmvc_mybatis.mapper;

import com.springmvc_mybatis.bean.Staff;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StaffMapper {
    List<Staff> queryStaff(@Param(value = "dwid") String dwid,
                           @Param(value = "cbrylb") String cbrylb,
                           @Param(value = "pre") String pre,
                           @Param(value = "next") String next);
}
