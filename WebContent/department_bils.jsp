<%--
  Created by IntelliJ IDEA.
  User: Administrator
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
    <title>单位单据查询</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="bootstrap-table/bootstrap-table.css" type="text/css">
    <script type="text/javascript" src="bootstrap/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="bootstrap-table/bootstrap-table.js"></script>
    <script type="text/javascript" src="bootstrap-table/tableExport.js"></script>
    <script type="text/javascript" src="bootstrap-table/extensions/export/bootstrap-table-export.js"></script>
    <script type="text/javascript" src="bootstrap-table/bootstrap-table-zh-CN.js"></script>
</head>
<body>
<%@include file="commonTop.jsp"%>
<div class="" style="margin-top: 1%;margin-left: 0px">
    <div class="col-xs-3 col-md-4">
        <div class="input-group">
            <span class="input-group-addon">单据类型:</span>
            <select  id="djlb" name="djlb"  class="form-control">
                <option value="1">已确认单据</option>
                <option value="0">未确认单据</option>
                <option value="3">已冲销单据</option>
                <option value="2">已作废单据</option>
            </select>
        </div>
    </div>
    <div class="col-xs-3 col-md-4">
        <div class="input-group">
            <span class="input-group-addon">填写时间:</span>
            <input type="date" class="form-control" id="time"/>
        </div>
    </div>
    <div class="col-xs-3 col-md-4">
        <button id="query" class="btn btn-primary btn-sm" data-toggle="button">查询</button>
        <button id="modify_status" onclick="modifyStatusByDwid()" class="btn btn-primary btn-sm"
                data-toggle="button">
            修改单据状态
        </button>
        <button id="modify_status2" onclick="toVoidByDwid()" class="btn btn-primary btn-sm"
                data-toggle="button">
            作废单据
        </button>
    </div>
</div>
<div>
    <table id="bil_table">

    </table>
</div>
</div>
<script type="text/javascript">
    var type = "";
    var time ="";

    $(document).ready(function() {
        $("#dwid").val(dwid);
        $("#dwmc").val(dwmc);
        $("#dwbh").val(dwbh);
    });


    $("#query").click(function () {
        type = $("#djlb").val();
        time = $("#time").val();
        queryBils();
    });

    function queryBils() {
        $('#bil_table').bootstrapTable('destroy');
        $('#bil_table').bootstrapTable({
            url: '../departmentBills/querydepartmentbils.action',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: false,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams : function (params) {
                return {
                    pageNumber: params.offset + 1,
                    pageSize: params.limit,
                    time:time,
                    dwid: dwid,
                    type: type
                };
            },
            //传递参数（*）
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100,1000],        //可供选择的每页的行数（*）
            clickToSelect:true,
            showExport: true,                     //是否显示导出
            exportDataType: "all",              //basic', 'all', 'selected'.
            columns: [ {
                field: 'zdlsh',
                title: '自动流水号',
            }, {
                field: 'dwid',
                title: '单位名称',
            }, {
                field:'djlb',
                title:'单据类别',
            },{
                field: 'djzt',
                title: '单据状态',
            }, {
                field: 'txr',
                title: '填写人'
            },  {
                field: 'txsj',
                title: '填写时间',
                formatter: function (value, row, index) {
                    return Todate(value)
                }
            },  {
                field: 'qrr',
                title: '确认人',
            },  {
                field: 'qrsj',
                title: '确认时间',
                formatter: function (value, row, index) {
                    return Todate(value)
                }
            }, {
                field: 'zje',
                title: '总金额(单位:元)',
            },
                {
                    field: 'personOpId',
                    title: '操作',
                    align: 'center',
                    width: 150,
                    formatter: operateFormatter

                }]
        });
    }

    function operateFormatter(value,row,index)
//row 获取这行的值 ，index 获取索引值
    {
        return [
            "<a href='index.jsp' target='_blank'><button type='button' class='btn btn-small btn-info'" +
            "style='margin-right:15px;' id='m-callback-this-start'" +
            " onclick ='showGrbh()'>查看 </button></a>"
        ].join('');

    }

    function Todate(num) { //Fri Oct 31 18:00:00 UTC+0800 2008
        num = num + "";
        var date = "";
        var month = new Array();
        month["Jan"] = 1; month["Feb"] = 2; month["Mar"] = 3; month["Apr"] = 4; month["May"] = 5; month["Jun"] = 6;
        month["Jul"] = 7; month["Aug"] = 8; month["Sep"] = 9; month["Oct"] = 10; month["Nov"] = 11; month["Dec"] = 12;
        var week = new Array();
        week["Mon"] = "一"; week["Tue"] = "二"; week["Wed"] = "三"; week["Thu"] = "四"; week["Fri"] = "五"; week["Sat"] = "六"; week["Sun"] = "日";
        str = num.split(" ");
        date = str[5] + "-";
        date = date + month[str[1]] + "-" + str[2];
        return date;
    }
</script>
</body>
</html>
