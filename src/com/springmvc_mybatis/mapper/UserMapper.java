package com.springmvc_mybatis.mapper;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.springmvc_mybatis.bean.User;

//userMapper只能传入一个参数,多个的话需要注解
public interface UserMapper {

    //value 必须与Bean 属性一致！
    User login(@Param(value = "yhbh") String name,
               @Param(value = "kl") String password);

    void register(
            @Param(value = "yhbh") String yhbh,
            @Param(value = "kl") String password,
            @Param(value = "yhxm") String yhxm,
            @Param(value = "sfzhm") String sfzhm,
            @Param(value = "xb") String xb,
            @Param(value = "lxdh") String lxdh,
            @Param(value = "jbjgid") String jbjgid,
            @Param(value = "jbr") String jbr,
            @Param(value = "jbsj") Date jbsj,
            @Param(value = "bz") String bz);


    List<User> getAllUsers();
}
