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
    <title>单位计息</title>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.js"></script>
</head>
<body>
<div class="container-fluid">

    <div class="row">
        <div class="col-xs-8 col-md-8">
        </div>
        <div class="col-xs-4 col-md-4">
            <button id="interest" class="btn btn-primary" data-toggle="button">计息</button>
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
                "time": time, "page": page,
                "count": count, "type": type,
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
        queryBils();
    });
    $("#wqrdj").click(function () {
        type = "0";
        queryBils();
    });
    $("#yzfdj").click(function () {
        type = "2";
        queryBils();
    });
    $("#ycxdj").click(function () {
        type = "3";
        queryBils();
    });
    $("#query").click(function () {
        queryBils();
    });

</script>
</body>
</html>
