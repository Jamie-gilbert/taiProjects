<%--
  Created by IntelliJ IDEA.
  User: ggg
  Date: 2017/11/12
  Time: 18:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>人员退费</title>

    <link rel="stylesheet" href="../css/bootstrap.css">
</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-xs-3 col-md-3">
            <div class="input-group">
                <span class="input-group-addon">身份证号码:</span>
                <input type="text" class="form-control" id="sfzhm"/>
            </div>
        </div>
        <div class="col-xs-3 col-md-3">
            <div class="input-group">
                <span class="input-group-addon">起始日期:</span>
                <input type="month" class="form-control" id="qsrq"/>
            </div>
        </div>
        <div class="col-xs-3 col-md-3">
            <div class="input-group">
                <span class="input-group-addon">终止日期:</span>
                <input type="month" class="form-control" id="zzrq"/>
            </div>
        </div>
        <div class="col-xs-3 col-md-3">
            <button type="button" class="btn btn-primary" onclick="queryData()"> 查 询</button>
        </div>
    </div>

    <div class="row">
        <div class="col-xs-3 col-md-3">
            <button type="button" class="btn btn-primary" onclick="rebackPayment()"> 退 费</button>
        </div>

    </div>
</div>


<script src="../js/jquery.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/dialog.js"></script>
<script type="text/javascript">
    var ryid = "";

    function queryData() {
        debugger;
        var sfzhm = $('#sfzhm').val();
        var qsrq = $('#qsrq').val();
        var zzrq = $('#zzrq').val();

        $.ajax({
            type: "POST",
            url: "../paymentHistory/qyeryByRyidWithDate.action",
            data: {
                "sfzhm": sfzhm, "qsrq": qsrq,
                "zzrq": zzrq, "pageNumber": "1", "pageSize": "10"
            },
            async: false,
            dataType: "JSON",
            success: function (data, status) {
                console.log(data)
                ryid = data.ryid;
            },
            error: function (err, status) {
                console.log(err)
            }

        });
    }

    function rebackPayment() {
        var qsrq = $('#qsrq').val();
        var zzrq = $('#zzrq').val();
        $.ajax({
            type: "POST",
            url: "../paymentHistory/queryCountWithoutInterestByRyidWithDate.action",
            data: {
                "ryid": ryid,
                "qsrq": qsrq,
                "zzrq": zzrq
            },
            async: false,
            dataType: "JSON",
            success: function (data, status) {
                console.log(data)
                var needInterest = data.needInterest;
                if (needInterest == true) {
                    Alert({
                        msg: '该人员有未计息的缴费，请先计息',
                        title: "提示",
                    })
                } else {
                    rebackPay();
                }
            },
            error: function (err, status) {
                console.log(err)
            }

        });
    }

    function rebackPay() {
        var qsrq = $('#qsrq').val();
        var zzrq = $('#zzrq').val();
        $.ajax({
            type: "POST",
            url: "../paymentHistory/rebackPaymentByRyIdWithDate.action",
            data: {
                "ryid": ryid,
                "qsrq": qsrq,
                "txr": "111",
                "zzrq": zzrq
            },
            async: false,
            dataType: "JSON",
            success: function (data, status) {
                console.log(data)
                var needInterest = data.errorCode;
                if (needInterest == 0) {
                    Alert({
                        msg: '退费成功',
                        title: "提示",
                    })
                }
            },
            error: function (err, status) {
                console.log(err)
            }

        });
    }
</script>
</body>
</html>
