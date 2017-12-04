package com.springmvc_mybatis.bean;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class DepartmentBill implements Serializable {
    private String jbjgid;
    private String zdlsh;
    private String dwid;
    private String djzt;
    private String djlb;
    private String txr;

    private String txsj;
    private String qrr;

    private String qrsj;
    private double zje;
    private String bz;
    private String ryid;

    public String getJbjgid() {
        return jbjgid;
    }

    public void setJbjgid(String jbjgid) {
        this.jbjgid = jbjgid;
    }

    public String getZdlsh() {
        return zdlsh;
    }

    public void setZdlsh(String zdlsh) {
        this.zdlsh = zdlsh;
    }

    public String getDwid() {
        return dwid;
    }

    public void setDwid(String dwid) {
        this.dwid = dwid;
    }

    public String getDjzt() {
        return djzt;
    }

    public void setDjzt(String djzt) {
        this.djzt = djzt;
    }

    public String getDjlb() {
        return djlb;
    }

    public void setDjlb(String djlb) {
        this.djlb = djlb;
    }

    public String getTxr() {
        return txr;
    }

    public void setTxr(String txr) {
        this.txr = txr;
    }

    public String getTxsj() {
        return txsj;
    }

    public void setTxsj(String txsj) {
        this.txsj = txsj;
    }

    public String getQrsj() {
        return qrsj;
    }

    public void setQrsj(String qrsj) {
        this.qrsj = qrsj;
    }

    public String getQrr() {
        return qrr;
    }

    public void setQrr(String qrr) {
        this.qrr = qrr;
    }

    public String getRyid() {
        return ryid;
    }

    public void setRyid(String ryid) {
        this.ryid = ryid;
    }

    public double getZje() {
        return zje;
    }

    public void setZje(double zje) {
        this.zje = zje;
    }

    public String getBz() {
        return bz;
    }

    public void setBz(String bz) {
        this.bz = bz;
    }
}
