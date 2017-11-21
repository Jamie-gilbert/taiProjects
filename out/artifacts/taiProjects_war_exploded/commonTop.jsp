<html>
<head>
    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
</head>
<body >
<div style="border-bottom:1px solid cornflowerblue;padding-bottom: 5px" class="department">
    <div class="row department" style="padding-top: 5px">
        <div class="col-xs-3 col-md-4">
            <div class="input-group">
                <span class="input-group-addon">单位编号:</span>
                <input type="text" class="form-control" id="dwbh" value="${requestScope.department.dwbh}"/>
            </div>
        </div>
        <div class="col-xs-3 col-md-4">
            <div class="input-group">
                <span class="input-group-addon">单位名称:</span>
                <input type="text" class="form-control" id="dwmc" value="${requestScope.department.dwmc}"/>
            </div>
        </div>
    </div>
    <input type="text" value="${requestScope.department.dwid}" hidden="hidden" id="dwid">
</div>
<script type="text/javascript">
    var dwid =<%=request.getParameter("dwid")%>;
    var dwbh = <%=request.getParameter("dwbh")%>;
    var dwmc = "<%=request.getParameter("dwmc")%>";
</script>

</body>
</html>