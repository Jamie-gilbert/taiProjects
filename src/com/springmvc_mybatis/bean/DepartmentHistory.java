package com.springmvc_mybatis.bean;

import java.io.Serializable;

public class DepartmentHistory  implements Serializable {

    private String dwid;
    private String dwmc;
    private double zje;
    private double lxs;
    private double grjfes;


    public String getDwid() {
        return dwid;
    }

    public void setDwid(String dwid) {
        this.dwid = dwid;
    }

    public String getDwmc() {
        return dwmc;
    }

    public void setDwmc(String dwmc) {
        this.dwmc = dwmc;
    }

    public double getZje() {
        return zje;
    }

    public void setZje(double zje) {
        this.zje = zje;
    }

    public double getLxs() {
        return lxs;
    }

    public void setLxs(double lxs) {
        this.lxs = lxs;
    }

    public double getGrjfes() {
        return grjfes;
    }

    public void setGrjfes(double grjfes) {
        this.grjfes = grjfes;
    }
}
