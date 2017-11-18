<%--
  Created by IntelliJ IDEA.
  User: Administrator
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
    <title>单位单据查询</title>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.js"></script>
</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-3 col-md-3">
            <button id="yqrdj" class="btn btn-primary" data-toggle="button">已确认单据</button>
        </div>
        <div class="col-xs-3 col-md-3">
            <button id="wqrdj" class="btn btn-primary" data-toggle="button">未确认单据</button>
        </div>
        <div class="col-xs-3 col-md-3">
            <button id="yzfdj" class="btn btn-primary" data-toggle="button">已作废单据</button>
        </div>
        <div class="col-xs-3 col-md-3">
            <button id="ycxdj" class="btn btn-primary" data-toggle="button">已冲销单据</button>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-3 col-md-3">
            <div class="input-group">
                <span class="input-group-addon">填写时间:</span>
                <input type="date" class="form-control" id="time"/>
            </div>
        </div>
        <div class="col-xs-3 col-md-3">
            <button id="query" class="btn btn-primary" data-toggle="button">查询</button>
        </div>
        <div class="col-xs-3 col-md-3">
            <button id="modify_status" onclick="modifyStatusByDwid()" class="btn btn-primary"
                    data-toggle="button">
                修改单据状态
            </button>
        </div>
        <div class="col-xs-3 col-md-3">
            <button id="modify_status2" onclick="toVoidByDwid()" class="btn btn-primary"
                    data-toggle="button">
                作废单据
            </button>
        </div>
    </div>
</div>
<script type="text/javascript">
    var type = "";

    function queryBils() {
        var time = $("#time").val();
        var page = 1;
        var count = 10;
        var dwid =<%=request.getParameter("dwid")%>;
        $.ajax({
            type: "POST",
            url: "departmentBills/querydepartmentbils.action",
            data: {
                "time": time, "pageNumber": page,
                "pageSize": count, "type": type,
                "dwid": dwid
            },
            dataType: "JSON",
            async: false,
            success: function (data, status) {
                console.log(data)
            },
            error: function (err, status) {
                console.log(err)
            }
        });
    }

    $("#yqrdj").click(function () {
        type = "1";
        $('#modify_status').val("冲销单据")
        $('#modify_status').show();
        $('#modify_status2').show();
        queryBils();
    });
    $("#wqrdj").click(function () {
        type = "0";
        $('#modify_status').val("确认单据");
        $('#modify_status').show();
        $('#modify_status2').hide();
        queryBils();
    });
    $("#yzfdj").click(function () {
        $('#modify_status').hide();
        $('#modify_status2').hide();
        type = "2";
        queryBils();
    });
    $("#ycxdj").click(function () {
        $('#modify_status').hide();
        $('#modify_status2').hide();

        type = "3";
        queryBils();
    });
    $("#query").click(function () {

        queryBils();
    });

    function modifyStatusByDwid() {
        var djzt = '';
        if (type == 0) {
            djzt = 1;
        } else if (type == 1) {
            djzt = 3;
        }
        var zdlshs = [{"zdlsh": "200611210001"}
            , {"zdlsh": "200611210001"}
            , {"zdlsh": "200611210001"}
            , {"zdlsh": "200611210001"}
            , {"zdlsh": "200611210001"}];


        var dwid =<%=request.getParameter("dwid")%>;
        if (djzt != '') {
            $.ajax({
                type: "POST",
                url: "../departmentBills/modifyStatusByDwid.action",
                data: {
                    "zdlshs": JSON.stringify(zdlshs),
                    "dwid": dwid,
                    "djzt": djzt
                },
                dataType: "JSON",
                async: false,
                success: function (data, status) {
                    console.log(data)
                },
                error: function (err, status) {
                    console.log(err)
                }
            });
        }
    }

    function toVoidByDwid() {
        var djzt = '';
        if (type == 0) {
            djzt = 2;
        }
        var zdlshs = [{"zdlsh": "200611210001"}
            , {"zdlsh": "200611210001"}
            , {"zdlsh": "200611210001"}
            , {"zdlsh": "200611210001"}
            , {"zdlsh": "200611210001"}];


        var dwid =<%=request.getParameter("dwid")%>;
        if (djzt != '') {
            $.ajax({
                type: "POST",
                url: "../departmentBills/modifyStatusByDwid.action",
                data: {
                    "zdlshs": JSON.stringify(zdlshs),
                    "dwid": dwid,
                    "djzt": djzt
                },
                dataType: "JSON",
                async: false,
                success: function (data, status) {
                    console.log(data)
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
