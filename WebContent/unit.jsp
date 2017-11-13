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
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.js"></script>

    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../bootstrap/custom/department.css">
</head>
<body>
<div>
<div style="border-bottom:1px solid cornflowerblue;padding-bottom: 5px">
        <div class="row department">
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
            <div class="col-xs-2 col-md-3">
                <button class="btn btn-primary btn-sm" data-toggle="button" id="query">查询</button>
                <button class="btn btn-primary btn-sm" id="resetBtn" type="reset">重置</button>
            </div>
        </div>
        <div class="container-fluid" id="unitButton">
            <a class="btn btn-primary btn-sm" href="/department/querybydwid.action?dwid=111">修改单位信息</a>
            <a class="btn btn-primary btn-sm" href="/department_bils.jsp?dwid=111">查询单据</a>
            <a class="btn btn-primary btn-sm" href="/dempartment_interest.jsp?dwid=111">单位计息</a>
            <!--    <a class="btn btn-primary btn-sm" href="../staff_info.jsp?dwid=111">人员查询</a>-->
        </div>
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
                    $('#dwbh').val(data.data[0].dwbh);
                    $('#dwmc').val(data.data[0].dwmc);
                    $('#dwbh').attr("readonly",true)
                    $('#dwmc').attr("readonly",true)
                },
                error: function (err, status) {
                    console.log(err)
                }


            });
        });
    });

    //重置按钮事件
    $("#resetBtn").off().on("click",function(){
        $("#dwmc").val("");
        $("#dwbh").val("");
        $('#dwbh').attr("readonly",false)
        $('#dwmc').attr("readonly",false)
    });
</script>
</body>
</html>
