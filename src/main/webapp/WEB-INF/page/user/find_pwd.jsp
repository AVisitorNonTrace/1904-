<%--
  User: zjq
  Date: 2020/3/7 12:44
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
<script src="https://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>

    <script type="text/javascript">

        jQuery.validator.addMethod("phone",
            function(value, element) {
                var tel = /^1[3456789]\d{9}$/;
                return tel.test(value)
            }, "请正确填写您的手机号");

        jQuery.validator.addMethod("email",
            function(value, element) {
                var tel = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z0-9]+$/;
                return tel.test(value)
            }, "请正确填写您的邮箱编号");

        $(function() {
            $("#fm").validate({
                rules:{
                    userName:{
                        required:true
                    },
                    phone:{
                        required:true,
                        digits:true,
                        phone:true
                    },
                    userEmail:{
                        required:true,
                        email:true
                    }
                },
                messages:{
                    userName:{
                        required:"不能为空"
                    },
                    phone:{
                        required:"写手机号",
                        digits:"只能是数字",
                        phone:"请正确填写个格式"
                    },
                    userEmail:{
                        required:"写邮箱啊",
                        email:"请正确填写个格式"
                    }
                }
            })
        })

        $.validator.setDefaults({
            submitHandler: function() {
                $.post("<%=request.getContextPath() %>/user/find",
                    $("#fm").serialize(),
                    function(data){
                        layer.msg(data.data.msg, function(){
                            if (data.data.id != data.data.id) {
                                layer.close(data.data.msg);
                                return;
                            }
                            window.location.href = "<%=request.getContextPath()%>/user/toUpdatePwd/"+data.data.id;
                        });
                    })
            }
        });

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

    </script>
    <style>
        .error{
            color:red;
        }
    </style>
</head>
<body>
<form id="fm">
    用户名:<input type = "text" name = "userName" id = "userName" onblur="getSalt(this)"/><br/>
    手机号:<input type = "text" name = "phone" id = "phone"/><br/>
    邮箱:<input type = "text" name = "userEmail" id = "userEmail"/><br/>
    <input type = "submit" />
</form>
</body>
</html>