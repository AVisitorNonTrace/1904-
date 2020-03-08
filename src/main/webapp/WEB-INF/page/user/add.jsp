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
                errorPlacement: function (error, element) {
                    if(element.is("[name='sex']")){//如果需要验证的元素名为userSex
                        error.appendTo($("#sexError"));   //错误信息增加在id为‘radio-lang’中
                    }else {
                        error.insertAfter(element);//其他的就显示在添加框后
                    }
                },
                rules:{
                    userName:{
                        required:true,
                        minlength:2,
                        remote: {
                            type: 'POST',
                            url: "<%=request.getContextPath()%>/user/findByName",
                            data:{
                                userName:function() {
                                    return $("#userName").val();
                                },
                                dataType:"json",
                                dataFilter:function(data,type){
                                    if (data == 'true'){
                                        return true;
                                    }else {
                                        return false;
                                    }
                                }
                            }
                        }
                    },
                    phone:{
                        required:true,
                        digits:true,
                        phone:true,
                        remote: {
                            type: 'POST',
                            url: "<%=request.getContextPath()%>/user/findByPhone",
                            data:{
                                phone:function() {
                                    return $("#phone").val();
                                },
                                dataType:"json",
                                dataFilter:function(data,type){
                                    if (data == 'true'){
                                        return true;
                                    }else {
                                        return false	;
                                    }
                                }
                            }
                        }
                    },
                    userEmail:{
                        required:true,
                        email:true,
                        remote: {
                            type: 'POST',
                            url: "<%=request.getContextPath()%>/user/findByUserEmail",
                            data:{
                                userEmail:function() {
                                    return $("#userEmail").val();
                                },
                                dataType:"json",
                                dataFilter:function(data,type){
                                    if (data == 'true'){
                                        return true;
                                    }else {
                                        return false	;
                                    }
                                }
                            }
                        }
                    },
                    sex:{
                        required:true
                    },
                    password:{
                        required:true
                    },
                    age:{
                        required:true,
                        digits:true
                    }
                },
                messages:{
                    userName:{
                        required:"不能为空",
                        minlength:"最少两个字",
                        remote:"用户名已被注册了"
                    },
                    phone:{
                        required:"写手机号啊",
                        digits:"只能是数字",
                        phone:"请正确填写个格式",
                        remote:"手机号已被注册了"
                    },
                    userEmail:{
                        required:"写邮箱啊",
                        email:"请正确填写个格式",
                        remote:"邮箱已被注册了"
                    },
                    sex:{
                        required:"性别是必选的"
                    },
                    password:{
                        required:"密码不能为空！！"
                    },
                    age:{
                        required:"年龄是必填的",
                        digits:"只能是数字"
                    }
                }
            })
        })

        $.validator.setDefaults({
            submitHandler: function() {
                var index = layer.load(0, {shade:0.5});
                //MD5(原密码)
                var pwd = md5($("#password").val());
                //获取盐
                var salt = $("#salt").val();
                //MD5(MD5(原密码)+盐)
                var newPwd = md5(pwd + salt);
                $("#password").val(newPwd);
                $.post("<%=request.getContextPath() %>/user/add",
                    $("#fm").serialize(),
                    function(data){
                        layer.msg(data.msg, function(){
                            if (data.code != 200) {
                                layer.close(index);
                                return;
                            }
                            window.location.href = "<%=request.getContextPath()%>/user/toLogin";
                        });
                    })
            }
        });
    </script>
    <style>
        .error{
            color:red;
        }
    </style>
</head>
<body>

<form id = "fm">
    <input type="hidden" name="status" value="-1"/>
    <input type="hidden" name="salt" value="${salt}" id="salt">
    用户名:<input type = "text" name = "userName" id = "userName"/><br/>
    手机号:<input type = "text" name = "phone" id = "phone"/><br/>
    邮箱:<input type = "text" name = "userEmail" id = "userEmail"/><br/>
    密码:<input type = "text" name = "password" id = "password"/><br/>

    年龄:<input type = "text" name = "age" id = "age"/><br/>

    性别:<input type = "radio" name = "sex" value="1" checked/>男
        <input type = "radio" name = "sex" value="2"/>女<br/>
    <div id="sexError"></div>
    <select name="type">
        <option value="3">患者</option>
        <option value="2">医生</option>
        <option value="1">管理员</option>
    </select><br/>
    <input type = "submit"/>
    <a href="<%=request.getContextPath()%>/user/toLogin">不注册了,返回登录页面</a>

</form>



</body>
</html>