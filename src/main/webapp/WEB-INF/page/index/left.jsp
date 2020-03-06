<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/res/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="<%=request.getContextPath()%>/res/js/jquery-1.12.4.min.js"></script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/res/zTree_v3/js/jquery.ztree.all.min.js"></script>

        <style type="text/css">

                              .goto {

                                  display: block;
                                  width: 120px;
                                  height: 26px;
                                  border: 1px solid #CCC;
                                  background: #9c9d9e;
                                  margin-top: 20px;

                              }
        .goto a {

            font-size: 17px;
            padding: 2px 6px;
            display: block;
            color: #ffffff;
            text-decoration:none;
        }
    </style>
</head>
<body align="center"lay-size="20px">
    <center>
        <c:if test="${user.status==2}">
        <div class="goto"><a href="<%=request.getContextPath()%>/user/toShow" target="right">学生信息</a></div><br><br>
            <div class="goto"><a href="<%=request.getContextPath()%>/sub/toShow" target="right">选修课程管理</a></div><br><br>
        </c:if>
            <c:if test="${user.status==3}">
        <div class="goto"><a href="<%=request.getContextPath()%>/user/toShow" target="right">班主任信息</a></div><br><br>
    </c:if>
        <c:if test="${user.status==1}">
            <div class="goto"><a href="<%=request.getContextPath()%>/user/toStudentShow" target="right">个人信息</a></div><br><br>
            <div class="goto"><a href="<%=request.getContextPath()%>/user/toAddImg" target="right">上传照片</a></div><br><br>
            <div class="goto"><a href="<%=request.getContextPath()%>/sub/toShow" target="right">选修课程</a></div><br><br>
            <div class="goto"><a href="<%=request.getContextPath()%>/user/toStudentShow" target="right">身份证信息上传</a></div><br><br>
        </c:if>

    </center>
</body>
<script>

</script>
</html>