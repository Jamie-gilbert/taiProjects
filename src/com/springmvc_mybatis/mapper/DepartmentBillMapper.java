package com.springmvc_mybatis.mapper;

import com.springmvc_mybatis.bean.DepartmentBill;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;


public interface DepartmentBillMapper {

    List<DepartmentBill> queryBills(@Param(value = "dwid") String dwid,
                                    @Param(value = "txsj") String time,
                                    @Param(value = "djzt") String type,
                                    @Param(value = "pre") String pre,
                                    @Param(value = "next") String next);

    int queryCount(@Param(value = "dwid") String dwid,
                   @Param(value = "txsj") String time,
                   @Param(value = "djzt") String type);

    void modifyStatusByZDLSH(@Param("zdlsh") String zdlsh,
                            @Param("dwid") String dwid,
                            @Param("djzt") String djzt);

    void addRebackBill(@Param(value = "zdlsh") String zdlsh,
                       @Param(value = "dwid") String dwid,
                       @Param(value = "jbjgid") String jbjgid,
                       @Param(value = "txr") String txr,
                       @Param(value = "txsj") String txsj,
                       @Param(value = "qrr") String qrr,
                       @Param(value = "qrsj") String qrsj,
                       @Param(value = "zje") float zje,
                       @Param(value = "ryid") String ryid
    );

    void addBillDel(@Param(value = "zdlsh") String zdlsh,
                    @Param(value = "xzbz") String xzbz,
                    @Param(value = "jfxmbh") String jfxmbh,
                    @Param(value = "qsny") String qsny,
                    @Param(value = "zzny") String zzny,
                    @Param(value = "jfje") float jfje
    );

    String queryZDLSH();

    List<DepartmentBill> queryBillsByRyid(@Param(value = "ryid") String ryid,
                                          @Param(value = "pre") String pre,
                                          @Param(value = "next") String next);

    int queryCountByRyid(@Param(value = "ryid") String ryid);

    void rebackPaymentByDWID(@Param(value = "bill") DepartmentBill departmentBill);
}
