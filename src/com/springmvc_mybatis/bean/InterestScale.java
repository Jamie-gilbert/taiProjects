package com.springmvc_mybatis.bean;

import java.io.Serializable;

public class InterestScale  implements Serializable {
    private String current_year;
    private float interest_scale;

    public String getCurrent_year() {
        return current_year;
    }

    public void setCurrent_year(String current_year) {
        this.current_year = current_year;
    }

    public float getInterest_scale() {
        return interest_scale;
    }

    public void setInterest_scale(float interest_scale) {
        this.interest_scale = interest_scale;
    }
}
