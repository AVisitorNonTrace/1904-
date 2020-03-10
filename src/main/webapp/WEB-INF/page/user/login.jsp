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
    <script type="text/javascript" src="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/css/layui.css"  media="all">
    <script type="text/javascript">

        $(function() {
            $("#fm").validate({
                rules:{
                    userName:{
                        required:true
                    },
                    password:{
                        required:true
                    }
                },
                messages:{
                    userName:{
                        required:"用户名不能为空"
                    },
                    password:{
                        required:"密码不能为空"
                    }
                }
            })
        })

        function login(){
            //md5(原密码)
            var pwd = md5($("#password").val());
            //盐
            var salt = $("#salt").val();
            //md5(md5(原密码) + 盐)
            var newPwd = md5(pwd + salt);
            $("#password").val(newPwd);
            $.post(
                "<%=request.getContextPath()%>/user/login",
                $("#fm").serialize(),
                function(data){
                    layer.msg(data.msg, function(){
                        if (data.code != 200) {
                            return;
                        }
                        parent.window.location.href = "<%=request.getContextPath()%>/index/toIndex";
                    });
            })

        }

        function getSalt(obj){
            $.post(
                "<%=request.getContextPath()%>/user/getSalt",
                {"userName": obj.value},
                function(data){
                    if (data.code != 200) {
                        layer.alert(data.msg, {icon: 5});
                        return;
                    }
                    $("#salt").val(data.data);
            })
        }

        function loginPhone(){
            window.location.href="<%=request.getContextPath()%>/user/toLoginPhone";
        }

        function toFind(){
            layer.open({
                type: 2,
                title: '找回密码页面',
                shadeClose: false,
                shade: 0.8,
                area: ['380px', '90%'],
                content: '<%=request.getContextPath()%>/user/toFind' //iframe的url
            });
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
   <%-- <input type="hidden" name="_method" value="post"/>    --%>
    <input type="hidden" name="salt" id="salt">
       <label class="layui-form-label">用户名</label>
       <div class="layui-input-inline">
           <input type="text" name="userName" id="userName"  lay-verify="required" placeholder="请输入用戶名/邮箱号/手机号" onblur="getSalt(this)" class="layui-input">
       </div>
       <label class="layui-form-label">密码框</label>
       <div class="layui-input-inline">
           <input type="password" name="password" id="password"  lay-verify="required" placeholder="请输入密码"  class="layui-input">
       </div><br>
       <input type = "button" value="登录" onclick="login()" class="layui-btn layui-btn-normal"/>
       <input type = "button" value="手机号快速登录" onclick="loginPhone()"class="layui-btn layui-btn-normal"/>
       <input type = "button" value="找回密码" onclick="toFind()"class="layui-btn layui-btn-normal"/>
</form>



</body>
</html>