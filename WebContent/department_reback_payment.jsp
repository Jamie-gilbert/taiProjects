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

</head>
<body>
<%@include file="commonTop.jsp" %>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-3 col-md-3">
            <div class="col-xs-6 col-md-6">
                <button type="button" class="btn btn-primary" onclick="rebackPayment()">退费</button>
            </div>
        </div>


    </div>


    <div class="row">
        <table id="table_department"></table>
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

    var txr =<%=request.getParameter("txr")%>;
    var jbjgid =<%=request.getParameter("jbjgid")%>;
    $(document).ready(function () {
        $("#dwid").val(dwid);
        $("#dwmc").val(dwmc);
        $("#dwbh").val(dwbh);
        showHistory('../paymentHistory/queryNobackHistoryByDWID.action');
    });

    function showHistory(url) {
        $('#table_department').bootstrapTable('destroy');
        $('#table_department').bootstrapTable({
            url: url,         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
//            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: false,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: function (params) {
                return {
                    pageNumber: params.offset + 1,
                    pageSize: params.limit,
                    dwid: dwid
                };
            },
            //传递参数（*）
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100, 1000],        //可供选择的每页的行数（*）
            clickToSelect: true,
            showExport: true,                     //是否显示导出
            exportDataType: "all",              //basic', 'all', 'selected'.
            columns: [
                {
                    field: 'lxs',
                    title: '总利息(单位:元)',
                    align: 'center',

                }, {
                    field: 'grjfes',
                    title: '个人缴费总额(单位:元)',
                    align: 'center',

                }, {
                    field: 'zje',
                    title: '总计(单位:元)',
                    align: 'center',

                }]
        });
    }


    function rebackPayment() {
        var size = $('#table_department').bootstrapTable('getData', false).length;
        if (size == 0) {
            Alert({
                msg: '该单位没有缴费记录',
                title: "提示",
            })
        } else {

            $.ajax({
                type: "POST",
                url: "../paymentHistory/rebackPaymentByDWID.action",
                data: {
                    "dwid": dwid,
                    "txr": txr,
                    "jbjgid": jbjgid

                },
                async: false,
                dataType: "JSON",
                success: function (data, status) {
                    console.log(data)
                    var errorCode = data.errorCode;
                    if (errorCode == "1") {
                        Alert({
                            msg: '该人员有未计息的缴费，请先计息',
                            title: "提示",
                        })
                    } else {
                        Alert({
                            msg: '退费成功',
                            title: "提示",
                        })
                    }
                },
                error: function (err, status) {
                    console.log(err)
                }

            });
        }

    }


</script>
</body>
</html>
