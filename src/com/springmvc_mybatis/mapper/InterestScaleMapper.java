package com.springmvc_mybatis.mapper;

import com.springmvc_mybatis.bean.InterestScale;
import org.apache.ibatis.annotations.Param;

import java.util.List;


public interface InterestScaleMapper {

    float queryInterestScale(@Param(value = "current_year") String currentYear);

    List<InterestScale> queryAllInterestScales();

    void addInterestScale(@Param(value = "current_year") String currentYear,
                          @Param(value = "interest_scale") float interest_scale);

    void modifyInterestScale(@Param(value = "current_year") String currentYear,
                             @Param(value = "interest_scale") float interest_scale);


}
