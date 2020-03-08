<%--
  User: zjq
  Date: 2020/3/8 14:14
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

    $(function() {
        $("#fm").validate({
            rules:{
                drugName:{
                    required:true,
                    minlength:1,
                    remote: {
                        type: 'POST',
                        url: "<%=request.getContextPath()%>/drug/findByName",
                        data:{
                            userName:function() {
                                return $("#drugName").val();
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
                count:{
                    required:true,
                    digits:true
                },
                price:{
                    required:true,
                    digits:true
                }
            },
            messages:{
                drugName:{
                    required:"不能为空",
                    minlength:"最少一个字",
                    remote:"药品已经增加过了"
                },
                count:{
                    required:"请填写库存",
                    digits:"只能是数字"
                },
                price:{
                    required:"请填写价格",
                    digits:"只能是数字"
                }
            }
        })
    })

    $.validator.setDefaults({
        submitHandler: function() {
            $.post("<%=request.getContextPath() %>/drug/add",
                $("#fm").serialize(),
                function(data){
                    layer.msg(data.msg, function(){
                        if (data.code != 200) {
                            layer.close(index);
                            return;
                        }
                        parent.window.location.href = "<%=request.getContextPath()%>/drug/toShow";
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
    <form id="fm">
        药名:<input type = "text" name = "drugName" id = "drugName"/><br/>
        库存:<input type = "text" name = "count" id = "count"/><br/>
        价格:<input type = "text" name = "price" id = "price"/><br/>
            <input type = "hidden" name = "isDel" value = "1"/><br/>
            <input type = "submit"/><br/>
    </form>
</body>
</html>