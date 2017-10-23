package com.springmvc_mybatis.bean;

import java.io.Serializable;

public class Department implements Serializable {
    private String dwid;
    private String dwbh;
    private String dwmc;
    private String jbjgid;
    private String tblb;
    private String tblbmc;
    private String dwmcpy;

    public Department() {
        super();
    }

    public Department(String dwid, String dwbh, String dwmc, String jbjgid, String tblb, String tblbmc, String dwmcpy) {
        this.dwid = dwid;
        this.dwbh = dwbh;
        this.dwmc = dwmc;
        this.jbjgid = jbjgid;
        this.tblb = tblb;
        this.tblbmc = tblbmc;
        this.dwmcpy = dwmcpy;
    }

    public String getDwid() {
        return dwid;
    }

    public void setDwid(String dwid) {
        this.dwid = dwid;
    }

    public String getDwbh() {
        return dwbh;
    }

    public void setDwbh(String dwbh) {
        this.dwbh = dwbh;
    }

    public String getDwmc() {
        return dwmc;
    }

    public void setDwmc(String dwmc) {
        this.dwmc = dwmc;
    }

    public String getJbjgid() {
        return jbjgid;
    }

    public void setJbjgid(String jbjgid) {
        this.jbjgid = jbjgid;
    }

    public String getTblb() {
        return tblb;
    }

    public void setTblb(String tblb) {
        this.tblb = tblb;
    }

    public String getTblbmc() {
        return tblbmc;
    }

    public void setTblbmc(String tblbmc) {
        this.tblbmc = tblbmc;
    }

    public String getDwmcpy() {
        return dwmcpy;
    }

    public void setDwmcpy(String dwmcpy) {
        this.dwmcpy = dwmcpy;
    }

    @Override
    public String toString() {
        return "Department{" +
                "dwid='" + dwid + '\'' +
                ", dwbh='" + dwbh + '\'' +
                ", dwmc='" + dwmc + '\'' +
                ", jbjgid='" + jbjgid + '\'' +
                ", tblb='" + tblb + '\'' +
                ", tblbmc='" + tblbmc + '\'' +
                ", dwmcpy='" + dwmcpy + '\'' +
                '}';
    }
}
