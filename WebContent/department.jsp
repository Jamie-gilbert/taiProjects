<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/18
  Time: 23:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<!--<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>单位</title>
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.js"></script>
    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="/bootstrap/custom/department.css">
</head>
<body>

<ul id="myTab" class="nav nav-tabs">
    <li class="active"><a href="#unit" data-toggle="tab">单位业务</a></li>
    <li><a href="#person" data-toggle="tab">个人业务</a></li>
    <li><a href="#systemC" data-toggle="tab">系统管理</a></li>
</ul>

<div id="myTabContent" class="tab-content">
<div class="tab-pane fade in active" id="unit">

</div>
<div class="tab-pane fade" id="person">

</div>
<div class="tab-pane fade" id="systemC" style="position:absolute">系统管理</div>
</div>

</body>  -->
<head>
    <title>DEMO</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/webTree/assets/css/dpl-min.css" rel="stylesheet" type="text/css" />
    <link href="/webTree/assets/css/bui-min.css" rel="stylesheet" type="text/css" />
    <link href="/webTree/assets/css/main-min.css" rel="stylesheet" type="text/css" />
</head>
<body>

<div class="header">
    <div class="dl-log"><span>当前系统时间:</span>
        <span id="clock"></span>
        欢迎您，<span class="dl-log-user">${user.yhxm}</span><a href="/index.jsp" title="退出系统" class="dl-log-quit">[退出]</a>
    </div>
</div>
<div class="content">
    <div class="dl-main-nav">
        <div class="dl-inform"><div class="dl-inform-title"><s class="dl-inform-icon dl-up"></s></div></div>
        <ul id="J_Nav"  class="nav-list ks-clear">
            <li class="nav-item dl-selected"><div class="nav-item-inner nav-home">单位管理</div></li>
            <li class="nav-item dl-selected"><div class="nav-item-inner nav-supplier">个人管理</div></li>
            <li class="nav-item dl-selected"><div class="nav-item-inner nav-sample">系统管理</div></li>
        </ul>
    </div>
    <ul id="J_NavContent" class="dl-tab-conten">

    </ul>
</div>
<script type="text/javascript" src="/webTree/assets/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="/webTree/assets/js/bui-min.js"></script>
<script type="text/javascript" src="/webTree/assets/js/common/main-min.js"></script>
<script type="text/javascript" src="/webTree/assets/js/config-min.js"></script>
<script>
    BUI.use('common/main',function(){
        var config = [{
            id:'unitWork',
            collapsed:false, //默认左侧菜单收缩
            homePage:'unitQuery', //默认打开的主页
            menu:[{
                text:'单位业务',
                items:[
                    {id: 'unitQuery', text: '单位综合业务', href: '/unit.jsp'}
                ]
            }]
        }, {
            id:'personWork',
            homePage:'personQuery',
            menu:[{text:'个人业务',
                items:[
                    {id:'personQuery',text:'个人综合业务',href:'/staff_info.jsp'}
                ]
            }]
        }, {
            id:'systemSet',
            homePage:'parameter',
            menu:[{text:'系统管理',
                items:[
                    {id:'parameter',text:'参数设置',href:'/index.jsp'},
                    {id:'user',text:'添加用户',href:'/register.jsp'}
                ]
            }]
        }];

        new PageUtil.MainPage({
            modulesConfig : config
        });
    });

    function realSysTime(clock){
        var now=new Date(); //创建Date对象
        var year=now.getFullYear(); //获取年份
        var month=now.getMonth(); //获取月份
        var date=now.getDate(); //获取日期
        var day=now.getDay(); //获取星期
        var hour=now.getHours(); //获取小时
        var minu=now.getMinutes(); //获取分钟
        var sec=now.getSeconds(); //获取秒钟
        month=month+1;
        var arr_week=new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
        var week=arr_week[day]; //获取中文的星期
        var time=year+"年"+month+"月"+date+"日 "+week+" "+hour+":"+minu+":"+sec; //组合系统时间
        clock.innerHTML=time; //显示系统时间
    }
    window.onload=function(){
        window.setInterval("realSysTime(clock)",1000); //实时获取并显示系统时间
    }
</script>

<script type="text/javascript">
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
                    debugger;
                    console.log(data)
                },
                error: function (err, status) {
                    debugger;
                    console.log(err)
                }


            });
        });
    });
</script>

</body>
</html>
