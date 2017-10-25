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
    <title>人员</title>
    <link rel="stylesheet" href="../css/bootstrap.css">

</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-4 col-md-4">
            <button id="officer" class="btn btn-primary" data-toggle="button">在职人员</button>
        </div>
        <div class="col-xs-4 col-md-4">
            <button id="retiree" class="btn btn-primary" data-toggle="button">退休人员</button>
        </div>
        <div class="col-xs-4 col-md-4">
            <button id="unemployed" class="btn btn-primary" data-toggle="button">离职人员</button>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-4 col-md-4">
            <button id="add_staff" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">添加人员</button>
        </div>
    </div>
</div>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" id="btnClose" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="exampleModalLabel">添加人员</h4>
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
                <button type="button" class="btn btn-default" id="clear">清 空</button>
                <button type="button" class="btn btn-primary" id="save">保 存</button>
            </div>
        </div>
    </div>
</div>

<script src="../js/jquery.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/dialog.js"></script>
<script type="text/javascript">
    var type = "";
    var dwid = <%=request.getParameter("dwid")%>;
    var page = 1;
    var count = 10;
    $("#officer").click(function () {
        type = "AOA";
        getStaff();
    });
    $("#retiree").click(function () {
        type = "AOC";
        getStaff();
    });

    $("#unemployed").click(function () {

        type = "AOF";
        getStaff();
    });


    function getStaff() {
        $.ajax({
            type: "POST",
            url: "staff/queryStaff.action",
            data: {"dwid": dwid, "page": page, "count": count, "type": type},
            async: false,
            dataType: "JSON",
            success: function (data, status) {
                console.log(data);
            },
            error: function (err, status) {
                console.log(err);
            }
        });
    }

    $("#clear").click(function () {

        $("#xm").val("");
        $("#cym").val("");
        $("#xb").val("");
        $("#sfzhm").val("");
        $("#csrq").val("");
        $("#sfxz").val("");
        $("#cbrylb").val("");
        $("#mz").val("");
        $("#tblb").val("");
        $("#tblbmc").val("");
        $("#cjgzsj").val("");
        $("#jfly").val("");
        $("#hkxz").val("");
        $("#dz").val("");
        $("#dh").val("");
        $("#grsf").val("");
        $("#rwsj").val("");
        $("#drsj").val("");
        $("#zyyy").val("");
        $("#jyyy").val("");
        $("#bz").val("");
        $("#ryid").val("");
        $("#rydjid").val("");
        $("#czbm").val("");
        $("#ygrbh").val("");
        $("#jbjgid").val("");
    });
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
            url: "staff/saveStaff.action",
            data: {
                "xm": xm, "cym": cym, "xb": xb, "sfzhm": sfzhm, "csrq": csrq
                , "sfxz": sfxz, "cbrylb": cbrylb, "mz": mz, "tblb": tblb, "tblbmc": tblbmc,
                "cjgzsj": cjgzsj, "jfly": jfly, "hkxz": hkxz, "dz": dz, "dh": dh,
                "grsf": grsf, "rwsj": rwsj, "drsj": drsj, "zyyy": zyyy, "jyyy": jyyy, "bz": bz,
                "dwid": dwid, "cbrylb": type, "ryid": ryid, "rydjid": rydjid, "czbm": czbm,
                "ygrbh": ygrbh, "jbjgid": jbjgid
            },
            dataType: "JSON",
            async: false,
            success: function (data, status) {
                Alert({
                    msg: '保存成功',
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
