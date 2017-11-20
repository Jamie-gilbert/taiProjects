<%--
  Created by IntelliJ IDEA.
  User: ggg
  Date: 2017/11/19
  Time: 13:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>维护利率</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="bootstrap-table/bootstrap-table.css" type="text/css">
    <link rel="stylesheet" href="bootstrap/css/bootstrap-datetimepicker.min.css" type="text/css">
    <link rel="stylesheet" href="../x-editable/dist/bootstrap3-editable/css/bootstrap-editable.css">


</head>
<body>
<div id="toolbar" class="btn-group">
    <button id="btn_add" data-toggle="modal" data-target="#exampleModal" type="button" class="btn btn-default">
        <span class="glyphicon glyphicon-plus" aria-hidden="true"></span>新增
    </button>

    <button id="btn_save" type="button" class="btn btn-default">
        <span class="glyphicon glyphicon-ok" aria-hidden="true"></span>保存
    </button>
</div>
<table id="scale_table">

</table>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" id="btnClose" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="exampleModalLabel">添加人员</h4>
            </div>
            <div class="modal-body">
                <form>

                    <div class="row">
                        <div class="form-group">
                            <label for="dtp_input2" class="col-md-2 control-label">年份</label>
                            <div class="input-group date form_date col-md-5" data-date="" data-date-format="yyyy"
                                 data-link-field="dtp_input2" data-link-format="yyyy">
                                <input class="form-control" size="16" id="dtp_input1" type="text" value="" readonly>
                                <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                                <span class="input-group-addon"><span
                                        class="glyphicon glyphicon-calendar"></span></span>
                            </div>
                            <input type="hidden" id="dtp_input2" value=""/><br/>
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-2 control-label">利率</label>
                        <div class="form-group col-md-10">
                            <input type="number" class="form-control " id="ll" placeholder="请输入利率">
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="clear">清 空</button>
                <button type="button" class="btn btn-primary" id="save">保 存</button>
            </div>
        </div>
    </div>
</div>
<script src="../js/jquery.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="../js/dialog.js"></script>
<script type="text/javascript" src="bootstrap-table/bootstrap-table.js"></script>
<script type="text/javascript" src="bootstrap-table/bootstrap-table-zh-CN.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap-datetimepicker.min.js"></script>
<script type="text/javascript" src="bootstrap/editable/bootstrap-table-editable.js"></script>
<script src="../x-editable/dist/bootstrap3-editable/js/bootstrap-editable.js"></script>
<script type="text/javascript">
    $('.form_date').datetimepicker({
        language: 'fr',
        weekStart: 1,
        todayBtn: 0,
        autoclose: 1,
        todayHighlight: 1,
        startView: 4,
        minView: 4,
        forceParse: 0
    });

    $(document).ready(function () {
        scale_table();
    })

    function scale_table() {
        $('#scale_table').bootstrapTable('destroy');
        $('#scale_table').bootstrapTable({
            url: '../interestScale/queryAllInterestScales.action',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: false,                   //是否显示分页（*）
            sortable: false,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            editable: true,

            columns: [{
                field: 'current_year',
                title: '年份',
                align: 'center',

            }, {
                field: 'interest_scale',
                title: '利率',
                align: 'center',
                editable: {
                    type: 'text',
                    title: '年份'
                }
            }]
        });
    }

    $('#btn_save').click(function () {

        var data = $('#scale_table').bootstrapTable('getData');

        $.ajax({
            type: "POST",
            url: "../interestScale/modifyInterestScale.action",
            data: {
                "data": JSON.stringify(data)
            },
            dataType: "JSON",
            async: false,
            success: function (data, status) {
                debugger
                if (data.errorCode == 0) {
                    Alert({
                        msg: '保存成功',
                        title: "提示",
                        onOk: function () {
                            $('#exampleModal').modal('hide');

                        }

                    });
                } else {
                    Alert({
                        msg: data.errorText,
                        title: "提示"

                    });
                }

            },
            error: function (err, status) {
                Alert({
                    msg: '修改利率失败，请重试',
                    title: "提示"
                });
            }
        });

    });
    $("#clear").click(function () {

        $("#ll").val("");
        $("#dtp_input2").val("");
        $("#dtp_input1").val("");

    });


    $("#save").click(function () {
        debugger;
        var ll = $("#ll").val();
        var year = $("#dtp_input2").val();

        $.ajax({
            type: "POST",
            url: "../interestScale/addInterestScale.action",
            data: {
                "ll": ll, "year": year
            },
            dataType: "JSON",
            async: false,
            success: function (data, status) {
                debugger
                if (data.errorCode == 0) {
                    Alert({
                        msg: '保存成功',
                        title: "提示",
                        onOk: function () {
                            $('#exampleModal').modal('hide');
                            scale_table()
                        }

                    });
                } else {
                    Alert({
                        msg: data.errorText,
                        title: "提示"

                    });
                }

            },
            error: function (err, status) {
                Alert({
                    msg: '添加利率，请重试',
                    title: "提示"
                });
            }
        });

    });
</script>
</body>
</html>
