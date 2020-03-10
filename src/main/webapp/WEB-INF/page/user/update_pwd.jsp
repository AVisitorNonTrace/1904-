<%--
  User: zjq
  Date: 2020/3/7 17:04
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>/res/js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/res/layer-v3.1.1/layer/layer.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/css/layui.css" media="all">
    <script src="<%=request.getContextPath()%>/res/validate/jquery.validate.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>\res\md5-min.js"></script>
    <script src="https://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>
    <script type="text/javascript">

        function update() {
            var index = layer.load(0, {shade:0.5});
            //MD5(原密码)
            var pwd = md5($("#password").val());
            //获取盐
            var salt = $("#salt").val();
            //MD5(MD5(原密码)+盐)
            var newPwd = md5(pwd + salt);
            $("#password").val(newPwd);
            $.post(
                "<%=request.getContextPath()%>/user/",
                $("#fm").serialize(),
                function(data){

                    layer.msg(data.msg, function(){
                        if (data.code != 200) {
                            layer.close(index);
                            return;
                        }
                        parent.window.location.href = "<%=request.getContextPath()%>/user/toLogin";
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
<form id="fm">
    <input type = "hidden" name = "id" value = "${user.id}"/>
    <input type = "hidden" name = "userName" value = "${user.userName}"/>
    <input type = "hidden" name = "userEmail" value = "${user.userEmail}"/>
    <input type = "hidden" name = "phone" value = "${user.phone}"/>
    <input type = "hidden" name = "status" value = "${user.status}"/>
    <input type = "hidden" name = "sex" value = "${user.sex}"/>
    <input type = "hidden" name = "age" value = "${user.age}"/>
    <input type = "hidden" name = "code" value = "${user.code}"/>
    <input type="hidden" name="salt" value="${salt}" id="salt">
    <%--        密码:<input type = "password" name = "password" id = "password"/><br/>--%>
    <label class="layui-form-label">密码</label>
    <div class="layui-input-inline">
        <input type="password" name="password" id="password"  lay-verify="required" placeholder="请输入密码" autocomplete="off" class="layui-input">
    </div>
    <center>
        <input type = "button" value="重置密码" onclick="update()" class="layui-btn layui-btn-normal" /><br/>
    </center>
</form>
</body>
</html>