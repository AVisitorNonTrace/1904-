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

        //手机号验证
        function loginPhone(){
            var index = layer.load(0,{shade:0.5});
            $.post("<%=request.getContextPath()%>/user/find",
                $("#fm").serialize(),
                function(data){
                    layer.close(index);
                    if(data.code != 200){
                        layer.msg(data.msg, {icon:5,time:2000});
                        return;
                    }
                    layer.msg(data.msg, {icon:6,time:2000},
                        function(){
                            window.location.href = "<%=request.getContextPath()%>/user/toUpdatePwd/"+data.data.id;
                        });
                });
        }

        var phoneReg = /(^1[1|2|3|4|5|6|7|8|9]\d{9}$)|(^09\d{8}$)/;//手机号正则
        var count = 30; //间隔函数，1秒执行
        var InterValObj1; //timer变量，控制时间
        var curCount1;//当前剩余秒数

        function getCode(){
            curCount1 = count;
            var phone = $.trim($('#phone').val());
            if (!phoneReg.test(phone)) {
                layer.msg(" 手机号码格式不正确",{icon:0,time:2000});
                return false;
            }

            $.post("<%=request.getContextPath()%>/user/send",
                $("#fm").serialize(),
                function(data){
                    if (data.code != 200) {
                        layer.msg(data.msg, {icon:5,time:2000});
                        return;
                    }
                    layer.msg(data.msg,{icon:6});
                });

            //设置button效果，开始计时
            $("#btnSendCode1").attr("disabled", "true");
            $("#btnSendCode1").val( + curCount1 + "秒再获取");
            InterValObj1 = window.setInterval(SetRemainTime1, 1000); //启动计时器，1秒执行一次

        }

        function SetRemainTime1() {
            if (curCount1 == 0) {
                window.clearInterval(InterValObj1);//停止计时器
                $("#btnSendCode1").removeAttr("disabled");//启用按钮
                $("#btnSendCode1").val("重新发送");
            }
            else {
                curCount1--;
                $("#btnSendCode1").val( + curCount1 + "秒再获取");
            }
        }
    </script>
</head>
<body>
<form id="fm">
    <input type="hidden"  value="0" name="userLogins">
    手机号:<input type="text" id="phone" name="phone" autocomplete="off" placeholder="请输入已绑定的手机号"><p>
    验证码:<input type="text" name="code" autocomplete="off" placeholder="短信验证码"><p>
        <input type="button" id="btnSendCode1" value="获取验证码"  onclick="getCode()"><p>
        <input type="button" class="loginPhone" value="修改密码" onclick="loginPhone()"><p>
</form>
</body>
</html>