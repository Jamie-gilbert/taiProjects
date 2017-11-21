package com.springmvc_mybatis.bean;

import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

public class PaymentHistory implements Serializable {
    private String JFLSID;
    private String RYID;
    private String RYDJID;
    private String DWID;
    private String XZBZ;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date FSRQ;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date JFRQ;
    private String QSNY;
    private String ZZNY;
    private double DWJFJS;
    private double GRJFJS;
    private double DWJFBL;
    private double GRJFBL;
    private double DWJFE;
    private double GRJFE;
    private double DWJFZE;
    private double GRJFZE;
    private double ZJE;
    private String ZDLSH;
    private String JBJGID;
    private String BZ;
    private String JBR;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date JBSJ;
    private double LX;
    private double lxs;
    private double grjfes;
    private double dwjfes;

    private Staff staff;
    private int FSYY;

    public int getFSYY() {
        return FSYY;
    }

    public void setFSYY(int FSYY) {
        this.FSYY = FSYY;
    }

    public String getJFLSID() {
        return JFLSID;
    }

    public void setJFLSID(String JFLSID) {
        this.JFLSID = JFLSID;
    }

    public String getRYID() {
        return RYID;
    }

    public void setRYID(String RYID) {
        this.RYID = RYID;
    }

    public String getRYDJID() {
        return RYDJID;
    }

    public void setRYDJID(String RYDJID) {
        this.RYDJID = RYDJID;
    }

    public String getDWID() {
        return DWID;
    }

    public void setDWID(String DWID) {
        this.DWID = DWID;
    }

    public String getXZBZ() {
        return XZBZ;
    }

    public void setXZBZ(String XZBZ) {
        this.XZBZ = XZBZ;
    }

    public Date getFSRQ() {
        return FSRQ;
    }

    public void setFSRQ(Date FSRQ) {
        this.FSRQ = FSRQ;
    }

    public Date getJFRQ() {
        return JFRQ;
    }

    public void setJFRQ(Date JFRQ) {
        this.JFRQ = JFRQ;
    }

    public String getQSNY() {
        return QSNY;
    }

    public void setQSNY(String QSNY) {
        this.QSNY = QSNY;
    }

    public String getZZNY() {
        return ZZNY;
    }

    public void setZZNY(String ZZNY) {
        this.ZZNY = ZZNY;
    }

    public double getDWJFJS() {
        return DWJFJS;
    }

    public void setDWJFJS(double DWJFJS) {
        this.DWJFJS = DWJFJS;
    }

    public double getGRJFJS() {
        return GRJFJS;
    }

    public void setGRJFJS(double GRJFJS) {
        this.GRJFJS = GRJFJS;
    }

    public double getDWJFBL() {
        return DWJFBL;
    }

    public void setDWJFBL(double DWJFBL) {
        this.DWJFBL = DWJFBL;
    }

    public double getGRJFBL() {
        return GRJFBL;
    }

    public void setGRJFBL(double GRJFBL) {
        this.GRJFBL = GRJFBL;
    }

    public double getDWJFE() {
        return DWJFE;
    }

    public void setDWJFE(double DWJFE) {
        this.DWJFE = DWJFE;
    }

    public double getGRJFE() {
        return GRJFE;
    }

    public void setGRJFE(double GRJFE) {
        this.GRJFE = GRJFE;
    }

    public double getDWJFZE() {
        return DWJFZE;
    }

    public void setDWJFZE(double DWJFZE) {
        this.DWJFZE = DWJFZE;
    }

    public double getGRJFZE() {
        return GRJFZE;
    }

    public void setGRJFZE(double GRJFZE) {
        this.GRJFZE = GRJFZE;
    }

    public String getZDLSH() {
        return ZDLSH;
    }

    public void setZDLSH(String ZDLSH) {
        this.ZDLSH = ZDLSH;
    }

    public String getJBJGID() {
        return JBJGID;
    }

    public void setJBJGID(String JBJGID) {
        this.JBJGID = JBJGID;
    }

    public String getBZ() {
        return BZ;
    }

    public void setBZ(String BZ) {
        this.BZ = BZ;
    }

    public String getJBR() {
        return JBR;
    }

    public void setJBR(String JBR) {
        this.JBR = JBR;
    }

    public Date getJBSJ() {
        return JBSJ;
    }

    public void setJBSJ(Date JBSJ) {
        this.JBSJ = JBSJ;
    }

    public double getLX() {
        return LX;
    }

    public void setLX(double LX) {
        this.LX = LX;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }


    public double getZJE() {
        return ZJE;
    }

    public void setZJE(double ZJE) {
        this.ZJE = ZJE;
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

    public double getDwjfes() {
        return dwjfes;
    }

    public void setDwjfes(double dwjfes) {
        this.dwjfes = dwjfes;
    }
}
