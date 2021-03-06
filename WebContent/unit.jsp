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
    <script type="text/javascript" src="../js/dialog.js"></script>
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="./bootstrap/custom/department.css">
</head>
<body>
<div class="unit">
<div style="border-bottom:1px solid cornflowerblue;padding-bottom: 5px">
    <div class="row department" style="margin-left: 1%;margin-top: 1%">
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
            <button class="btn btn-primary btn-sm" data-toggle="modal" id="query"  data-target="#unitModal">查询</button>
            <button class="btn btn-primary btn-sm" id="resetBtn" type="reset">重置</button>
        </div>
    </div>
    <div class="container-fluid" id="unitButton">
        <a id='rylb' class="page-action btn btn-primary btn-sm" href="#" title="人员列表">人员列表
        </a>
        <a id="xgdwxx" class="btn btn-primary btn-sm" href="#unitChangeModal" data-toggle="modal" title="修改单位信息">
            修改单位信息</a>
        <a id='cxdj' class="page-action btn btn-primary btn-sm" href="#"  title="查询单据">
            查询单据</a>
        <a id='dwjx' class="page-action btn btn-primary btn-sm" href="#"  title="单位计息">
            单位计息
        </a>
        <a id='cxdwjx' class="page-action btn btn-primary btn-sm" href="#" title="撤销单位计息">
            撤销单位计息
        </a>
        <a id='dwtf' class="page-action btn btn-primary btn-sm" href="#" title="单位退费">
            单位退费
        </a>
    </div>
</div>
    <div class="modal fade" id="unitModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">单位信息</h4>
                </div>
                <div class="modal-body" style="height:300px;overflow:auto;">
                    <table id="unit_modal"></table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="getUnit()">确定</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="unitChangeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="unitInfo">单位信息</h4>
                </div>
                <div class="modal-body input-group">
                    <span class="input-group-addon">单位名称:</span>
                    <input name="dwmc" type="text" id="xgDwmc" class="form-control">
                </div>
                <input  type="hidden" id="xgDwid" class="form-control">
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="changeUnit">确定</button>
                </div>
            </div>
        </div>
    </div>
    <div class="depart_show">
        <input name="dwbh" type="text" id="dwid" hidden="hidden" readonly>
        <div class="input-group">
            <span class="input-group-addon">单位编号:</span>
            <input name="dwbh" type="text" id="tcDwbh" class="form-control" readonly>
        </div>
        <div class="input-group">
            <span class="input-group-addon">单位名称:</span>
            <input name="dwmc" type="text" id="tcDwmc" class="form-control" readonly>
        </div>
        <div class="input-group">
            <span class="input-group-addon">经办机构:</span>
            <input name="jbjgid" type="text" id="jbjgid" class="form-control" readonly>
        </div>
        <div class="input-group">
            <span class="input-group-addon">投保类别:</span>
            <input name="tblbmc" type="text" id="tblbmc" class="form-control" readonly>
        </div>
    </div>
</div>


<script type="text/javascript">
    var dwbhv = "";
    var dwmcv = "";
    var row = "";
    var dwid ="";
    var dwbh ="";
    var dwmc ="";
    BUI.use('common/page');


    $("#changeUnit").click(function () {

        dwmc = $("#xgDwmc").val();
        dwid = $("#xgDwid").val();
        if (dwmc == null){
            alert("请输入要修改的信息");
        }else {
            $.ajax({
                type: "POST",
                url: "../department/modifydepartment.action",
                data: {"dwmc": dwmc,"dwid":dwid},
                async: false,
                dataType: "JSON",
                success: function (data, status) {
                    alert("修改成功!");
                    $('#changeUnit').modal('hide');
                },
                error: function (err, status) {
                    alert("修改异常!");
                    $('#changeUnit').modal('hide');
                }
            });
        }
    });

    $(document).ready(function () {
        $('#query').click(function () {
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
            pageSize: 5,                       //每页的记录行数（*）
            pageList: [5,10, 25, 50],        //可供选择的每页的行数（*）
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
            $('#tcDwmc').val(row[0]["dwmc"]);
            $('#xgDwmc').val(row[0]["dwmc"]);
            $('#tcDwbh').val(row[0]["dwbh"]);
            $('#jbjgid').val("岱岳区");
            $('#tblbmc').val(row[0]["tblbmc"]);
            $('#dwid').val(row[0]["dwid"]);
            $('#xgDwid').val(row[0]["dwid"]);
        }
        var dwid=$('#dwid').val();
        var dwmc=$('#dwmc').val();
        var dwbh=$('#dwbh').val();

        $('#rylb').attr('data-href',"../department_staff.jsp?dwid="+dwid+"&dwbh="+dwbh+"&dwmc="+dwmc);
        $('#cxdj').attr('data-href',"../department_bils.jsp?dwid="+dwid+"&dwbh="+dwbh+"&dwmc="+dwmc);
        $('#dwjx').attr('data-href',"../dempartment_interest.jsp?dwid="+dwid+"&dwbh="+dwbh+"&dwmc="+dwmc);
        $('#cxdwjx').attr('data-href',"../dempartment_clear_interest.jsp?dwid="+dwid+"&dwbh="+dwbh+"&dwmc="+dwmc);
        $('#dwtf').attr('data-href',"../department_reback_payment.jsp?dwid="+dwid+"&txr="+"'"+"admin"+"'" +"&jbjgid="+"37091103"+"&dwbh="+dwbh+"&dwmc="+dwmc);
    }


    //重置按钮事件
    $("#resetBtn").off().on("click", function () {
        $("#dwmc").val("");
        $("#dwbh").val("");
        $("#jbjgid").val("");
        $("#tcDwmc").val("");
        $("#tcDwbh").val("");
        $("#tblbmc").val("");
        $('#dwbh').attr("readonly", false)
        $('#dwmc').attr("readonly", false)
    });
</script>

</body>
</html>
