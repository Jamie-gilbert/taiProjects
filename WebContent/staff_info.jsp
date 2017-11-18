<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/23
  Time: 18:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>人员信息</title>
    <link rel="stylesheet" href="../css/bootstrap.css">

</head>
<body>
<a href="../paymentHistory/qyeryInterestByRyid.action?ryid=11100000000000008807&pageNumber=1&pageSize=10">个人计息</a>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-3 col-md-3">
            <div class="input-group">
                <span class="input-group-addon">个人编号:</span>
                <input type="text" class="form-control" id="grbh"/>
            </div>
        </div>
        <div class="col-xs-3 col-md-3">
            <div class="input-group">
                <span class="input-group-addon">个人姓名:</span>
                <input type="text" class="form-control" id="grxm"/>
            </div>
        </div>
        <div class="col-xs-3 col-md-3">
            <div class="input-group">
                <span class="input-group-addon">身份证号:</span>
                <input type="text" class="form-control" id="grsfzhm"/>
            </div>
        </div>
        <div class="col-xs-3 col-md-3">
            <button class="btn btn-primary" data-toggle="button" id="query_person">查询</button>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-3 col-md-3">
            <button class="btn btn-primary" onclick="setData()" data-toggle="modal" data-target="#exampleModal">修改
            </button>
        </div>
    </div>
</div>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" id="btnClose" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="exampleModalLabel">修改人员信息</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label>人员ID</label>
                        <input type="text" class="form-control" id="ryid" placeholder="人员ID">
                    </div>
                    <div class="form-group">
                        <label>人员登记ID</label>
                        <input type="text" class="form-control" id="rydjid" placeholder="人员登记ID">
                    </div>
                    <div class="form-group">
                        <label>财政编号</label>
                        <input type="text" class="form-control" id="czbm" placeholder="财政编号">
                    </div>
                    <div class="form-group">
                        <label>原个人编号</label>
                        <input type="text" class="form-control" id="ygrbh" placeholder="原个人编号">
                    </div>
                    <div class="form-group">
                        <label>经办机构ID</label>
                        <input type="text" class="form-control" id="jbjgid" placeholder="经办机构ID">
                    </div>
                    <div class="form-group">
                        <label>姓名</label>
                        <input type="text" class="form-control" id="xm" placeholder="姓名">
                    </div>

                    <div class="form-group">
                        <label>曾用名</label>
                        <input type="text" class="form-control" id="cym" placeholder="曾用名">
                    </div>

                    <div class="form-group">
                        <label>性别</label>
                        <input type="text" class="form-control" id="xb" placeholder="性别">
                    </div>
                    <div class="form-group">
                        <label>身份证号码</label>
                        <input type="text" class="form-control" id="sfzhm" placeholder="身份证号码">
                    </div>

                    <div class="form-group">
                        <label>出生日期</label>
                        <input type="text" class="form-control" id="csrq" placeholder="出生日期">
                    </div>

                    <div class="form-group">
                        <label>身份性质</label>
                        <input type="text" class="form-control" id="sfxz" placeholder="身份性质">
                    </div>

                    <div class="form-group">
                        <label>参保人员类别</label>
                        <input type="text" class="form-control" id="cbrylb" placeholder="参保人员类别">
                    </div>
                    <div class="form-group">
                        <label>民族</label>
                        <input type="text" class="form-control" id="mz" placeholder="民族">
                    </div>
                    <div class="form-group">
                        <label>投保类别</label>
                        <input type="text" class="form-control" id="tblb" placeholder="投保类别">
                    </div>

                    <div class="form-group">
                        <label>投保类别名称</label>
                        <input type="text" class="form-control" id="tblbmc" placeholder="投保类别名称">
                    </div>
                    <div class="form-group">
                        <label>参加工作时间</label>
                        <input type="text" class="form-control" id="cjgzsj" placeholder="参加工作时间">
                    </div>
                    <div class="form-group">
                        <label>经费来源</label>
                        <input type="text" class="form-control" id="jfly" placeholder="经费来源">
                    </div>
                    <div class="form-group">
                        <label>户口性质</label>
                        <input type="text" class="form-control" id="hkxz" placeholder="户口性质">
                    </div>
                    <div class="form-group">
                        <label>地址</label>
                        <input type="text" class="form-control" id="dz" placeholder="地址">
                    </div>
                    <div class="form-group">
                        <label>电话</label>
                        <input type="text" class="form-control" id="dh" placeholder="电话">
                    </div>
                    <div class="form-group">
                        <label>个人身份</label>
                        <input type="text" class="form-control" id="grsf" placeholder="个人身份">
                    </div>
                    <div class="form-group">
                        <label>入伍时间</label>
                        <input type="text" class="form-control" id="rwsj" placeholder="入伍时间">
                    </div>
                    <div class="form-group">
                        <label>调入时间</label>
                        <input type="text" class="form-control" id="drsj" placeholder="调入时间">
                    </div>
                    <div class="form-group">
                        <label>增员原因</label>
                        <input type="text" class="form-control" id="zyyy" placeholder="增员原因">
                    </div>
                    <div class="form-group">
                        <label>减员原因</label>
                        <input type="text" class="form-control" id="jyyy" placeholder="减员原因">
                    </div>
                    <div class="form-group">
                        <label>备注</label>
                        <input type="text" class="form-control" id="bz" placeholder="备注">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="save">保 存</button>
            </div>
        </div>
    </div>
</div>

<script src="../js/jquery.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/dialog.js"></script>
<script type="text/javascript">
    var currentList;
    var grbh;

    function setData() {

        //选择数据的坐标，在0到count之间
        var currentIndex = 0;
        grbh = currentList[currentIndex].GRBH;
        $("#xm").val(currentList[currentIndex].XM);
        $("#cym").val(currentList[currentIndex].CYM);
        $("#xb").val(currentList[currentIndex].XB);
        $("#sfzhm").val(currentList[currentIndex].SFZHM);
        $("#csrq").val(currentList[currentIndex].CSRQ);
        $("#sfxz").val(currentList[currentIndex].SFXZ);
        $("#cbrylb").val(currentList[currentIndex].cbrylb);
        $("#mz").val(currentList[currentIndex].MZ);
        $("#tblb").val(currentList[currentIndex].TBLB);
        $("#tblbmc").val(currentList[currentIndex].TBLBMC);
        $("#cjgzsj").val(currentList[currentIndex].CJGZSJ);
        $("#jfly").val(currentList[currentIndex].JFLY);
        $("#hkxz").val(currentList[currentIndex].HKXZ);
        $("#dz").val(currentList[currentIndex].DZ);
        $("#dh").val(currentList[currentIndex].DH);
        $("#grsf").val(currentList[currentIndex].GRSF);
        $("#rwsj").val(currentList[currentIndex].RWSJ);
        $("#drsj").val(currentList[currentIndex].DRSJ);
        $("#zyyy").val(currentList[currentIndex].ZYYY);
        $("#jyyy").val(currentList[currentIndex].JYYY);
        $("#bz").val(currentList[currentIndex].BZ);
        $("#ryid").val(currentList[currentIndex].RYID);
        $("#rydjid").val(currentList[currentIndex].RYDJID);
        $("#czbm").val(currentList[currentIndex].CZBM);
        $("#ygrbh").val(currentList[currentIndex].YGRBH);
        $("#jbjgid").val(currentList[currentIndex].JBJGID);
    };
    $("#query_person").click(function () {
        getStaff();
    });

    function getStaff() {
        var page = 1;
        var count = 10;
        var grbh = $("#grbh").val();
        var grxm = $("#grxm").val();
        var grsfzhm = $("#grsfzhm").val();
        $.ajax({
            type: "POST",
            url: "staff/queryStaffInfo.action",
            data: {
                "grsfzhm": grsfzhm, "page": page,
                "count": count, "grbh": grbh, "grxm": grxm
            },
            async: false,
            dataType: "JSON",
            success: function (data, status) {
                currentList = data.data;
                console.log(data.data);
            },
            error: function (err, status) {
                console.log(err);
            }
        });
    }


    $("#save").click(function () {

        var xm = $("#xm").val();
        var cym = $("#cym").val();
        var xb = $("#xb").val();
        var sfzhm = $("#sfzhm").val();
        var csrq = $("#csrq").val();
        var sfxz = $("#sfxz").val();
        var cbrylb = $("#cbrylb").val();
        var mz = $("#mz").val();
        var tblb = $("#tblb").val();
        var tblbmc = $("#tblbmc").val();
        var cjgzsj = $("#cjgzsj").val();
        var jfly = $("#jfly").val();
        var hkxz = $("#hkxz").val();
        var dz = $("#dz").val();
        var dh = $("#dh").val();
        var grsf = $("#grsf").val();
        var rwsj = $("#rwsj").val();
        var drsj = $("#drsj").val();
        var zyyy = $("#zyyy").val();
        var jyyy = $("#jyyy").val();
        var bz = $("#bz").val();
        var ryid = $("#ryid").val();
        var rydjid = $("#rydjid").val();
        var czbm = $("#czbm").val();
        var ygrbh = $("#ygrbh").val();
        var jbjgid = $("#jbjgid").val();


        $.ajax({
            type: "POST",
            url: "staff/modifyStaff.action",
            data: {
                "xm": xm, "cym": cym, "xb": xb, "sfzhm": sfzhm, "csrq": csrq
                , "sfxz": sfxz, "cbrylb": cbrylb, "mz": mz, "tblb": tblb, "tblbmc": tblbmc,
                "cjgzsj": cjgzsj, "jfly": jfly, "hkxz": hkxz, "dz": dz, "dh": dh,
                "grsf": grsf, "rwsj": rwsj, "drsj": drsj, "zyyy": zyyy, "jyyy": jyyy, "bz": bz,
                "cbrylb": cbrylb, "ryid": ryid, "rydjid": rydjid, "czbm": czbm,
                "ygrbh": ygrbh, "jbjgid": jbjgid, "grbh": grbh
            },
            dataType: "JSON",
            async: false,
            success: function (data, status) {
                Alert({
                    msg: '修改成功',
                    title: "提示",
                    onOk: function () {
                        $('#exampleModal').modal('hide');
                    },

                })
            },
            error: function (err, status) {
                Alert({
                    msg: '添加人员失败，请重试',
                    title: "提示",


                })
            }
        });

    });


</script>
</body>
</html>
