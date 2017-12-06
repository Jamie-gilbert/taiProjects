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
    <title>单位缴费明细</title>
    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="bootstrap-table/bootstrap-table.css">


</head>
<body>
<div>
<div class="row" style="margin-top: 1%;border-bottom:1px solid cornflowerblue;">
<div style="padding-bottom: 5px;margin-left: 2%">
    <div class="row department">
        <input type="text" id="dwid" hidden="hidden">
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
            <button class="btn btn-primary btn-sm " id ="export" type="button"  style="display: none">导出</button>
        </div>
    </div>
</div>
</div>
<div class="modal fade" id="unitModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                    <h4 class="modal-title" id="myModalLabel">单位信息</h4>
                </div>
                <div class="modal-body  table-responsive">
                    <table id="unit_modal"></table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="getUnit()">确定</button>
                </div>
            </div>
        </div>
    </div>
</div>
<div style="margin-top: 1%">
    <div id="toolbar">
    </div>
    <table id="table_department">
    </table>
</div>

<script src="js/jquery.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/dialog.js"></script>
<script type="text/javascript" src="bootstrap-table/xlsx.core.min.js"></script>
<script type="text/javascript" src="bootstrap-table/bootstrap-table.js"></script>
<script type="text/javascript" src="bootstrap-table/tableExport.js"></script>
<script type="text/javascript" src="bootstrap-table/extensions/export/bootstrap-table-export.js"></script>
<script type="text/javascript" src="bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript">
    var dwmc ="";
    var dwbh ="";
    var dwid ="";

    $('#query').click(function () {
        dwbh = $('#dwbh').val();
        dwmc = $('#dwmc').val();
        $('#export').show();
        unit();
    });

    $("#export").click(function(){
        $("#table_department").tableExport({
            type: 'excel',
            formats: ['xlsx']
        })
    });



    function showHistory() {
        $('#table_department').bootstrapTable('destroy');
        $('#table_department').bootstrapTable({
            url: '../paymentHistory/queryAllHistory.action',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            queryParams: function (params) {
                return {
                    pageNumber: params.offset + 1,
                    pageSize: params.limit,
                    dwid:dwid

                };
            },
            //传递参数（*）
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10000,                       //每页的记录行数（*）
            pageSize: 10000,                       //每页的记录行数（*）
            pageList: [10,25,100,200,100000],        //可供选择的每页的行数（*）
            clickToSelect: true,
            showExport: false,
            columns: [
                {
                    field: 'XM',
                    title: '姓名',
                    align: 'center',

                }, {
                    field: 'QSNY',
                    title: '起始年月',
                    align: 'center',

                }, {
                    field: 'ZZNY',
                    title: '终止年月',
                    align: 'center',

                }, {
                    field: 'GRJFE',
                    title: '个人缴费额',
                    align: 'center',

                }, {
                    field: 'LX',
                    title: '利息',
                    align: 'center',

                }]
        });
    }

    function unit() {
        $("#unit_modal").bootstrapTable('destroy');
        $('#unit_modal').bootstrapTable({
            url: '../department/querybykey.action',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            queryParams: function (params) {
                return {
                    pageNumber: params.offset + 1,
                    pageSize: params.limit,
                    dwbh: dwbh,
                    dwmc: dwmc
                };
            },
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50],        //可供选择的每页的行数（*）
            clickToSelect: true,
            showExport: false,
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
            $('#dwid').val(row[0]["dwid"]);
        }
        dwid =$("#dwid").val();
        showHistory();
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
        $('#table_department').bootstrapTable('destroy');
        $('#export').hide()
    });

</script>
</body>
</html>
