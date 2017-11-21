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
    <link rel="stylesheet" href="../css/bootstrap.css">
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css">
    <link rel="stylesheet" href="bootstrap/custom/department.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="./bootstrap/custom/department.css">
    <link rel="stylesheet" href="../x-editable/dist/bootstrap3-editable/css/bootstrap-editable.css">

</head>
<body>

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


    <div class="row">
        <table id="person_jfls"></table>
    </div>


</div>

<script type="text/javascript" src="bootstrap/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="bootstrap-table/bootstrap-table.js"></script>
<script type="text/javascript" src="bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="webTree/assets/js/bui-min.js"></script>
<script type="text/javascript" src="webTree/assets/js/config-min.js"></script>
<script type="text/javascript" src="js/dialog.js"></script>
<script type="text/javascript">
    var ryid = "";
    var grbh1 =<%=request.getParameter("grbh1")%>;
    var grbh2 =<%=request.getParameter("grbh2")%>;


    $(document).ready(function () {
        $("#grbh").val(grbh1.toString() + grbh2.toString())
        queryData();
    });

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
            str += (mydate.getMonth() + 1);

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
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50],        //可供选择的每页的行数（*）

            columns: [ {
                field: 'QSNY',
                title: '起始年月',
                editable: {
                    type: 'text',
                    title: '起始年月'
                }
            }, {
                field: 'ZZNY',
                title: '终止年月',
                editable: {
                    type: 'text',
                    title: '终止年月'
                }
            }, {
                field: 'DWJFZE',
                title: '单位缴费总额',
                editable: {
                    type: 'text',
                    title: '单位缴费总额'
                }
            }, {
                field: 'GRJFZE',
                title: '个人缴费总额',
                editable: {
                    type: 'text',
                    title: '个人缴费总额'
                }
            },
                {
                    field: 'RYID',
                    title: 'ryid',
                    visible: false
                }]
        });
    }

    function rebackPayment() {
        var datas = $('#person_jfls').bootstrapTable("getSelections");
        if (datas == null || datas.length <= 0) {
            Alert({
                msg: '请先选择缴费历史',
                title: "提示"
            });
        } else {

            var ryid = datas[0].RYID;
            var qsrq = $('#qsrq').val();
            var zzrq = $('#zzrq').val();
            if (qsrq == "" || qsrq == null) {
                qsrq = "1900";
            }
            if (zzrq == "" || zzrq == null) {
                var mydate = new Date();
                var str = "" + mydate.getFullYear();
                str += (mydate.getMonth() + 1);

                zzrq = $.trim(str);
            }
            $.ajax({
                type: "POST",
                url: "../paymentHistory/queryCountWithoutInterestByRyidWithDate.action",
                data: {
                    "ryid": ryid,
                    "qsrq": qsrq,
                    "zzrq": zzrq
                },
                async: false,
                dataType: "JSON",
                success: function (data, status) {
                    console.log(data)
                    var needInterest = data.needInterest;
                    if (needInterest == true) {
                        Alert({
                            msg: '该人员有未计息的缴费，请先计息',
                            title: "提示",
                        })
                    } else {
                        rebackPay(datas);
                    }
                },
                error: function (err, status) {
                    console.log(err)
                }

            });
        }
    }

    function rebackPay(datas) {
        debugger
        var ryid = datas[0].RYID;
        var qsrqs = [];

        for (var i = 0; i < datas.length; i++) {
            var qsrq = {};
            qsrq.qsrq = datas[i].QSNY;
            qsrqs.push(qsrq);
        }
        $.ajax({
            type: "POST",
            url: "../paymentHistory/rebackPaymentByRyIdWithDate.action",
            data: {
                "ryid": ryid,
                "qsrqs": JSON.stringify(qsrqs),
                "txr": "admin"

            },
            async: false,
            dataType: "JSON",
            success: function (data, status) {

                Alert({
                    msg: '退费成功',
                    title: "提示",
                })

            },
            error: function (err, status) {
                Alert({
                    msg: '退费失败',
                    title: "提示",
                })

            }

        });
    }
</script>
</body>
</html>
