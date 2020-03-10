<%--
  Created by IntelliJ IDEA.
  User: dj
  Date: 2020/3/9
  Time: 13:31
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
                $("#fom").serialize(),
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

    </style>
</head>
<body>
<form id="fom">
    选择药物：
    <select name="drugName">
        <c:forEach items="${drugList}" var="d">
            <option value ="${d.drugName}">${d.drugName}</option>
        </c:forEach>
    </select><br/><p/>
    <input type="button" value="提交药物单"  onclick="update()" />
    <input type="hidden" name="id" value="${register.id}"/><br/><p/>
    <input type="hidden" name="orderStatus" value="3"/><br/><p/>
    <input type="hidden" name="_method" value="put"/>
</form>
</body>
</html>
