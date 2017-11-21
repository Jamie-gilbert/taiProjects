<html>
<head>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
</head>
<body >
<div style="border-bottom:1px solid cornflowerblue;padding-bottom: 5px" class="department">
    <div class="row department" style="padding-top: 5px">
        <div class="col-xs-3 col-md-4">
            <div class="input-group">
                <span class="input-group-addon">个人编号:</span>
                <input type="text" class="form-control" id="grbh" value="${requestScope.staff.grbh}"/>
            </div>
        </div>
        <div class="col-xs-3 col-md-4">
            <div class="input-group">
                <span class="input-group-addon">姓名:</span>
                <input type="text" class="form-control" id="xm" value="${requestScope.staff.xm}"/>
            </div>
        </div>
    </div>
    <input type="text" value="${requestScope.staff.ryid}" hidden="hidden" id="ryid">
</div>
<script type="text/javascript">
    var xm = "<%=request.getParameter("xm")%>";
</script>

</body>
</html>