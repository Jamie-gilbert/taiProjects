<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/21
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>修改单位信息</title>
    <link rel="stylesheet" href="../css/bootstrap.css">
</head>
<body>
<%@include file="commonTop.jsp"%>
<div class="container-fluid">

    <div class="row">
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">单位名称:</span>
                <input type="text" class="form-control" id="dwmc" value="${requestScope.department.dwmc}"/>
            </div>
        </div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">投保类别:</span>
                <input type="text" class="form-control" id="tblb" value="${requestScope.department.tblb}"/>

            </div>
        </div>
    </div>


    <div class="row">
        <button class="btn btn-primary" data-toggle="button" id="modify">修 改</button>
    </div>
    <div class="row">
        <a href="../department_staff.jsp?dwid=100000000000148">人员列表(单位id写死 333)</a>
    </div>
</div>
<script src="../js/jquery.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/dialog.js"></script>
<script type="text/javascript">
    $("#modify").click(function () {
        Confirm({
            msg: '你确定修改单位信息吗',
            title: "提示",
            onOk: function () {
                debugger;
                var dwmc = $("#dwmc").val();
                var tblb = $("#tblb").val();
                var tblbmc = "";
                var dwid =${requestScope.department.dwid};

                $.ajax({
                    type: "POST",
                    url: "modifydepartment.action",
                    data: {"dwmc": dwmc, "tblb": tblb, "tblbmc": tblbmc, "dwid": dwid},
                    async: false,
                    dataType: "JSON",
                    success: function (data, status) {
                        console.log(data)
                    },
                    error: function (err, status) {
                        console.log(err)
                    }
                });
            },
            onCancel: function () {

            }
        })
    });
</script>
</body>
</html>
