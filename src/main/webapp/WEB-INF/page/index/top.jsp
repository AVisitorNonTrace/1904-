<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/res/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript">
		function quit() {
			window.location.href = "<%=request.getContextPath()%>/user/quit";
		}
	</script>
<title>Insert title here</title>

</head>

<body >

<h1 align="center">欢迎<c:if test="${USER.type==1}"><font color="red">管理员</font></c:if><c:if test="${USER.type==2}"><font color="red">医生</font></c:if><c:if test="${USER.type==3}"><font color="red">用户</font></c:if>${USER.userName}来到点金挂号系统</h1>
		<input type = "button" value = "退出" onclick="quit()"/><br>
		<div id="datetime" align="right" style="color:black">
			<script>
				setInterval("document.getElementById('datetime').innerHTML=new Date().toLocaleString();", 1000);
			</script>
		</div>
		
</body>
</html>