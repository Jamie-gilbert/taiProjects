<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>login</title>
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.js"></script>

    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
</head>
<body>
<form action="user/login.action" method="post">
    <table align="left">
        <tr>
            <td>用户:</td>
            <td><input id="userName" type="text" name="username"></td>
        </tr>
        <tr>
            <td>密码：</td>
            <td><input id="password" type="password" name="password"></td>
        </tr>
        <tr>
            <td><button type="submit" name="Submit">登录</button></td>
        </tr>
    </table>
</form>
<a href="register.jsp">立即注册</a>
</body>
</html>