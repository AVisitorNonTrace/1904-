<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>\res\js\jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>\res\md5-min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>\res\layer-v3.1.1\layer\layer.js"></script>
    <script src="<%=request.getContextPath()%>\res\validate\jquery.validate.js"></script>
    <script src="https://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>
    <script type="text/javascript">
        //添加预约单
        function add(){
            var index = layer.load(0, {shade:0.5});
            $.post("<%=request.getContextPath()%>/register/add",
                $("#fom").serialize(),
                function(data){
                    layer.msg(data.msg, {icon: 6}, function(){
                        layer.close(index);
                        if (data.code != 200) {
                            return;
                        }
                        parent.window.location.href="<%=request.getContextPath()%>/register/toShow";
                    });
                })
        }

    </script>
    <style>

    </style>
</head>
<body>
    <form id="fom">
<%--        选择医生：<input type="hidden" name="doctorId"/><br/><p/>--%>
        选择医生：
        <select name="doctorId">
            <c:forEach items="${userList}" var="u">
                <option value ="${u.id}">${u.userName}</option>
            </c:forEach>
        </select><br/><p/>
        填写病例：<input type="text" name="illnessName" /><br/><p/>
        添加备注：<input type="text" name="remarks" /><br/><p/>
        <input type="button" value="提交病例预约单"  onclick="add()" />
        <input type="hidden" name="orderStatus" value="1"/><br/><p/>
        <input type="hidden" name="isDel" value="1"/><br/><p/>
    </form>
</body>
</html>