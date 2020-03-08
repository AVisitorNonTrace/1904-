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

    function update() {
        $.post(
            "<%=request.getContextPath()%>/drug/",
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

</script>
    <style>
        .error{
            color:red;
        }
    </style>
</head>
<body>
    <form id="fm">
            <input type = "hidden" name = "id" value="${drug.id}"/><br/>
        药名:${drug.drugName}<br/>
        库存:<input type = "text" name = "count" value="${drug.count}"/><br/>
        价格:<input type = "text" name = "price" value="${drug.price}"/><br/>
            <input type = "hidden" name = "isDel" value="${drug.isDel}"/><br/>
            <input type = "button" value="修改" onclick="update()"/><br/>
    </form>
</body>
</html>