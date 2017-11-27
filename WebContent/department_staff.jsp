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
    <title>人员</title>
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="bootstrap-table/bootstrap-table.css" type="text/css">
    <link rel="stylesheet" href="bootstrap/custom/department.css" type="text/css">
    <script type="text/javascript" src="bootstrap/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="bootstrap-table/bootstrap-table.js"></script>
    <script type="text/javascript" src="bootstrap-table/tableExport.js"></script>
    <script type="text/javascript" src="bootstrap-table/extensions/export/bootstrap-table-export.js"></script>
    <script type="text/javascript" src="bootstrap-table/bootstrap-table-zh-CN.js"></script>
    <script type="text/javascript" src="../js/dialog.js"></script>
</head>
<body>
<%@include file="commonTop.jsp"%>
<div class="staff_p" style="margin-top: 1%;margin-left: 0px">

    <div class="row">
        <div class="col-xs-4 col-md-4">
            <button id="officer" class="btn btn-primary" data-toggle="button">在职人员</button>
            <button id="retiree" class="btn btn-primary" data-toggle="button">退休人员</button>
            <button id="unemployed" class="btn btn-primary" data-toggle="button">离职人员</button>
            <button id="add_staff" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">添加人员</button>
        </div>
    </div>
</div>

<div>
    <div id="toolbar">
    </div>
    <table id="per_table">

    </table>
</div>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-body">
                <form>

                    <div class="form-group">
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                        <span class="input-group-addon">姓名:</span>
                        <input type="text" class="form-control" id="xm" placeholder="姓名">
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                            <span class="input-group-addon">曾用名:</span>
                            <input type="text" class="form-control" id="cym" placeholder="曾用名">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-9 col-md-9">
                        <div class="input-group">
                            <span class="input-group-addon">身份证号码:</span>
                            <input type="text" class="form-control" id="sfzhm" placeholder="身份证号码">
                        </div>
                        </div>
                        <div class="col-xs-3 col-md-3">
                            <div class="input-group">
                                <span class="input-group-addon">性别:</span>
                                <select  id="xb" name="xb"  class="form-control">
                                    <option value=""></option>
                                    <option value="1">男</option>
                                    <option value="2">女</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <%--<div class="form-group">--%>
                    <%--<label>性别</label>--%>
                    <%--<input type="text" class="form-control" id="xb" placeholder="性别">--%>
                    <%--</div>--%>
                    <div class="form-group">
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                        <span class="input-group-addon">出生日期:</span>
                        <input type="text" class="form-control" id="csrq" placeholder="出生日期">
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon">财政编码:</span>
                            <input type="text" class="form-control" id="czbm" placeholder="财政编号">
                        </div>
                        </div>
                    </div>




                    <%--<div class="form-group">--%>
                        <%--<label>经办机构ID</label>--%>
                        <%--<input type="text" class="form-control" id="jbjgid" placeholder="经办机构ID">--%>
                    <%--</div>--%>

                    <div class="form-group">
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                            <span class="input-group-addon">身份性质:</span>
                            <select  id="sfxz" name="sfxz"  class="form-control">
                                <option value=""></option>
                                <option value="A">固定工</option>
                                <option value="B">合同制</option>
                                <option value="C">临时工</option>
                            </select>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                            <span class="input-group-addon">参保人员类别:</span>
                            <select  id="cbrylb" name="cbrylb"  class="form-control">
                                <option value=""></option>
                                <option value="A0A">在职</option>
                                <option value="A0F">离岗</option>
                                <option value="A0C">退休</option>
                            </select>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                        <span class="input-group-addon">民族:</span>
                        <select  id="mz" name="mz"  class="form-control">
                            <option value=""></option>
                            <option value="01">汉族</option>
                            <option value="02">蒙古族</option>
                            <option value="03">回族</option>
                            <option value="04">藏族</option>
                            <option value="05">维吾尔族</option>
                            <option value="06">苗族</option>
                            <option value="07">彝族</option>
                            <option value="08">壮族</option>
                            <option value="09">布依族</option>
                            <option value="10">朝鲜族</option>
                            <option value="11">满族</option>
                            <option value="12">侗族</option>
                            <option value="13">瑶族</option>
                            <option value="14">白族</option>
                            <option value="15">土家族</option>
                            <option value="16">哈尼族</option>
                            <option value="17">哈萨克族</option>
                            <option value="18">傣族</option>
                            <option value="19">黎族</option>
                            <option value="20">傈僳族</option>
                            <option value="21">佤族</option>
                            <option value="22">畲族</option>
                            <option value="23">高山族</option>
                            <option value="24">拉祜族</option>
                            <option value="25">水族</option>
                            <option value="26">东乡族</option>
                            <option value="27">纳西族</option>
                            <option value="28">景颇族</option>
                            <option value="29">柯尔克孜族</option>
                            <option value="30">土族</option>
                            <option value="31">达斡尔族</option>
                            <option value="32">仫佬族</option>
                            <option value="33">羌族</option>
                            <option value="34">布朗族</option>
                            <option value="35">撒拉族</option>
                            <option value="36">毛南族</option>
                            <option value="37">仡佬族</option>
                            <option value="38">锡伯族</option>
                            <option value="39">阿昌族</option>
                            <option value="40">普米族</option>
                            <option value="41">塔吉克族</option>
                            <option value="42">怒族</option>
                            <option value="43">乌兹别克族</option>
                            <option value="44">俄罗斯族</option>
                            <option value="45">鄂温克族</option>
                            <option value="46">德昂族</option>
                            <option value="47">保安族</option>
                            <option value="48">裕固族</option>
                            <option value="49">京族</option>
                            <option value="50">塔塔尔族</option>
                            <option value="51">独龙族</option>
                            <option value="52">鄂伦春族</option>
                            <option value="53">赫哲族</option>
                            <option value="54">门巴族</option>
                            <option value="55">珞巴族</option>
                            <option value="56">基诺族</option>
                            <option value="90">外籍人士</option>
                            <option value="99">其他</option>
                        </select>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                            <span class="input-group-addon">投保类别:</span>
                            <select  id="tblb" name="tblb"  class="form-control">
                                <option value=""></option>
                                <option value="A">养老保险</option>
                            </select>
                            </div>
                        </div>
                    </div>


                    <%--<div class="form-group">--%>
                        <%--<label>投保类别名称</label>--%>
                        <%--<input type="text" class="form-control" id="tblbmc" placeholder="投保类别名称">--%>
                    <%--</div>--%>
                    <div class="form-group">
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                        <span class="input-group-addon">参加工作时间:</span>
                        <input type="text" class="form-control" id="cjgzsj" placeholder="参加工作时间">
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                                <span class="input-group-addon">缴费类型:</span>
                            <select  id="jfly" name="jfly"  class="form-control">
                                <option value=""></option>
                                <option value="00">其他形式</option>
                                <option value="01">自收自支</option>
                                <option value="02">全额拨款</option>
                                <option value="03">差额拨款</option>
                            </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                        <span class="input-group-addon">户口性质:</span>
                        <select  id="hkxz" name="hkxz"  class="form-control">
                            <option value=""></option>
                            <option value="01">城镇</option>
                            <option value="02">农业</option>
                        </select>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon">个人身份:</span>
                            <select  id="grsf" name="grsf"  class="form-control">
                                <option value=""></option>
                                <option value="001">公务员</option>
                                <option value="002">工人</option>
                                <option value="003">干部</option>
                                <option value="004">职工</option>
                            </select>
                        </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                        <span class="input-group-addon">地址:</span>
                        <input type="text" class="form-control" id="dz" placeholder="地址">
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                        <div class="input-group">
                            <span class="input-group-addon">电话:</span>
                            <input type="text" class="form-control" id="dh" placeholder="电话">
                        </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                                <span class="input-group-addon">入伍时间:</span>
                                <input type="text" class="form-control" id="rwsj" placeholder="入伍时间">
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                            <span class="input-group-addon">调入时间:</span>
                            <input type="text" class="form-control" id="drsj" placeholder="调入时间">
                             </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                            <span class="input-group-addon">增员原因:</span>
                            <select  id="zyyy" name="zyyy"  class="form-control">
                            <option value=""></option>
                            <option value="001">关系转入</option>
                            <option value="002">毕业分配</option>
                            <option value="003">退伍军人</option>
                            <option value="004">调入</option>
                            <option value="005">招考</option>
                            </select>
                            </div>
                        </div>
                        <div class="col-xs-6 col-md-6">
                            <div class="input-group">
                                <span class="input-group-addon">减员原因:</span>
                                <select  id="jyyy" name="jyyy"  class="form-control">
                                    <option value=""></option>
                                    <option value="001">基金转移</option>
                                    <option value="002">在职死亡</option>
                                    <option value="003">在职转退休</option>
                                    <option value="004">系统删除</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" id="clear">清 空</button>
                <button type="button" class="btn btn-default" id="close">关 闭</button>
                <button type="button" class="btn btn-primary" id="save">保 存</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var types = "";
    $(document).ready(function() {
        $("#dwid").val(dwid);
        $("#dwmc").val(dwmc);
        $("#dwbh").val(dwbh);
    });


    $("#officer").click(function () {
        types = "A0A";
        per_table();
    });

    $("#retiree").click(function () {
        types = "A0C";
        per_table();
    });

    $("#unemployed").click(function () {

        types = "A0F";
        per_table();
    });

    function per_table() {
        $('#per_table').bootstrapTable('destroy');
        $('#per_table').bootstrapTable({
            url: '../staff/queryStaff.action',         //请求后台的URL（*）
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
                    dwid: dwid,
                    type: types
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
                checkbox: true
            }, {
                field: 'XM',
                title: '姓名',
            }, {
                field: 'SFZHM',
                title: '身份证号码',
            }, {
                field: 'GRBH',
                title: '个人编号',
                visible: true
            }, {
                field: 'CSRQ',
                title: '出生日期',
            }, {
                field: 'CJGZSJ',
                title: '参加工作时间'
            }, {
                field: 'TBLBMC',
                title: '投保类别',
                soetable: true
            }]
        });
    }

    function operateFormatter(value, row, index)
//row 获取这行的值 ，index 获取索引值
    {
        return [
            "<a href='index.jsp' target='_blank'><button type='button' class='btn btn-small btn-info'" +
            "style='margin-right:15px;' id='m-callback-this-start'" +
            " onclick ='showGrbh()'>查看 </button></a>"
        ].join('');

    }


    $("#clear").click(function () {

        $("#xm").val("");
        $("#cym").val("");
        $("#xb").val("");
        $("#sfzhm").val("");
        $("#csrq").val("");
        $("#sfxz").val("");
        $("#cbrylb").val("");
        $("#mz").val("");
        $("#tblb").val("");
        $("#tblbmc").val("");
        $("#cjgzsj").val("");
        $("#jfly").val("");
        $("#hkxz").val("");
        $("#dz").val("");
        $("#dh").val("");
        $("#grsf").val("");
        $("#rwsj").val("");
        $("#drsj").val("");
        $("#zyyy").val("");
        $("#jyyy").val("");
        $("#bz").val("");
        $("#ryid").val("");
        $("#rydjid").val("");
        $("#czbm").val("");
        $("#ygrbh").val("");
        $("#jbjgid").val("");
    });

    $("#close").click(function () {
        $('#exampleModal').modal('hide');
    });

    $("#save").click(function () {
        var xm = $("#xm").val();
        var cym = $("#cym").val();
        var xb = $("#xb").val();
        var sfzhm = $("#sfzhm").val();
        var csrq = $("#csrq").val();
        var sfxz = $("#sfxz").val();
        var cbrylb = $("#cbrylb").val();
        var mz = $("#mz").val();
        var tblb = $("#tblb").val();
        var cjgzsj = $("#cjgzsj").val();
        var jfly = $("#jfly").val();
        var hkxz = $("#hkxz").val();
        var dz = $("#dz").val();
        var dh = $("#dh").val();
        var grsf = $("#grsf").val();
        var rwsj = $("#rwsj").val();
        var drsj = $("#drsj").val();
        var zyyy = $("#zyyy").val();
        var jyyy = $("#jyyy").val();
        var czbm = $("#czbm").val();
        var ygrbh = "";
        var grbh ="";
        var jbjgid = $("#jbjgid").val();
        var dwid =  $("#dwid").val();
        var bz ="";
        $.ajax({
            type: "POST",
            url: "staff/saveStaff.action",
            data: {
                "xm": xm, "cym": cym, "xb": xb, "sfzhm": sfzhm, "csrq": csrq
                , "sfxz": sfxz, "cbrylb": cbrylb, "mz": mz, "tblb": tblb, "tblbmc": "养老保险",
                "cjgzsj": cjgzsj, "jfly": jfly, "hkxz": hkxz, "dz": dz, "dh": dh,
                "grsf": grsf, "rwsj": rwsj, "drsj": drsj, "zyyy": zyyy, "jyyy": jyyy,
                "dwid": dwid, "cbrylb": cbrylb, "czbm": czbm,
                "ygrbh": ygrbh, "jbjgid": "37091103","bz":bz
            },
            dataType: "JSON",
            async: false,
            success: function (data, status) {
                alert("增员成功!");
                $('#exampleModal').modal('hide');
            },
            error: function (err, status) {
                alert("增员失败!");
                $('#exampleModal').modal('hide');
            }
        });

    });


</script>
</body>
</html>
