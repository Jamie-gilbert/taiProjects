package com.springmvc_mybatis.mapper;

import org.apache.ibatis.annotations.Param;


public interface InterestScaleMapper {

    float queryInterestScale(@Param(value = "current_year") String currentYear);

    void addInterestScale(@Param(value = "current_year") String currentYear,
                          @Param(value = "interest_scale") float interest_scale);

    void modifyInterestScale(@Param(value = "current_year") String currentYear,
                             @Param(value = "interest_scale") float interest_scale);


}
