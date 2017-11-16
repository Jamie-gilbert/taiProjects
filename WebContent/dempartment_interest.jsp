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
    <title>单位计息</title>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">

</head>
<body>
<div class="container-fluid">

    <div class="row">
        <div class="col-xs-8 col-md-8">
        </div>
        <div class="col-xs-4 col-md-4">
            <button id="interest" class="btn btn-primary" data-toggle="button" onclick="queryNeedInterest()">计息</button>
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

    function interest() {
        var dwid = "100000000000134";
        var grjfe = "18.8";
        var infos = [{"qsny": "201001", "payment": grjfe, "ryid": "11100000000000008807","flag":"isUpate"}
            , {"qsny": "201002", "payment": grjfe, "ryid": "11100000000000008807","flag":"isUpate"}
            , {"qsny": "201003", "payment": grjfe, "ryid": "11100000000000008807","flag":"isUpate"}
            , {"qsny": "201004", "payment": grjfe, "ryid": "11100000000000008807","flag":"isUpate"}
            , {"qsny": "201005", "payment": grjfe, "ryid": "11100000000000008807","flag":"isUpate"}];

        $.ajax({
            type: "POST",
            url: "../paymentHistory/interest.action",
            data: {
                "dwid": dwid,
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

    function queryNeedInterest() {
        if (all > 0) {
            Confirm({
                msg: '你确定计息吗',
                title: "提示",
                onOk: function () {

                    interest();
                },
                onCancel: function () {

                }
            })
        } else {
            Alert({
                msg: '该单位已经计息',
                title: "提示"
            })
        }
    };


</script>
</body>
</html>
