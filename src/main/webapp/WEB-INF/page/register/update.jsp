<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/4
  Time: 18:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>Title</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>\res\js\jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>\res\md5-min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>\res\layer-v3.1.1\layer\layer.js"></script>
    <script src="<%=request.getContextPath()%>\res\validate\jquery.validate.js"></script>
    <script src="https://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>
    <script type="text/javascript">

    function update() {
        $.post(
            "<%=request.getContextPath()%>/register/",
            $("#fm").serialize(),
            function(data){
                layer.msg(data.msg, function(){
                    if (data.code != 200) {
                        layer.close(index);
                        return;
                    }
                    parent.window.location.href = "<%=request.getContextPath()%>/register/toShow";
                });

            })

    }
</script>
    <style>
        .error{
            color:red;
        }
    </style>
</head>
<body>

<form id = "fm">
    请选择:<select name="orderStatus">
    <option value="1" <c:if test="${register.orderStatus=='1'}">selected</c:if>>稍后处理</option>
    <option value="2" <c:if test="${register.orderStatus=='2'}">selected</c:if>>接收预约</option>
    <option value="3" <c:if test="${register.orderStatus=='3'}">selected</c:if>>拒绝预约</option>
    </select><br/>
        <input type="button" value="提交结果"  onclick="update()" />
    <input type = "hidden" name = "id" value="${register.id}"/><br/>
    <input type="hidden" name="_method" value="put"/>
</form>

</body>
</html>
