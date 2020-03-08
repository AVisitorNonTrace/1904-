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
                        window.location.href = "<%=request.getContextPath()%>/index/toIndex";
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

      if(window.top.document.URL != document.URL){
          //将窗口路径与加载路径同步
          window.top.location = document.URL;
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
    用户名/手机号/邮箱:<input type = "text" name = "userName" id = "userName" onblur="getSalt(this)" ><br/>
    密码:<input type = "password" name = "password" id = "password"/><br/>
    <a href="<%=request.getContextPath()%>/user/toAdd" target="_parent">还没有账户,点击这里,快速注册</a><br/>
    <input type = "button" value="登录" onclick="login()"/>
       <input type = "button" value="手机号快速登录" onclick="loginPhone()"/>
       <input type = "button" value="找回密码" onclick="toFind()"/>
</form>



</body>
</html>