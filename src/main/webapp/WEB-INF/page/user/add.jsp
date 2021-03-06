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
    <script type="text/javascript" src="<%=request.getContextPath()%>/res/layer-v3.1.1/layer/layer.js" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/css/layui.css"  media="all">
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
                var types = $("#types").val();
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
                            if (${USER.type != '1'}){
                                window.location.href = "<%=request.getContextPath()%>/user/toShow";
                            }
                            if (types == "4"){
                                parent.window.location.href = "<%=request.getContextPath()%>/user/toShow?types="+"4";
                                return;
                            }
                            if (types == "1"){
                                parent.window.location.href = "<%=request.getContextPath()%>/user/toShow?types="+"1";
                                return;
                            }
                            window.location.href = "<%=request.getContextPath()%>/user/toLogin";
                        });
                    })
            }
        });

        function isShow(isShow) {
            if (isShow.value != '2') {
                $("#Event").hide();
            }else{
                $("#Event").show();
            }
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
    <input type="hidden" name="status" value="-1"/>
    <input type="hidden" name="salt" value="${salt}" id="salt">
    <input type="hidden" name="types" value="${types}" id="types"/>
    用户:
    <div class="layui-input-inline">
        <input type="text" name="userName" id="userName"  lay-verify="required" placeholder="请输入用戶名" class="layui-input">
    </div><br>
    <%--    用户名:<input type = "text" name = "userName" id = "userName"/><br/>--%>
    手机:
    <div class="layui-input-inline">
        <input type="text" name="phone" id="phone"  lay-verify="required" placeholder="请输入手机号" class="layui-input">
    </div><br>
    <%--    手机号:<input type = "text" name = "phone" id = "phone"/><br/>--%>
    邮箱:
    <div class="layui-input-inline">
        <input type="text" name="userEmail" id="userEmail"  lay-verify="required" placeholder="请输入邮箱" class="layui-input">
    </div><br>
    <%--    邮箱:<input type = "text" name = "userEmail" id = "userEmail"/><br/>--%>
    密码:
    <div class="layui-input-inline">
        <input type="text" name="password" id="password"  lay-verify="required" placeholder="请输入密码" class="layui-input">
    </div><br>
    <%--    密码:<input type = "text" name = "password" id = "password"/><br/>--%>
    年龄:
    <div class="layui-input-inline">
        <input type="text" name="age" id="age"  lay-verify="required" placeholder="请输入年龄" class="layui-input">
    </div><br>
    <%--    年龄:<input type = "text" name = "age" id = "age"/><br/>--%>
    <%--    性别:<input type = "radio" name = "sex" value="1" checked/>男--%>
    <%--        <input type = "radio" name = "sex" value="2"/>女<br/>--%>
    <div class="layui-form-item">
        性别:
            男<input  type = "radio" title="男" name = "sex" value = "1" checked/>
            女<input  type = "radio" title="女" name = "sex" value = "2" />
    </div><br>
    <div id="sexError"></div>
<%--    身份:<c:if test="${types != '1'}">
          <input type = "radio" name = "type" value="3"/>患者<br/>
            <input type = "radio" name = "type" value="2" checked/>医生<br/>
        </c:if>
    <c:if test="${USER.type == '1' &&  types == '1'}">
        <input type = "radio" name = "type" value="1" />管理员<br/>
    </c:if>--%>
    身份:<select name="type" onclick="isShow(this)">
            <c:if test="${types != '1'}">
                <option value="3" >患者</option>
                <option value="2" selected>医生</option>
            </c:if>
            <c:if test="${USER.type == '1' &&  types == '1'}">
                <option value="1">管理员</option>
            </c:if>
        </select>
    <c:if test="${types != '1'}">
    <div id="Event"><br>
        科室:<select name="doctorWork">
                 <option value="内科">内科</option>
                <option value="外科">外科</option>
                <option value="妇科">妇科</option>
                <option value="儿科">儿科</option>
                 <option value="中医科">中医科</option>
             </select><br><br>
    </div>
    </c:if>
    <br/>
    <input type = "submit" class="layui-btn layui-btn-normal"/>
    <c:if test="${USER.type != '1'}">
     <a href="<%=request.getContextPath()%>/user/toLogin">不注册了,返回登录页面</a>
    </c:if>

</form>



</body>
</html>