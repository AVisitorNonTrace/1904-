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
<script type="text/javascript" src="<%=request.getContextPath()%>\res\layer-v3.1.1\layer\layer.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>\res\md5-min.js"></script>
<script type="text/javascript">

    function update() {
        var types = $("#types").val();
        //数据库的密码
        var oldPwd = $("#pwd").val();
        //修改的密码
        var password = $("#password").val();
        //盐
        var salt = $("#salt").val();
        if (oldPwd != password) {
            var newPwd =  md5(md5(password) + salt);
            $("#password").val(newPwd);
        }
        var index = layer.load(0, {shade:0.5});
        $.post(
            "<%=request.getContextPath()%>/user/",
            $("#fm").serialize(),
            function(data){

                layer.msg(data.msg, function(){
                    if (data.code != 200) {
                        layer.close(index);
                        return;
                    }
                    if (types == "4"){
                        parent.window.location.href = "<%=request.getContextPath()%>/user/toShow?types="+"4";
                        return;
                    }
                    if (types == "1"){
                        parent.window.location.href = "<%=request.getContextPath()%>/user/toShow?types="+"1";
                        return;
                    }
                    parent.window.location.href = "<%=request.getContextPath()%>/user/toShow";
                });

            })

}

</script>
</head>
<body>

<form id = "fm">
    <input type="hidden" name="_method" value="put"/>
    <input type="hidden" name="types" value="${types}" id="types"/>
    <input type="hidden" name = "id" value="${user.id}"/>
    <input type="hidden" name = "pwd" value="${user.password}" id="pwd"/>
    <input type="hidden" name = "salt" value="${user.salt}" id="salt"/>
    用户名:<input type = "text" name = "userName" value="${user.userName}"/><br/>
    手机:<input type = "text" name = "phone" value="${user.phone}"/><br/>
    邮箱:<input type = "text" name = "userEmail" value="${user.userEmail}"/><br/>
    密码:<input type = "text" name = "password" value="${user.password}" id="password" /><br/>
    性别:<input type = "radio" name = "sex" value="1" <c:if test = "${user.sex == '1'}">checked</c:if>/>男
    <input type = "radio" name = "sex" value="2" <c:if test = "${user.sex == '2'}">checked</c:if>/>女<br/>
    <c:if test="${USER.type != '1'}">
        身份:<input type = "radio" name = "type" value="${user.type}" checked/>${user.typeShow}<br/>
    </c:if>
    <c:if test="${USER.type == '1'}">
    身份:<select name="type">
        <option value="3" <c:if test="${user.type=='3'}">selected</c:if>>患者</option>
        <option value="2" <c:if test="${user.type=='2'}">selected</c:if>>医生</option>
        <option value="1" <c:if test="${user.type=='1'}">selected</c:if>>管理员</option>
    </select><br/>
    </c:if>
    年龄:<input type = "text" name = "age" value="${user.age}"/><br/>
    <input type="button" value="修改" onclick="update()"/>
</form>

</body>
</html>
