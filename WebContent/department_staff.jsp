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
    <title>人员</title>
    <link rel="stylesheet" href="../css/bootstrap.css">

</head>
<body>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-4 col-md-4">
            <button id="officer" class="btn btn-primary" data-toggle="button">在职人员</button>
        </div>
        <div class="col-xs-4 col-md-4">
            <button id="retiree" class="btn btn-primary" data-toggle="button">退休人员</button>
        </div>
        <div class="col-xs-4 col-md-4">
            <button id="unemployed" class="btn btn-primary" data-toggle="button">离职人员</button>
        </div>
    </div>

</div>

<script src="../js/jquery.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/dialog.js"></script>
<script type="text/javascript">
    var type = "";
    var dwid = <%=request.getParameter("dwid")%>;
    var page = 1;
    var count = 10;
    $("#officer").click(function () {
        type = "AOA";
        getStaff();
    });
    $("#retiree").click(function () {
        type = "AOC";
        getStaff();
    });

    $("#unemployed").click(function () {

        type = "AOF";
        getStaff();
    });

    function getStaff() {
        $.ajax({
            type: "POST",
            url: "staff/queryStaff.action",
            data: {"dwid": dwid, "page": page, "count": count, "type": type},
            async: false,
            dataType: "JSON",
            success: function (data, status) {
                console.log(data);
            },
            error: function (err, status) {
                console.log(err);
            }
        });
    }
</script>
</body>
</html>
