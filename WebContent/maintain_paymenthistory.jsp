<%--
  Created by IntelliJ IDEA.
  User: ggg
  Date: 2017/11/12
  Time: 18:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>人员退费</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="bootstrap-table/bootstrap-table.css" type="text/css">
    <link rel="stylesheet" href="bootstrap/css/bootstrap-datetimepicker.min.css" type="text/css">
    <link rel="stylesheet" href="../x-editable/dist/bootstrap3-editable/css/bootstrap-editable.css">

</head>
<body>
<%@include file="pcommonTop.jsp"%>
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
                <span class="input-group-addon">起始日期:</span>
                <input type="month" class="form-control" id="qsrq"/>
            </div>
        </div>
        <div class="col-xs-3 col-md-3">
            <div class="input-group">
                <span class="input-group-addon">终止日期:</span>
                <input type="month" class="form-control" id="zzrq"/>
            </div>
        </div>
        <div class="col-xs-3 col-md-3">
            <div class="col-xs-6 col-md-6">
                <button type="button" class="btn btn-primary" onclick="queryData()"> 查 询</button>
            </div>
        </div>

    </div>

    <div id="toolbar" class="btn-group">
        <button id="btn_add" data-toggle="modal" data-target="#exampleModal" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
        </button>

        <button onclick="save()" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>保存
        </button>

        <button id="btn_exp"  type="button" class="btn btn-default" onclick="dataExport()">
            <span class="glyphicon glyphicon-export" aria-hidden="true"></span>导出
        </button>
    </div>
    <div class="row">
        <table id="person_jfls"></table>
    </div>
</div>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" id="btnClose" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="exampleModalLabel">添加缴费历史</h4>
            </div>
            <div class="modal-body">
                <form>

                    <div class="row">
                        <div class="form-group">
                            <label for="dtp_qsny" class="col-md-2 control-label">起始年月</label>
                            <div class="input-group date form_date col-md-5" data-date="" data-date-format="yyyyMM"
                                 data-link-field="dtp_qsny" data-link-format="yyyyMM">
                                <input class="form-control" size="16" id="dtp_input1" type="text" value="" readonly>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                            <input type="hidden" id="dtp_qsny" value=""/><br/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <label for="dtp_zzny" class="col-md-2 control-label">终止年月</label>
                            <div class="input-group date form_date col-md-5" data-date="" data-date-format="yyyyMM"
                                 data-link-field="dtp_zzny" data-link-format="yyyyMM">
                                <input class="form-control" size="16" id="dtp_input2" type="text" value="" readonly>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                            <input type="hidden" id="dtp_zzny" value=""/><br/>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <label for="dtp_jfsj" class="col-md-2 control-label">缴费时间</label>
                            <div class="input-group date form_date_time col-md-5" data-date=""
                                 data-date-format="yyyy.MM.dd hh:mm:ss"
                                 data-link-field="dtp_jfsj" data-link-format="yyyy.MM.dd hh:mm:ss">
                                <input class="form-control" size="16" id="dtp_input3" type="text" value="" readonly>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                            <input type="hidden" id="dtp_jfsj" value=""/><br/>
                        </div>
                    </div>

                    <div class="row">
                        <label class="col-md-2 control-label">个人缴费额</label>
                        <div class="form-group col-md-10">
                            <input type="number" class="form-control " id="grjfe" placeholder="请输入个人缴费额">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-2 control-label">单位缴费额</label>
                        <div class="form-group col-md-10">
                            <input type="number" class="form-control " id="dwjfe" placeholder="请输入单位缴费额">
                        </div>
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
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/dialog.js"></script>
<script type="text/javascript" src="bootstrap-table/bootstrap-table.js"></script>
<script type="text/javascript" src="bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="bootstrap-table/tableExport.js"></script>
<script type="text/javascript" src="bootstrap/editable/bootstrap-table-editable.js"></script>
<script src="../x-editable/dist/bootstrap3-editable/js/bootstrap-editable.js"></script>
<script type="text/javascript">
    var xm = <%=request.getParameter("xm")%>
    var ryid1 =<%=request.getParameter("ryid1")%>;
    var ryid2 =<%=request.getParameter("ryid2")%>;
    var ryid =  ryid1.toString() + ryid2.toString();
    var dwid =<%=request.getParameter("dwid")%>;
    var grbh1 =<%=request.getParameter("grbh1")%>;
    var grbh2 =<%=request.getParameter("grbh2")%>;
    $('.form_date').datetimepicker({
        language: 'zh-CN',//显示中文
        format: 'yyyymm',//显示格式
        weekStart: 1,
        todayBtn: 0,
        autoclose: 1,
        todayHighlight: 1,
        startView: 3,
        minView: 3,
        forceParse: 0
    });
    $('.form_date_time').datetimepicker({
        language: 'zh-CN',//显示中文
        format: 'yyyy.mm.dd hh:ii:ss',//显示格式
        weekStart: 1,
        todayBtn: 0,
        autoclose: 1,
        todayHighlight: 1,
        startView: 1,
        minView: 1,
        forceParse: 0
    });
    $('#save').click(function () {

        var dwjfe = $("#dwjfe").val();
        var jfsj = $("#dtp_jfsj").val();
        var zzny = $("#dtp_zzny").val();
        var qsny = $("#dtp_qsny").val();
        var grjfe = $("#grjfe").val();
        var infos = {};
        infos.QSNY = qsny;
        infos.ZZNY = zzny;
        infos.RYID = ryid;
        infos.RYDJID = ryid;
        infos.DWJFE = dwjfe;
        infos.GRJFE = grjfe;
        infos.jfrq = jfsj;
        infos.fsrq = jfsj;
        infos.dwid = dwid;
        infos.jbr = "11100000000000000002";
        $.ajax({
            type: "POST",
            url: "../paymentHistory/addPaymentHistory.action",
            data: {
                "data": JSON.stringify(infos)
            },
            dataType: "JSON",
            async: false,
            success: function (data, status) {
                debugger
                if (data.errorCode == 0) {
                    Alert({
                        msg: '保存成功',
                        title: "提示",
                        onOk: function () {
                            $('#exampleModal').modal('hide');
                            queryData();
                        }

                    });
                } else {
                    Alert({
                        msg: data.errorText,
                        title: "提示"

                    });
                }

            },
            error: function (err, status) {
                Alert({
                    msg: '修改缴费历史失败，请重试',
                    title: "提示"
                });
            }
        });
    });
    $('#clear').click(function () {
        $("#dwjfe").val("");
        $("#dtp_jfsj").val("");
        $("#dtp_zzny").val("");
        $("#dtp_qsny").val("");
        $("#grjfe").val("");
        $("#dtp_input2").val("");
        $("#dtp_input1").val("");
        $("#dtp_input3").val("");
    });
    $(document).ready(function () {
        $("#grbh").val(grbh1.toString() + grbh2.toString());
        $('#xm').val(xm);
        queryData();
    });

    function save() {
        var data = $('#person_jfls').bootstrapTable('getData');
        data.dwid = dwid;
        data.ryid = ryid;
        console.log(JSON.stringify(data));
        $.ajax({
            type: "POST",
            url: "../paymentHistory/modifyPaymentHistory.action",
            data: {
                "data": JSON.stringify(data)
            },
            dataType: "JSON",
            async: false,
            success: function (data, status) {
                debugger
                if (data.errorCode == 0) {
                    Alert({
                        msg: '保存成功',
                        title: "提示",
                        onOk: function () {
                            $('#exampleModal').modal('hide');
                            queryData();
                        }

                    });
                } else {
                    Alert({
                        msg: data.errorText,
                        title: "提示"

                    });
                }

            },
            error: function (err, status) {
                Alert({
                    msg: '修改缴费历史失败，请重试',
                    title: "提示"
                });
            }
        });
    }

    function queryData() {
        var grbh = $('#grbh').val();
        var qsrq = $('#qsrq').val();
        var zzrq = $('#zzrq').val();
        if (qsrq == "" || qsrq == null) {
            qsrq = "1900";
        }
        if (zzrq == "" || zzrq == null) {
            var mydate = new Date();
            var str = "" + mydate.getFullYear();
            var month = mydate.getMonth() + 1
            if (month>0 && month<= 9){
                str +=( "0" + month)
            }else {
                str +=month
            }
            zzrq = $.trim(str);
        }
        $('#person_jfls').bootstrapTable("destroy");
        $('#person_jfls').bootstrapTable({
            url: '../paymentHistory/qyeryByRyidWithDate.action',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: false,                     //是否启用排序
            sortOrder: "asc",
            editable: true,//排序方式
            queryParams: function (params) {
                return {
                    pageNumber: params.offset + 1,
                    pageSize: params.limit,
                    grbh: grbh,
                    qsrq: qsrq,
                    zzrq: zzrq,
                };
            },
            //传递参数（*）
            //传递参数（*）
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10000,                       //每页的记录行数（*）
            pageList: [10000, 2000, 3000],        //可供选择的每页的行数（*）
            clickToSelect: true,
            columns: [{
                field: 'XM',
                title: '姓名'
            }
                ,
                {
                    field: 'QSNY',
                    title: '起始年月',
                    editable: {
                        type: 'text',
                        title: '起始年月如:200012)'
                    }
                }
                , {
                    field: 'ZZNY',
                    title: '终止年月',
                    editable: {
                        type: 'text',
                        title: '终止年月（如:200012)'
                    }
                }
                , {
                    field: 'JFRQ',
                    title: '缴费日期',
                    editable: {
                        type: 'text',
                        title: '缴费日期(如:2000.12.22 03:00:00)'
                    }
                }
                , {
                    field: 'DWJFE',
                    title: '单位缴费额',
                    editable: {
                        type: 'text',
                        title: '单位缴费额'
                    }
                }, {
                    field: 'GRJFE',
                    title: '个人缴费额',
                    editable: {
                        type: 'text',
                        title: '个人缴费额'
                    }
                },
                {
                    field: 'RYID',
                    title: 'ryid',
                    visible: false
                },
                {
                    field: 'JFLSID',
                    title: 'JFLSID',
                    visible: false
                }]
        });
    }

    function dataExport() {
        $('#person_jfls').tableExport({
            type:'excel',
            escape:'false',
            filename:'缴费历史'}
            );
    }
</script>
</body>
</html>
