<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/4
  Time: 16:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>Title</title>
<script type="text/javascript" src="<%=request.getContextPath()%>\res\js\jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>\res\jsencrypt\jsencrypt.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>\res\layer-v3.1.1\layer\layer.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/css/layui.css"  media="all">
<script type="text/javascript">

</script>
</head>
<body>


<form id = "fm">
    <input type="hidden" name="_method" value="get"/>
    <input type="hidden" value="1" id="pageNo" name="pageNo">
    <table border="1px"  class="layui-table"  cellpadding="10px">
        <tr>
                <td>病名:${register.illnessName}</td>
        </tr>
        <tr>
            <td>开药信息:${register.drugName}</td>
        </tr>

    </table>

</form>
<div id="pageInfo">
    <form align = "center">
        <div id = "page" class="layui-btn-group">

        </div>
    </form>
</div>



</body>
</html>
