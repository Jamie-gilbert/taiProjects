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
    <script type="text/javascript" src="/bootstrap/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/bootstrap-table/bootstrap-table.js"></script>
    <script type="text/javascript" src="/bootstrap-table/bootstrap-table-zh-CN.js"></script>
    <script type="text/javascript" src="../webTree/assets/js/bui-min.js"></script>
    <script type="text/javascript" src="../webTree/assets/js/config-min.js"></script>
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="./bootstrap/custom/department.css">
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
                <button class="btn btn-primary btn-sm" data-toggle="modal" id="query" data-target="#unitModal">查询
                </button>
                <button class="btn btn-primary btn-sm" id="resetBtn" type="reset">重置</button>
            </div>
        </div>
        <div class="container-fluid" id="unitButton">
            <%--<a class="btn btn-primary btn-sm" href="/department/querybydwid.action?dwid=111">修改单位信息</a>--%>
            <a id="xgdwxx" class="page-action btn btn-primary btn-sm" href="#"
               data-href="../department/querybydwid.action?dwid=100000000000012" title="修改单位信息"
               data-id="modify_department">修改单位信息</a>
            <a class="btn btn-primary btn-sm" href="../department_bils.jsp?dwid=100000000000175">查询单据</a>
            <a class="btn btn-primary btn-sm" href="../staff_reback_payment.jsp">人员退费</a>
            <a class="btn btn-primary btn-sm"
               href="../paymentHistory/interestPaymentHistory.action?dwid=100000000000175&pageNumber=1&pageSize=10">单位计息</a>
            <!--    <a class="btn btn-primary btn-sm" href="../staff_info.jsp?dwid=111">人员查询</a>-->
            <a class="btn btn-primary btn-sm"
               href="../paymentHistory/clearPaymentHistory.action?dwid=100000000000042&pageNumber=1&pageSize=10">
                撤销单位计息
            </a>
        </div>
    </div>
    <div class="modal fade" id="unitModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true"
         data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabel">单位信息</h4>
                </div>
                <div class="modal-body">
                    <table id="unit_modal"></table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="getUnit()">确定</button>
                </div>
            </div>
        </div>
    </div>
    <div>
        <div>
            <label for="dwbh">单位编号</label>
            <input name="dwbh" type="text" readonly>
        </div>
        <div>
            <label for="dwmc">单位名称</label>
            <input name="dwmc" type="text" readonly>
        </div>
        <div>
            <label for="jbjgid">经办机构</label>
            <input name="jbjgid" type="text" readonly>
        </div>
        <div>
            <label for="tblbmc">投保类别</label>
            <input name="tblbmc" type="text" readonly>
        </div>
    </div>
</div>

<script type="text/javascript">
    var dwbhv = "";
    var dwmcv = "";
    var row = "";
    BUI.use('common/page');
    /*
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
    */


    $(document).ready(function () {
        $('#query').click(function () {
            var dwid="1111";
            $('#xgdwxx').attr('data-href',dwid);
            dwbhv = $('#dwbh').val();
            dwmcv = $('#dwmc').val();
            unit();
        });

    });

    function unit() {
        $("#unit_modal").bootstrapTable('destroy');
        $('#unit_modal').bootstrapTable({
            url: '../department/querybykey.action',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            // toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: false,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: function (params) {
                return {
                    pageNumber: params.offset + 1,
                    pageSize: params.limit,
                    dwbh: dwbhv,
                    dwmc: dwmcv
                };
            },
            //传递参数（*）
            //传递参数（*）
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            clickToSelect: true,
            columns: [{
                checkbox: true
            }, {
                field: 'dwbh',
                title: '单位编号',
            }, {
                field: 'dwmc',
                title: '单位名称',
            }, {
                field: 'tblbmc',
                title: '投保类别',
            }]
        });
    }

    function getUnit() {
        row = $.map($("#unit_modal").bootstrapTable('getSelections'), function (row) {
            return row;
        });
        if (row == "") {
            alert("请选择一个单位!");
        } else {
            $('#unitModal').modal('hide');
            $('#dwmc').val(row[0]["dwmc"]);
            $('#dwbh').val(row[0]["dwbh"]);
            $('#dwbh').attr("readonly", true);
            $('#dwmc').attr("readonly", true);
        }
    }


    //重置按钮事件
    $("#resetBtn").off().on("click", function () {
        $("#dwmc").val("");
        $("#dwbh").val("");
        $('#dwbh').attr("readonly", false)
        $('#dwmc').attr("readonly", false)
    });
</script>
</body>
</html>
