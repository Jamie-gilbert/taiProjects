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
    <title>个人计息</title>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" href="bootstrap-table/bootstrap-table.css" type="text/css">

</head>
<body>
<%@include file="pcommonTop.jsp"%>
<div class="container-fluid">


    <div id="toolbar" class="btn-group" onclick="queryNeedInterest()">
        <button data-toggle="button" type="button" class="btn btn-default">
            <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>计息
        </button>

    </div>
    <table id="person_jfls"></table>

</div>


<script src="../js/jquery.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/dialog.js"></script>
<script type="text/javascript" src="bootstrap-table/bootstrap-table.js"></script>
<script type="text/javascript" src="bootstrap-table/tableExport.js"></script>
<script type="text/javascript" src="bootstrap-table/extensions/export/bootstrap-table-export.js"></script>
<script type="text/javascript" src="bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript">
    var ryid = "";
    var grbh1 =<%=request.getParameter("grbh1")%>;
    var grbh2 =<%=request.getParameter("grbh2")%>;
    var xm = <%=request.getParameter("xm")%>

    $(document).ready(function () {

        $("#grbh").val(grbh1.toString() + grbh2);
        $("#xm").val(xm);
        queryData();
    });

    function queryData() {
        var grbh = $('#grbh').val();
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
            url: '../paymentHistory/qyeryByRyidWithDate.action',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: false,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
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
            pageSize: 1000,                       //每页的记录行数（*）
            pageList: [1000],        //可供选择的每页的行数（*）
            clickToSelect: true,
            columns: [{
                field: 'QSNY',
                title: '起始年月',
            }, {
                field: 'ZZNY',
                title: '终止年月',
            }, {
                field: 'DWJFZE',
                title: '单位缴费总额',
            }, {
                field: 'GRJFZE',
                title: '个人缴费总额',
            }, {
                    field: 'RYID',
                    title: 'ryid',
                    visible: false
                }]
        });
    }

    <%--function interest(selectData) {--%>

        <%--var dwid =<%=request.getParameter("dwid")%>;--%>
        <%--var infos = [];--%>

        <%--for (var i = 0; i < selectData.length; i++) {--%>
            <%--var ryidObj = {};--%>
            <%--ryidObj.ryid = selectData[i].RYID;--%>
            <%--infos.push(ryidObj);--%>
        <%--}--%>
        <%--$.ajax({--%>
            <%--type: "POST",--%>
            <%--url: "../paymentHistory/interest.action",--%>
            <%--data: {--%>
                <%--"dwid": dwid,--%>
                <%--"infos": JSON.stringify(infos)--%>
            <%--},--%>
            <%--dataType: "JSON",--%>
            <%--async: true,--%>
            <%--success: function (data, status) {--%>
                <%--console.log(data)--%>
                <%--Alert({--%>
                    <%--msg: '计息成功',--%>
                    <%--title: "提示",--%>

                <%--});--%>
                <%--paymentHis_table();--%>
            <%--},--%>
            <%--error: function (err, status) {--%>
                <%--console.log(err)--%>
                <%--Alert({--%>
                    <%--msg: '计息失败',--%>
                    <%--title: "提示",--%>

                <%--})--%>
            <%--}--%>
        <%--});--%>


    <%--}--%>

    <%--function queryNeedInterest() {--%>
        <%--var currentData = $('#paymentHis').bootstrapTable('getData');--%>
        <%--var all = currentData.length;--%>
        <%--var selectData = $('#paymentHis').bootstrapTable('getSelections');--%>

        <%--if (all > 0) {--%>
            <%--if (selectData != null && selectData.length > 0) {--%>
                <%--Confirm({--%>
                    <%--msg: '你确定计息吗',--%>
                    <%--title: "提示",--%>
                    <%--onOk: function () {--%>

                        <%--interest(selectData);--%>
                    <%--},--%>
                    <%--onCancel: function () {--%>

                    <%--}--%>
                <%--})--%>
            <%--} else {--%>
                <%--Alert({--%>
                    <%--msg: '请先选择需要计息的人员',--%>
                    <%--title: "提示",--%>

                <%--})--%>
            <%--}--%>
        <%--} else {--%>
            <%--Alert({--%>
                <%--msg: '该单位已经计息',--%>
                <%--title: "提示"--%>
            <%--})--%>
        <%--}--%>
    <%--};--%>


</script>
</body>
</html>
