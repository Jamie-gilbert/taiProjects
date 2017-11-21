<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css">
    <link rel="stylesheet" href="bootstrap/custom/login.css" type="text/css">
    <script type="text/javascript" src="bootstrap/js/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <title>登录</title>
</head>
<body scroll="no">
<div class="container">
    <div class="row">
        <div class="col-md-offset-3 col-md-6">
            <form class="form-horizontal" action="../user/login.action" method="post" onsubmit="return checkCh();">
                <span class="heading">用户登录 </span>
                <div class="form-group">
                    <input type="text" class="form-control userName" id="userName" name="username" placeholder="用户名">
                    <i class="fa fa-user"></i>
                </div>
                <div class="form-group help">
                    <input type="password" class="form-control password" id="password" name="password" placeholder="密　码">
                    <i class="fa fa-lock"></i>
                    <a href="#" class="fa fa-question-circle"></a>
                </div>
                <div class="form-group">
                    <div class="main-checkbox">
                        <input type="checkbox" value="None" id="checkbox1" name="check"/>
                        <label for="checkbox1"></label>
                    </div>
                    <span class="text">记住账号</span>
                    <button type="submit" class="btn btn-default">登录</button>
                </div>
                <%--<div>--%>
                    <%--<a href="register.jsp">立即注册</a>--%>
                <%--</div>--%>
            </form>
        </div>
    </div>
</div>
<div class="blank"></div>

<script>
    window.onload = function ()
    {
        //从Cookie获取到用户名和密码
      var  u_p=getCookieValue("dy_u_p");
      var username = u_p.split(',')[0];
        //如果用户名为空,则给表单元素赋空值
        if ( username == "" )
        {
            document.getElementById("userName").value="" ;
            document.getElementById("password").value="" ;
            document.getElementById("checkbox1").checked=false ;
        }
        //获取对应的密码,并把用户名,密码赋值给表单
        else
        {
            var  password= u_p.split(',')[1];
            document.getElementById("userName").value = username ;
            document.getElementById("password").value = password ;
            document.getElementById("checkbox1").checked = true ;
        }
    }

    function checkCh ()
    {
        //获取表单输入:用户名,密码,是否保存密码
        var username = document.getElementById("userName").value.trim() ;
        var password = document.getElementById("password").value.trim() ;
        var isRmbPwd = document.getElementById("checkbox1").checked ;

        //判断用户名,密码是否为空(全空格也算空)
        if ( username.length != 0 && password.length != 0 )
        {
            //若复选框勾选,则添加Cookie,记录密码
            if ( isRmbPwd == true )
            {
                var expires = new Date();
                expires.setTime(expires.getTime() + 7*3600000);
                document.cookie="dy_u_p"+"="+username+","+password+";"+"expires" +"="+expires.toUTCString();
            }
            //否则清除Cookie
        }
    }

    //获取cookie
    function getCookieValue(name){
        var name = escape(name);
//读cookie属性，这将返回文档的所有cookie
        var allcookies = document.cookie;
//查找名为name的cookie的开始位置
        name += "=";
        var pos = allcookies.indexOf(name);
//如果找到了具有该名字的cookie，那么提取并使用它的值
        if (pos != -1){ //如果pos值为-1则说明搜索"version="失败
            var start = pos + name.length; //cookie值开始的位置
            var end = allcookies.indexOf(";",start); //从cookie值开始的位置起搜索第一个";"的位置,即cookie值结尾的位置
            if (end == -1) end = allcookies.length; //如果end值为-1说明cookie列表里只有一个cookie
            var value = allcookies.substring(start,end); //提取cookie的值
            return unescape(value); //对它解码
        }
    }

</script>
</body>
</html>