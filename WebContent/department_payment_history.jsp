<%--
  Created by IntelliJ IDEA.
  User: ggg
  Date: 2017/10/25
  Time: 21:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>查询退费和未退费的单位数量</title>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" href="bootstrap-table/bootstrap-table.css" type="text/css">

</head>
<body>
<div class="container-fluid">
    <div class="row">
        <input id="allCount" readonly="readonly">
        <input id="noBack" readonly="readonly">
        <input id="backed" readonly="readonly">
    </div>
    <div class="row">
        <div class="col-xs-4 col-md-4">
            <button class="btn btn-primary" onclick="rebackedDepartment()" data-toggle="button">已退费单位</button>
        </div>
        <div class="col-xs-4 col-md-4">
            <button class="btn btn-primary" onclick="noRebackDeparment()" data-toggle="button">未退费单位</button>
        </div>
    </div>
    <div class="modal-body table-responsive">
        <table id="table_department">

        </table>
    </div>

</div>


<script src="../js/jquery.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/dialog.js"></script>
<script type="text/javascript" src="bootstrap-table/bootstrap-table.js"></script>
<script type="text/javascript" src="bootstrap-table/tableExport.js"></script>
<script type="text/javascript" src="bootstrap-table/extensions/export/bootstrap-table-export.js"></script>
<script type="text/javascript" src="bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
        queryCount();
        showHistory('../paymentHistory/queryNoRebackHistory.action');
    });

    function noRebackDeparment() {
        showHistory('../paymentHistory/queryNoRebackHistory.action');
    }

    function rebackedDepartment() {
        showHistory('../paymentHistory/queryRebackHistory.action');
    }

    function queryCount() {

        $.ajax({
            type: "POST",
            url: "../paymentHistory/queryCountInPaymentHistory.action",
            dataType: "JSON",
            async: true,
            success: function (data, status) {
                console.log(data)
                $('#allCount').val('全部：' + data.all);
                $('#noBack').val('未退费：' + data.noReback);
                $('#backed').val('已退费：' + data.reback);

            },
            error: function (err, status) {
                console.log(err)
            }
        });

    }

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
                    pageSize: params.limit

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
                    field: 'dwbh',
                    title: '单位编号',
                    align: 'center',

                }, {
                    field: 'dwmc',
                    title: '单位名称',
                    align: 'center',

                }, {
                    field: 'lxs',
                    title: '利息',
                    align: 'center',

                }, {
                    field: 'grjfes',
                    title: '个人缴费额',
                    align: 'center',

                }, {
                    field: 'zje',
                    title: '总计',
                    align: 'center',

                }]
        });
    }


</script>
</body>
</html>
