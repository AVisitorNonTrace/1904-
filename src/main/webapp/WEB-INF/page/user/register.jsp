<%--
  Created by IntelliJ IDEA.
  User: dx
  Date: 2020/3/8
  Time: 14:12
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script type="text/javascript" src="<%=request.getContextPath()%>\res\js\jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>\res\jsencrypt\jsencrypt.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>\res\layer-v3.1.1\layer\layer.js"></script>

    <script type="text/javascript" src="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/res/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/res/zTree_v3/js/jquery.ztree.core.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/res/zTree_v3/js/jquery.ztree.excheck.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/res/zTree_v3/js/jquery.ztree.exedit.js"></script>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/css/layui.css"  media="all">
    <script type="text/javascript" src="<%=request.getContextPath()%>/res/My97DatePicker/WdatePicker.js"></script>
    <script type="text/javascript">
        function register() {
            $.post(
                "<%=request.getContextPath()%>/register/add",
                $("#fm").serialize(),
                function(data){
                    layer.msg(data.msg, function(){
                        if (data.code != 200) {
                            layer.close(index);
                            return;
                        }
                       window.location.href = "<%=request.getContextPath()%>/user/toShow";
                    });

                })
        }

    </script>
</head>
<body>
<center>
    <form id = "fm">
<h1>预约挂号</h1>
   病名:<input type="text" name="illnessName"/><br>
    预约医生:<select name="doctorId">
<c:forEach items="${doctorlist}" var="doc">
    <option value="${doc.id}">${doc.userName}</option>
</c:forEach>
    </select><br>
   预约时间:
    <input type="text" name="updateTime" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" class="Wdate" style="width:200px">
    <br></br>备注:<input type="text" name="remarks"/><br>
    <input type = "hidden" name = "userId" value = "${USER.id}"/>
    <input type = "hidden" name = "orderStatus" value = "1"/>
    <input type="button" value="预约" onclick="register()"/>
</form>
</center>
</body>
</html>
