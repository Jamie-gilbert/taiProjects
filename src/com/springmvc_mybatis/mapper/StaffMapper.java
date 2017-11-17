package com.springmvc_mybatis.mapper;

import com.springmvc_mybatis.bean.Staff;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StaffMapper {
    List<Staff> queryStaff(@Param(value = "dwid") String dwid,
                           @Param(value = "cbrylb") String cbrylb,
                           @Param(value = "pre") String pre,
                           @Param(value = "next") String next);

    int queryCount(@Param(value = "dwid") String dwid,
                   @Param(value = "cbrylb") String cbrylb);

    List<Staff> queryStaffInfo(@Param(value = "GRBH") String GRBH,
                               @Param(value = "SFZHM") String SFZHM,
                               @Param(value = "XM") String XM,
                               @Param(value = "XMPY") String XMPY,
                               @Param(value = "pre") String pre,
                               @Param(value = "next") String next);

    String queryStaffBySFZHM(@Param(value = "sfzhm") String sfzhm);

    void saveStaff(@Param(value = "xm") String xm,
                   @Param(value = "cym") String cym,
                   @Param(value = "dwid") String dwid,
                   @Param(value = "cbrylb") String cbrylb,
                   @Param(value = "xb") String xb,
                   @Param(value = "sfzhm") String sfzhm,
                   @Param(value = "csrq") String csrq,
                   @Param(value = "sfxz") String sfxz,
                   @Param(value = "mz") String mz,
                   @Param(value = "tblb") String tblb,
                   @Param(value = "tblbmc") String tblbmc,
                   @Param(value = "cjgzsj") String cjgzsj,
                   @Param(value = "jfly") String jfly,
                   @Param(value = "hkxz") String hkxz,
                   @Param(value = "dz") String dz,
                   @Param(value = "dh") String dh,
                   @Param(value = "grsf") String grsf,
                   @Param(value = "rwsj") String rwsj,
                   @Param(value = "drsj") String drsj,
                   @Param(value = "zyyy") String zyyy,
                   @Param(value = "jyyy") String jyyy,
                   @Param(value = "czbm") String czbm,
                   @Param(value = "jbjgid") String jbjgid,
                   @Param(value = "xmpy") String xmpy,
                   @Param(value = "bz") String bz);

    void modifyStaff(@Param(value = "xm") String xm,
                     @Param(value = "cym") String cym,
                     @Param(value = "cbrylb") String cbrylb,
                     @Param(value = "xb") String xb,
                     @Param(value = "sfzhm") String sfzhm,
                     @Param(value = "csrq") String csrq,
                     @Param(value = "sfxz") String sfxz,
                     @Param(value = "mz") String mz,
                     @Param(value = "tblb") String tblb,
                     @Param(value = "tblbmc") String tblbmc,
                     @Param(value = "cjgzsj") String cjgzsj,
                     @Param(value = "jfly") String jfly,
                     @Param(value = "hkxz") String hkxz,
                     @Param(value = "dz") String dz,
                     @Param(value = "dh") String dh,
                     @Param(value = "grsf") String grsf,
                     @Param(value = "rwsj") String rwsj,
                     @Param(value = "drsj") String drsj,
                     @Param(value = "zyyy") String zyyy,
                     @Param(value = "jyyy") String jyyy,
                     @Param(value = "ryid") String ryid,
                     @Param(value = "rydjid") String rydjid,
                     @Param(value = "czbm") String czbm,
                     @Param(value = "ygrbh") String ygrbh,
                     @Param(value = "grbh") String grbh,
                     @Param(value = "jbjgid") String jbjgid,
                     @Param(value = "xmpy") String xmpy,
                     @Param(value = "bz") String bz);

    Staff queryStaffByRyid(@Param(value = "ryid") String ryid);

}
