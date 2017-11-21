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
    <title>退费单据</title>
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css">
    <link rel="stylesheet" href="bootstrap/custom/department.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="./bootstrap/custom/department.css">
    <script type="text/javascript" src="/bootstrap/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/bootstrap-table/bootstrap-table.js"></script>
    <script type="text/javascript" src="/bootstrap-table/bootstrap-table-zh-CN.js"></script>
    <script type="text/javascript" src="../webTree/assets/js/bui-min.js"></script>
    <script type="text/javascript" src="../webTree/assets/js/config-min.js"></script>
    <script type="text/javascript" src="../js/dialog.js"></script>
</head>
<body>

<table id="person_jfls"></table>


<button type="button" class="btn btn-primary" id="print" onclick="printPage()">打印</button>

<script type="text/javascript">
    var xm = <%=request.getParameter("xm")%>
    var grbh1 =<%=request.getParameter("grbh1")%>;
    var grbh2 =<%=request.getParameter("grbh2")%>;
    var grbh=grbh1.toString() + grbh2;
    $(document).ready(function () {
        $('#grbh').val(grbh);
        $('#xm').val(xm);
        queryData();
    });
    function queryData() {

        var qsrq = "1800";
        var zzrq = "";
        if (zzrq == "" || zzrq == null) {
            var mydate = new Date();
            var str = "" + mydate.getFullYear();
            str += (mydate.getMonth() + 1);

            zzrq = $.trim(str);
        }
        $('#person_jfls').bootstrapTable("destroy");
        $('#person_jfls').bootstrapTable({
            url: '../paymentHistory/queryBillByRyid.action',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false,                   //是否显示分页（*）
            sortable: false,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: function (params) {
                return {
                    pageNumber: params.offset + 1,
                    pageSize: params.limit,
                    grbh: grbh,
                    qsrq: qsrq,
                    zzrq: zzrq
                };
            },
            //传递参数（*）
            //传递参数（*）
            sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 1000,                       //每页的记录行数（*）
            pageList: [1000],        //可供选择的每页的行数（*）
            clickToSelect: true,
            columns: [{
                field: 'grbh',
                title: '个人编号',
                formatter : function (value, row, index) {
                    return grbh;
                }
            },{
                field: 'xm',
                title: '姓名',
                formatter : function (value, row, index) {
                    return xm;
                }
            },
                {
                field: 'dwjfes',
                title: '单位缴费额',
            }, {
                field: 'grjfes',
                title: '个人缴费额',
            }, {
                field: 'lxs',
                title: '利息',
            }, {
                field: 'zje',
                title: '合计',
            }, {
                field: 'JBR',
                title: '填写人',
                formatter : function (value, row, index) {
                    return 'admin';
                }
            }, {
                field: 'JBSJ',
                title: '填写时间',
            }]
        });
    }

    function printPage()
    {
        $("#print").css("display","none");
        window.print();
    }
</script>
</body>
</html>
