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
<div style="border-bottom:1px solid cornflowerblue;padding-bottom: 5px">
    <div class="row department">
        <div class="col-xs-2 col-md-3">
            <div class="input-group">
                <span class="input-group-addon">个人编号:</span>
                <input type="text" class="form-control" id="grbh"/>
            </div>
        </div>
        <div class="col-xs-2 col-md-3">
            <div class="input-group">
                <span class="input-group-addon">个人姓名:</span>
                <input type="text" class="form-control" id="grxm"/>
            </div>
        </div>
        <div class="col-xs-2 col-md-3">
            <div class="input-group">
                <span class="input-group-addon">身份证号:</span>
                <input type="text" class="form-control" id="grsfzhm"/>
            </div>
        </div>
        <div class="col-xs-1 col-md-2" >
            <button class="btn btn-primary btn-sm" data-toggle="modal" data-target="#personModal" id="query_person">查询</button>
            <button class="btn btn-primary btn-sm" data-toggle="button" id="reset" type="reset">重置</button>
        </div>
    </div>
    <div class="container-fluid" id="unitButton">
        <a id="rytf" class="page-action btn btn-primary btn-sm" href="#"  title="人员退费">
            人员退费
        </a>
        <a class="page-action btn btn-primary btn-sm" href="../paymentHistory/qyeryInterestByRyid.action?ryid=11100000000000008807&pageNumber=1&pageSize=10">
            个人计息
        </a>
        <a class="btn btn-primary btn-sm" onclick="setData()" data-toggle="modal" data-target="#exampleModal">
            修改个人信息
        </a>
        <a class="btn btn-primary btn-sm" onclick="" data-toggle="modal" >
            缴费历史维护
        </a>
        <a class="btn btn-primary btn-sm" onclick="" data-toggle="modal" >
            个人单据管理
        </a>
    </div>
</div>

<div class="modal fade" id="personModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static" data-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title" id="myModalLabel">个人信息</h4>
            </div>
            <div class="modal-body">
                <table id="person_modal"></table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="getPerson()">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" id="btnClose" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
                <h4 class="modal-title" id="exampleModalLabel">修改人员信息</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label>人员ID</label>
                        <input type="text" class="form-control" id="ryid" placeholder="人员ID">
                    </div>
                    <div class="form-group">
                        <label>人员登记ID</label>
                        <input type="text" class="form-control" id="rydjid" placeholder="人员登记ID">
                    </div>
                    <div class="form-group">
                        <label>财政编号</label>
                        <input type="text" class="form-control" id="czbm" placeholder="财政编号">
                    </div>
                    <div class="form-group">
                        <label>原个人编号</label>
                        <input type="text" class="form-control" id="ygrbh" placeholder="原个人编号">
                    </div>
                    <div class="form-group">
                        <label>经办机构ID</label>
                        <input type="text" class="form-control" id="jbjgid" placeholder="经办机构ID">
                    </div>
                    <div class="form-group">
                        <label>姓名</label>
                        <input type="text" class="form-control" id="xm" placeholder="姓名">
                    </div>

                    <div class="form-group">
                        <label>曾用名</label>
                        <input type="text" class="form-control" id="cym" placeholder="曾用名">
                    </div>

                    <div class="form-group">
                        <label>性别</label>
                        <input type="text" class="form-control" id="xb" placeholder="性别">
                    </div>
                    <div class="form-group">
                        <label>身份证号码</label>
                        <input type="text" class="form-control" id="sfzhm" placeholder="身份证号码">
                    </div>

                    <div class="form-group">
                        <label>出生日期</label>
                        <input type="text" class="form-control" id="csrq" placeholder="出生日期">
                    </div>

                    <div class="form-group">
                        <label>身份性质</label>
                        <input type="text" class="form-control" id="sfxz" placeholder="身份性质">
                    </div>

                    <div class="form-group">
                        <label>参保人员类别</label>
                        <input type="text" class="form-control" id="cbrylb" placeholder="参保人员类别">
                    </div>
                    <div class="form-group">
                        <label>民族</label>
                        <input type="text" class="form-control" id="mz" placeholder="民族">
                    </div>
                    <div class="form-group">
                        <label>投保类别</label>
                        <input type="text" class="form-control" id="tblb" placeholder="投保类别">
                    </div>

                    <div class="form-group">
                        <label>投保类别名称</label>
                        <input type="text" class="form-control" id="tblbmc" placeholder="投保类别名称">
                    </div>
                    <div class="form-group">
                        <label>参加工作时间</label>
                        <input type="text" class="form-control" id="cjgzsj" placeholder="参加工作时间">
                    </div>
                    <div class="form-group">
                        <label>经费来源</label>
                        <input type="text" class="form-control" id="jfly" placeholder="经费来源">
                    </div>
                    <div class="form-group">
                        <label>户口性质</label>
                        <input type="text" class="form-control" id="hkxz" placeholder="户口性质">
                    </div>
                    <div class="form-group">
                        <label>地址</label>
                        <input type="text" class="form-control" id="dz" placeholder="地址">
                    </div>
                    <div class="form-group">
                        <label>电话</label>
                        <input type="text" class="form-control" id="dh" placeholder="电话">
                    </div>
                    <div class="form-group">
                        <label>个人身份</label>
                        <input type="text" class="form-control" id="grsf" placeholder="个人身份">
                    </div>
                    <div class="form-group">
                        <label>入伍时间</label>
                        <input type="text" class="form-control" id="rwsj" placeholder="入伍时间">
                    </div>
                    <div class="form-group">
                        <label>调入时间</label>
                        <input type="text" class="form-control" id="drsj" placeholder="调入时间">
                    </div>
                    <div class="form-group">
                        <label>增员原因</label>
                        <input type="text" class="form-control" id="zyyy" placeholder="增员原因">
                    </div>
                    <div class="form-group">
                        <label>减员原因</label>
                        <input type="text" class="form-control" id="jyyy" placeholder="减员原因">
                    </div>
                    <div class="form-group">
                        <label>备注</label>
                        <input type="text" class="form-control" id="bz" placeholder="备注">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" id="save">保 存</button>
            </div>
        </div>
    </div>
</div>

<div class="person_show">
    <input name="ryid" type="text" id="tcryid" hidden="hidden" readonly>
    <div>
        <div class="col-xs-6 col-xs-6">
            <div class="input-group">
                <span class="input-group-addon">个人编号:</span>
                <input name="grbh" type="text" id="tcgrbh" class="form-control" readonly>
            </div>
        </div>
        <div class="col-xs-6 col-xs-6">
            <div class="input-group">
                <span class="input-group-addon">身份证号码:</span>
                <input name="grbh" type="text" id="tcsfzhm" class="form-control" readonly>
            </div>
        </div>
    </div>
    <div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">姓名:</span>
                <input name="xm" type="text" id="tcxm" class="form-control" readonly>
            </div>
        </div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">性别:</span>
                <input name="xb" type="text" id="tcxb" class="form-control" readonly>
            </div>
        </div>
    </div>
    <div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">民族:</span>
                <input name="mz" type="text" id="tcmz" class="form-control" readonly>
            </div>
        </div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">出生日期:</span>
                <input name="csrq" type="text" id="tccsrq" class="form-control" readonly>
            </div>
        </div>
    </div>
    <div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">身份性质:</span>
                <input name="sfxz" type="text" id="tcsfxz" class="form-control" readonly>
            </div>
        </div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">参保人员类别:</span>
                <input name="tbrylb" type="text" id="tctbrylb" class="form-control" readonly>
            </div>
        </div>
    </div>
    <div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">参加工作时间:</span>
                <input name="tblbmc" type="text" id="tccjgzsj" class="form-control" readonly>
            </div>
        </div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">投保类别名称:</span>
                <input name="cjgzsj" type="text" id="tctblbmc" class="form-control" readonly>
            </div>
        </div>
    </div>
    <div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">户口性质:</span>
                <input name="hkxz" type="text" id="tchkxz" class="form-control" readonly>
            </div>
        </div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">地址:</span>
                <input name="dz" type="text" id="tcdz" class="form-control" readonly>
            </div>
        </div>
    </div>
    <div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">电话:</span>
                <input name="dh" type="text" id="tcdh" class="form-control" readonly>
            </div>
        </div>
        <div class=" col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">个人身份:</span>
                <input name="grsf" type="text" id="tcgrsf" class="form-control" readonly>
            </div>
        </div>
    </div>
    <div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">入伍时间:</span>
                <input name="rwsj" type="text" id="tcrwsj" class="form-control" readonly>
            </div>
        </div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">调入时间:</span>
                <input name="drsj" type="text" id="tcdrsj" class="form-control" readonly>
            </div>
        </div>
    </div>
    <div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">增员原因:</span>
                <input name="zyyy" type="text" id="tczyyy" class="form-control" readonly>
            </div>
        </div>
        <div class="col-xs-6 col-md-6">
            <div class="input-group">
                <span class="input-group-addon">减员原因:</span>
                <input name="jyyy" type="text" id="tcjyyy" class="form-control" readonly>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    //    var currentList;
    //    var grbh;
    //
    //    function setData() {
    //
    //        //选择数据的坐标，在0到count之间
    //        var currentIndex = 0;
    //        grbh = currentList[currentIndex].GRBH;
    //        $("#xm").val(currentList[currentIndex].XM);
    //        $("#cym").val(currentList[currentIndex].CYM);
    //        $("#xb").val(currentList[currentIndex].XB);
    //        $("#sfzhm").val(currentList[currentIndex].SFZHM);
    //        $("#csrq").val(currentList[currentIndex].CSRQ);
    //        $("#sfxz").val(currentList[currentIndex].SFXZ);
    //        $("#cbrylb").val(currentList[currentIndex].cbrylb);
    //        $("#mz").val(currentList[currentIndex].MZ);
    //        $("#tblb").val(currentList[currentIndex].TBLB);
    //        $("#tblbmc").val(currentList[currentIndex].TBLBMC);
    //        $("#cjgzsj").val(currentList[currentIndex].CJGZSJ);
    //        $("#jfly").val(currentList[currentIndex].JFLY);
    //        $("#hkxz").val(currentList[currentIndex].HKXZ);
    //        $("#dz").val(currentList[currentIndex].DZ);
    //        $("#dh").val(currentList[currentIndex].DH);
    //        $("#grsf").val(currentList[currentIndex].GRSF);
    //        $("#rwsj").val(currentList[currentIndex].RWSJ);
    //        $("#drsj").val(currentList[currentIndex].DRSJ);
    //        $("#zyyy").val(currentList[currentIndex].ZYYY);
    //        $("#jyyy").val(currentList[currentIndex].JYYY);
    //        $("#bz").val(currentList[currentIndex].BZ);
    //        $("#ryid").val(currentList[currentIndex].RYID);
    //        $("#rydjid").val(currentList[currentIndex].RYDJID);
    //        $("#czbm").val(currentList[currentIndex].CZBM);
    //        $("#ygrbh").val(currentList[currentIndex].YGRBH);
    //        $("#jbjgid").val(currentList[currentIndex].JBJGID);
    //    };
    var grbh ="";
    var grsfzhm ="";
    var grxm =""
    BUI.use('common/page');

    $(document).ready(function () {
        $('#query_person').click(function () {
            grbh = $('#grbh').val();
            grsfzhm = $('#grsfzhm').val();
            grxm = $('#grxm').val();
            person();
        });

    });

    function person() {
        $("#person_modal").bootstrapTable('destroy');
        $('#person_modal').bootstrapTable({
            url: '../staff/queryStaffInfo.action',         //请求后台的URL（*）
            method: 'get',                      //请求方式（*）
            // toolbar: '#toolbar',                //工具按钮用哪个容器
            striped: true,                      //是否显示行间隔色
            cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
            pagination: true,                   //是否显示分页（*）
            sortable: false,                     //是否启用排序
            sortOrder: "asc",                   //排序方式
            queryParams : function (params) {
                return {
                    pageNumber: params.offset + 1,
                    pageSize: params.limit,
                    grbh: grbh,
                    grxm: grxm,
                    grsfzhm:grsfzhm
                };
            },
            //传递参数（*）
            //传递参数（*）
            sidePagination: "server",           //分页方式：client客户端分页，server服务端分页（*）
            pageNumber: 1,                       //初始化加载第一页，默认第一页
            pageSize: 10,                       //每页的记录行数（*）
            pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
            clickToSelect:true,
            columns: [{
                checkbox: true
            }, {
                field: 'GRBH',
                title: '个人编号',
            },  {
                field: 'XM',
                title: '姓名',
            }, {
                field: 'TBLBMC',
                title: '投保类别',
            }]
        });
    }


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
        var tblbmc = $("#tblbmc").val();
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
        var bz = $("#bz").val();
        var ryid = $("#ryid").val();
        var rydjid = $("#rydjid").val();
        var czbm = $("#czbm").val();
        var ygrbh = $("#ygrbh").val();
        var jbjgid = $("#jbjgid").val();


        $.ajax({
            type: "POST",
            url: "staff/modifyStaff.action",
            data: {
                "xm": xm, "cym": cym, "xb": xb, "sfzhm": sfzhm, "csrq": csrq
                , "sfxz": sfxz, "cbrylb": cbrylb, "mz": mz, "tblb": tblb, "tblbmc": tblbmc,
                "cjgzsj": cjgzsj, "jfly": jfly, "hkxz": hkxz, "dz": dz, "dh": dh,
                "grsf": grsf, "rwsj": rwsj, "drsj": drsj, "zyyy": zyyy, "jyyy": jyyy, "bz": bz,
                "cbrylb": cbrylb, "ryid": ryid, "rydjid": rydjid, "czbm": czbm,
                "ygrbh": ygrbh, "jbjgid": jbjgid, "grbh": grbh
            },
            dataType: "JSON",
            async: false,
            success: function (data, status) {
                Alert({
                    msg: '修改成功',
                    title: "提示",
                    onOk: function () {
                        $('#exampleModal').modal('hide');
                    },

                })
            },
            error: function (err, status) {
                Alert({
                    msg: '添加人员失败，请重试',
                    title: "提示",


                })
            }
        });

    });

    function getPerson() {
        row = $.map($("#person_modal").bootstrapTable('getSelections'), function (row) {
            return row;
        });
        if (row == "") {
            alert("请选择一个人员!");
        } else {
            $('#personModal').modal('hide');
            $('#grbh').val(row[0]["GRBH"]);
            $('#grsfzhm').val(row[0]["SFZHM"]);
            $('#grxm').val(row[0]["XM"]);
            $('#grbh').attr("readonly", true);
            $('#grsfzhm').attr("readonly", true);
            $('#grxm').attr("readonly", true);
            $('#tcgrbh').val(row[0]["GRBH"]);
            $('#tcsfzhm').val(row[0]["SFZHM"]);
            $('#tcxm').val(row[0]["XM"]);
            $('#tcDwmc').val(row[0]["DWID"]);
            $('#tccsrq').val(row[0]["CSRQ"]);
            $('#tccbrylb').val(row[0]["CBRYLB"]);
            $('#tcxb').val(row[0]["XB"]);
            $('#tcmz').val(row[0]["MZ"]);
            $('#tcsfxz').val(row[0]["SFXZ"]);
            $('#tccjgzsj').val(row[0]["CJGZSJ"]);
            $('#tctblbmc').val(row[0]["TBLBMC"]);
            $('#tcdz').val(row[0]["DZ"]);
            $('#tcdh').val(row[0]["DH"]);
            $('#tcgrsf').val(row[0]["GRSF"]);
            $('#tcrwsj').val(row[0]["RWSJ"]);
            $('#tcdrsj').val(row[0]["DRSJ"]);
            $('#tczyyy').val(row[0]["ZYYY"]);
            $('#tcjyy').val(row[0]["JYYY"]);
        }
        var grbh=$('#grbh').val();
        var xm=$('#grxm').val();
        var sfzhm=$('#grsfzhm').val();
        var grbh1 = grbh.substr(0,5);
        var grbh2 =grbh.substr(5,grbh.length);
        $('#rytf').attr('data-href',"../staff_reback_payment.jsp?grbh1="+grbh1+"&xm="+"'"+xm+"'"+"&grbh2="+grbh2);
//        $('#cxdj').attr('data-href',"../department_bils.jsp?dwid="+dwid+"&dwbh="+dwbh+"&dwmc="+dwmc);
//        $('#dwjx').attr('data-href',"../dempartment_interest.jsp?dwid="+dwid+"&dwbh="+dwbh+"&dwmc="+dwmc);
//        $('#cxdwjx').attr('data-href',"../dempartment_clear_interest.jsp?dwid="+dwid+"&dwbh="+dwbh+"&dwmc="+dwmc);
    }


    $("#reset").off().on("click",function(){
        $("#grbh").val("");
        $("#grxm").val("");
        $("#grsfzhm").val("");
        $('#grbh').attr("readonly",false)
        $('#grxm').attr("readonly",false)
        $('#grsfzhm').attr("readonly",false)
    });

</script>
</body>
</html>
