<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<script type="text/javascript" src="<%=request.getContextPath()%>/res/js/jquery-1.12.4.min.js"></script>
<title>Insert title here</title>

</head>

<body >
			
			
		<h1 align="center">${user.userName}欢迎来到学生管理系统</h1>
		
		<div align="left"><a href="<%=request.getContextPath() %>/user/exitLoginUser"><font color="gray">退出</font></a></div>
		
		
</body>
</html>