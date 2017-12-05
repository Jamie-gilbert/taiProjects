package com.springmvc_mybatis.mapper;

import com.springmvc_mybatis.bean.CodeConfig;
import com.springmvc_mybatis.bean.DepartmentBill;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface CodeConfigMapper {

    List<CodeConfig> queryAllCode();

}
