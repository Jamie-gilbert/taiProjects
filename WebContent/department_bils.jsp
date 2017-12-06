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
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css">
    <link rel="stylesheet" href="bootstrap/custom/department.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="./bootstrap/custom/department.css">

</head>
<body>
<%@include file="commonTop.jsp" %>
<div class="" style="margin-top: 1%;margin-left: 0px">
    <div class="col-xs-3 col-md-4">
        <div class="input-group">
            <span class="input-group-addon">单据类型:</span>
            <select id="djlb" name="djlb" class="form-control">
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
        <%--<button id="modify_status" onclick="modifyStatusByDwid()" class="btn btn-primary btn-sm"--%>
        <%--data-toggle="button">--%>
        <%--修改单据状态--%>
        <%--</button>--%>
        <%--<button id="modify_status2" onclick="toVoidByDwid()" class="btn btn-primary btn-sm"--%>
        <%--data-toggle="button">--%>
        <%--作废单据--%>
        <%--</button>--%>
    </div>
</div>
<div>
    <table id="bil_table">

    </table>
</div>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" id="btnClose" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="exampleModalLabel">缴费历史</h4>
            </div>
            <div class="modal-body table-responsive">
                <table id="bil_history">

                </table>
            </div>

        </div>
    </div>
</div>


</div>

<script type="text/javascript" src="/bootstrap/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/bootstrap-table/bootstrap-table.js"></script>
<script type="text/javascript" src="/bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="../webTree/assets/js/bui-min.js"></script>
<script type="text/javascript" src="../webTree/assets/js/config-min.js"></script>
<script type="text/javascript" src="../js/dialog.js"></script>
<script type="text/javascript">
    var type = "";
    var time = "";

    $(document).ready(function () {
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
            queryParams: function (params) {
                return {
                    pageNumber: params.offset + 1,
                    pageSize: params.limit,
                    time: time,
                    dwid: dwid,
                    type: type
                };
            },
            //传递参数（*）
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100, 1000],        //可供选择的每页的行数（*）
            clickToSelect: true,
            showExport: true,                     //是否显示导出
            exportDataType: "all",              //basic', 'all', 'selected'.
            columns: [{
                field: 'zdlsh',
                title: '自动流水号',
            }, {
                field: 'dwid',
                title: '单位名称',
                formatter: function (value, row, index) {
                    return $("#dwmc").val();
                }
            }, {
                field: 'djlb',
                title: '单据类别',
                formatter: function (value, row, index) {
                    if (row['djlb'] === 'SI1001') {
                        return '收缴单据';
                    }
                    if (row['djlb'] === 'SI1002') {
                        return '退费单据';
                    }
                    return value;
                }
            }, {
                field: 'djzt',
                title: '单据状态',
                formatter: function (value, row, index) {
                    if (row['djzt'] === '0') {
                        return '未确认';
                    }
                    if (row['djzt'] === '1') {
                        return '已确认';
                    }
                    if (row['djzt'] === '2') {
                        return '已作废';
                    }
                    if (row['djzt'] === '3') {
                        return '冲销';
                    }
                    if (row['djzt'] === '4') {
                        return '被冲销';
                    }
                    return value;
                }
            }, {
                field: 'txr',
                title: '填写人',
                formatter: function (value, row, index) {
                    return 'admin';
                }
            }, {
                field: 'txsj',
                title: '填写时间',
                formatter: function (value, row, index) {
                    return Todate(row['txsj'])
                }
            }, {
                field: 'qrr',
                title: '确认人',
                formatter: function (value, row, index) {
                    return 'admin'
                }
            }, {
                field: 'qrsj',
                title: '确认时间',
                formatter: function (value, row, index) {
                    return Todate(row['qrsj'])
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
                    formatter: function (value, row, index) {
                        if (row['djlb']==='SI1001'|| row['djzt'] ==='1'){
                           return operateFormatter2(value, row, index);
                        }else {
                           return operateFormatter(value, row, index);
                        }
                        return value;
                    }

                }]
        });
    }

    function operateFormatter(value, row, index)
//row 获取这行的值 ，index 获取索引值
    {
        return [
            "<button type='button' " +
            "  class='btn btn-small btn-info' " +
            "style='margin-right:15px;'  " +
            " onclick ='cancelBill(" + JSON.stringify(row) + ")'>作废 </button>"
            ,
            "<button type='button' " +
            "  class='btn btn-small btn-info' " +
            "style='margin-right:15px;' " +
            " onclick ='queryBill(" + JSON.stringify(row) + ")'>确认 </button>"
        ].join('');

    }


    function operateFormatter2(value, row, index)
//row 获取这行的值 ，index 获取索引值
    {
        return [
            "<button type='button' " +
            "  class='btn btn-small btn-info' " +
            "style='margin-right:15px;' id='m-callback-this-start' " +
            "data-toggle='modal' id='query'  data-target='#exampleModal'" +
            " onclick ='showData(" + JSON.stringify(row) + ")'>查看 </button>"
        ].join('');

    }

    function showData(row) {
        showHistory(row.zdlsh)
    }

    function showHistory(zdlsh) {
        $('#bil_history').bootstrapTable('destroy');
        $('#bil_history').bootstrapTable({
            url: '../paymentHistory/queryByZDLSH.action',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
//            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: false,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams: function (params) {
                return {
                    pageNumber: params.offset + 1,
                    pageSize: params.limit,
                    zdlsh: zdlsh
                };
            },
            //传递参数（*）
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100, 1000],        //可供选择的每页的行数（*）
            clickToSelect: true,
            showExport: true,                     //是否显示导出
            exportDataType: "all",              //basic', 'all', 'selected'.
            columns: [
                {
                    field: 'SFZHM',
                    title: '身份证号码',
                    align: 'center',

                }, {
                    field: 'XM',
                    title: '姓名',
                    align: 'center',

                },
                {
                    field: 'qsny',
                    title: '起始年月',
                    align: 'center',

                }, {
                    field: 'zzny',
                    title: '终止年月',
                    align: 'center',

                }, {
                    field: 'xzbz',
                    title: '险种标志',
                    align: 'center',

                }, {
                    field: 'zje',
                    title: '个人缴费额',
                    align: 'center',

                }, {
                    field: 'lx',
                    title: '利息',
                    align: 'center',

                }]
        });
    }


    function queryBill(row) {
        if (type == '0') {
            $.ajax({
                type: "POST",
                url: "../departmentBills/modifyStatusByZDLSH.action",
                dataType: "JSON",
                data: {
                    dwid: dwid,
                    zdlsh: row.zdlsh,
                    djzt: '1'

                },
                async: true,
                success: function (data, status) {
                    console.log(data)

                    Alert({
                        msg: '确认成功',
                        title: "提示",
                    });
                    queryBils();
                },
                error: function (err, status) {
                    console.log(err)
                    Alert({
                        msg: '确认失败',
                        title: "提示",
                    })
                }
            });
        } else {
            Alert({
                msg: '只能作废未确认的单据',
                title: "提示",
            });
            queryBils();
        }
    }


    function cancelBill(row) {
        if (type == '0') {
            $.ajax({
                type: "POST",
                url: "../departmentBills/modifyStatusByZDLSH.action",
                dataType: "JSON",
                data: {
                    dwid: dwid,
                    zdlsh: row.zdlsh,
                    djzt: '2'

                },
                async: true,
                success: function (data, status) {
                    console.log(data)

                    Alert({
                        msg: '作废成功',
                        title: "提示",
                    });
                    queryBils();
                },
                error: function (err, status) {
                    console.log(err)
                    Alert({
                        msg: '作废失败',
                        title: "提示",
                    })
                }
            });
        } else {
            Alert({
                msg: '只能作废未确认的单据',
                title: "提示",
            })
        }
    }


    function Todate(num) { //Fri Oct 31 18:00:00 UTC+0800 2008
       var date = num.toString().substr(0,10)
        return date;
    }
</script>
</body>
</html>
