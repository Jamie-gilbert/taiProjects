<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/10/18
  Time: 21:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>注册</title>
    <script src="../js/jquery.js"></script>
    <script src="../js/bootstrap.js"></script>

    <link rel="stylesheet" type="text/css" href="../css/bootstrap.css">
</head>
<body>
<form action="/user/register.action" method="post">
    <table>
        <tr>
            <td>用户名：</td>
            <td><input type="text" name="yhxm"></td>
        </tr>
        <tr>
            <td>密码：</td>
            <td><input type="password" name="kl"></td>
        </tr>
        <tr>
            <td>确认密码：</td>
            <td><input type="password" name="kl"></td>
        </tr>
        <tr>
            <td>身份证号码：</td>
            <td><input type="text" name="sfzhm"></td>
        </tr>
        <tr>
            <td>性别：</td>
            <td><input type="text" name="xb"></td>
        </tr>
        <tr>
            <td>联系电话：</td>
            <td><input type="text" name="lxdh"></td>
        </tr>
        <tr>
            <td>经办机构ID：</td>
            <td><input type="text" name="jbjgid"></td>
        </tr>
        <tr>
            <td>经办人：</td>
            <td><input type="text" name="jbr"></td>
        </tr>
        <tr>
            <td>备注：</td>
            <td><input type="text" name="bz"></td>
        </tr>
    </table>
    <table>
        <tr>
            <td><input type="submit" name="submit" value="确定"></td>
            <td><input value="取消" type="button" name="cancle" id="cancle"></td>
        </tr>
    </table>
</form>
</body>
</html>
