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
    <title>撤销单位计息</title>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">

</head>
<body>
<div class="container-fluid">

    <div class="row">
        <div class="col-xs-8 col-md-8">
        </div>
        <div class="col-xs-4 col-md-4">
            <button id="interest" class="btn btn-primary" data-toggle="button" onclick="queryNeedCancel()">撤销计息</button>
        </div>
    </div>
    <div class="row">${requestScope.data}</div>
</div>
<script src="../js/jquery.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/dialog.js"></script>
<script type="text/javascript">
    var data = eval(${requestScope.data})
    var all = data.total;

    function queryNeedCancel() {
        if (all > 0) {
            Confirm({
                msg: '你确定计息吗',
                title: "提示",
                onOk: function () {

                    clearInterest();
                },
                onCancel: function () {

                }
            })
        } else {
            Alert({
                msg: '该单位未计息',
                title: "提示"
            })
        }
    };

    function clearInterest() {

        var dwid = "100000000000042";
        var ryids = [{"ryid": "11100000000000011594"}, {"ryid": "11100000000000011594"}];
        $.ajax({
            type: "POST",
            url: "../paymentHistory/clear.action",
            data: {
                "dwid": dwid,
                "ryids": JSON.stringify(ryids)
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
