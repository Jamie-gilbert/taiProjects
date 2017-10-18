package com.springmvc_mybatis.bean;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

public class User implements Serializable{
	private String yhid;
	private String yhbh;
	private String yhxm;
	private String kl;
	private String sfzhm;
	private String xb;
	private String lxdh;
	private String jbjgid;
	private String jbr;
	@DateTimeFormat(pattern="yyyy-MM-dd")
	private Date jbsj;
	private String bz;

	public User() {
		super();
	}

	public User(String yhbh, String kl) {
		this.yhbh = yhbh;
		this.kl = kl;
	}

	public User(String yhid, String yhbh, String yhxm, String kl, String sfzhm, String xb, String lxdh, String jbjgid, String jbr, Date jbsj, String bz) {
		this.yhid = yhid;
		this.yhbh = yhbh;
		this.yhxm = yhxm;
		this.kl = kl;
		this.sfzhm = sfzhm;
		this.xb = xb;
		this.lxdh = lxdh;
		this.jbjgid = jbjgid;
		this.jbr = jbr;
		this.jbsj = jbsj;
		this.bz = bz;
	}

	public String getYhid() {
		return yhid;
	}

	public void setYhid(String yhid) {
		this.yhid = yhid;
	}

	public String getYhbh() {
		return yhbh;
	}

	public void setYhbh(String yhbh) {
		this.yhbh = yhbh;
	}

	public String getYhxm() {
		return yhxm;
	}

	public void setYhxm(String yhxm) {
		this.yhxm = yhxm;
	}

	public String getKl() {
		return kl;
	}

	public void setKl(String kl) {
		this.kl = kl;
	}

	public String getSfzhm() {
		return sfzhm;
	}

	public void setSfzhm(String sfzhm) {
		this.sfzhm = sfzhm;
	}

	public String getXb() {
		return xb;
	}

	public void setXb(String xb) {
		this.xb = xb;
	}

	public String getLxdh() {
		return lxdh;
	}

	public void setLxdh(String lxdh) {
		this.lxdh = lxdh;
	}

	public String getJbjgid() {
		return jbjgid;
	}

	public void setJbjgid(String jbjgid) {
		this.jbjgid = jbjgid;
	}

	public String getJbr() {
		return jbr;
	}

	public void setJbr(String jbr) {
		this.jbr = jbr;
	}

	public Date getJbsj() {
		return jbsj;
	}

	public void setJbsj(Date jbsj) {
		this.jbsj = jbsj;
	}

	public String getBz() {
		return bz;
	}

	public void setBz(String bz) {
		this.bz = bz;
	}

	@Override
	public String toString() {
		return "User{" +
				"yhid='" + yhid + '\'' +
				", yhbh='" + yhbh + '\'' +
				", yhxm='" + yhxm + '\'' +
				", kl='" + kl + '\'' +
				", sfzhm='" + sfzhm + '\'' +
				", xb='" + xb + '\'' +
				", lxdh='" + lxdh + '\'' +
				", jbjgid='" + jbjgid + '\'' +
				", jbr='" + jbr + '\'' +
				", jbsj=" + jbsj +
				", bz='" + bz + '\'' +
				'}';
	}
}
