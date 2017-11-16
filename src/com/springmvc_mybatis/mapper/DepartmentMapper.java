package com.springmvc_mybatis.mapper;

import com.springmvc_mybatis.bean.Department;
import com.springmvc_mybatis.bean.User;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;


public interface DepartmentMapper {

    //value 必须与Bean 属性一致！
    List<Department> queryByKey(@Param(value = "dwbh") String dwbh,
                                @Param(value = "dwmc") String dwmc,
                                @Param(value = "dwmcpy") String dwmcpy,
                                @Param(value = "pre") String pre,
                                @Param(value = "next") String next);

    int queryCountByKey(@Param(value = "dwbh") String dwbh,
                        @Param(value = "dwmc") String dwmc,
                        @Param(value = "dwmcpy") String dwmcpy);

    Department queryByDWID(@Param(value = "dwid") String dwid);

    String modifyDepartment(@Param(value = "dwid") String dwid,
                            @Param(value = "dwmc") String dwmc,
                            @Param(value = "tblb") String tblb,
                            @Param(value = "tblbmc") String tblbmc);


}
