<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/18
  Time: 23:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>单位</title>
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.js"></script>

    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">

</head>
<body>
<%@include file="commonTop.jsp"%>
<div class="container-fluid">
    <div class="row">
        <div class="col-xs-3 col-md-4">
            <div class="input-group">
                <span class="input-group-addon">单位编号:</span>
                <input type="text" class="form-control" id="dwbh"/>
            </div>
        </div>
        <div class="col-xs-3 col-md-4">
            <div class="input-group">
                <span class="input-group-addon">单位名称:</span>
                <input type="text" class="form-control" id="dwmc"/>
            </div>
        </div>
        <div class="col-xs-3 col-md-4">
            <button class="btn btn-primary" data-toggle="button" id="query">查询</button>
        </div>
    </div>
</div>
<div class="container-fluid">

<a href="/department/querybydwid.action?dwid=111">修改单位信息(入参：dwid，这里先写死(111))</a>
<a href="../department_bils.jsp?dwid=111">查询单据(入参：dwid，这里先写死(111))</a>
<a href="../dempartment_interest.jsp?dwid=111">单位计息(入参：dwid，这里先写死(111))</a>
<a href="../staff_info.jsp?dwid=111">人员操作 查询人员信息</a>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        $("#query").click(function () {

            var dwmc = $("#dwmc").val();
            var dwbh = $("#dwbh").val();
            var page = 1;
            var count = 10;
            $.ajax({
                type: "POST",
                url: "../department/querybykey.action",
                data: {"dwbh": dwbh, "dwmc": dwmc, "page": page, "count": count},
                async: false,
                dataType: "json",
                success: function (data, status) {
                    debugger;
                    console.log(data)
                },
                error: function (err, status) {
                    debugger;
                    console.log(err)
                }


            });
        });
    });
</script>
</body>
</html>
