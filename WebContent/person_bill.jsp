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
    <title>人员信息</title>
    <link rel="stylesheet" href="css/bootstrap.css" type="text/css">
    <link rel="stylesheet" href="bootstrap/custom/department.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="./bootstrap/custom/department.css">
    <script type="text/javascript" src="/bootstrap/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="/bootstrap-table/bootstrap-table.js"></script>
    <script type="text/javascript" src="/bootstrap-table/bootstrap-table-zh-CN.js"></script>
    <script type="text/javascript" src="../webTree/assets/js/bui-min.js"></script>
    <script type="text/javascript" src="../webTree/assets/js/config-min.js"></script>
    <script type="text/javascript" src="../js/dialog.js"></script>
</head>
<body>

<button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#billModal" id="query_person">查询
</button>


<div class="modal fade" id="billModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">单据信息</h4>
            </div>
            <div class="modal-body">
                <table id="person_modal" style="border:solid 1px">
                    <tr>
                        <td>单位编号:</td>
                        <td>12345678</td>
                        <td>单位名称:</td>
                        <td>测试单位</td>
                    </tr>
                    <tr>
                        <td>个人编号:</td>
                        <td>1234567</td>
                        <td>姓名:</td>
                        <td>测试</td>
                    </tr>
                    <tr>
                        <td>单位缴纳:</td>
                        <td>1234567</td>
                        <td>个人缴纳:</td>
                        <td>122222</td>
                    </tr>
                    <tr>
                        <td>利息:</td>
                        <td>1234567</td>
                        <td>合计:</td>
                        <td>122222</td>
                    </tr>
                    <tr>
                        <td>填写时间:</td>
                        <td>1234567</td>
                        <td>填写人:</td>
                        <td>122222</td>
                    </tr>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="javascript:window.print();">打印</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
