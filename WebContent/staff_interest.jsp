<%--
  Created by IntelliJ IDEA.
  User: ggg
  Date: 2017/11/18
  Time: 19:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>个人计息</title>

    <link rel="stylesheet" href="../bootstrap/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="../bootstrap-table/bootstrap-table.css" type="text/css">
    <script type="text/javascript" src="../bootstrap/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="../bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="../bootstrap-table/bootstrap-table.js"></script>
    <script type="text/javascript" src="../bootstrap-table/tableExport.js"></script>
    <script type="text/javascript" src="../bootstrap-table/extensions/export/bootstrap-table-export.js"></script>
    <script type="text/javascript" src="../bootstrap-table/bootstrap-table-zh-CN.js"></script>
    <script type="text/javascript" src="../js/dialog.js"></script>
</head>
<body>
<div class="container-fluid">

    <div class="row">
        <div class="col-xs-4 col-md-4">
            <button id="officer" class="btn btn-primary" ONCLICK="interest()" data-toggle="button">个人计息</button>
        </div>
        <div class="col-xs-4 col-md-4">
            <button id="retiree" class="btn btn-primary" onclick="cancelInterest()" data-toggle="button">撤销计息</button>
        </div>

    </div>
    <div class="row">${requestScope.data}</div>

</div>
<script type="text/javascript">
    function interest() {
        var ryid = "11100000000000008807";
        var grjfe = "18.8";
        var infos = [{"qsny": "201001", "payment": grjfe, "ryid": "11100000000000008807", "flag": "isUpate"}
            , {"qsny": "201002", "payment": grjfe, "ryid": "11100000000000008807", "flag": "isUpate"}
            , {"qsny": "201003", "payment": grjfe, "ryid": "11100000000000008807", "flag": "isUpate"}
            , {"qsny": "201004", "payment": grjfe, "ryid": "11100000000000008807", "flag": "isUpate"}
            , {"qsny": "201005", "payment": grjfe, "ryid": "11100000000000008807", "flag": "isUpate"}];

        $.ajax({
            type: "POST",
            url: "../paymentHistory/modifyInterestByRyid.action",
            data: {
                "ryid": ryid,
                "infos": JSON.stringify(infos)
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

    function cancelInterest() {
        var ryid = "11100000000000008807";

        $.ajax({
            type: "POST",
            url: "../paymentHistory/cancelInterestByRyid.action",
            data: {
                "ryid": ryid
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

</script>
</body>
</html>
