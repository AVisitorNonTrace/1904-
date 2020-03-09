<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>\res\js\jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>\res\jsencrypt\jsencrypt.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>\res\layer-v3.1.1\layer\layer.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/layui.js" charset="utf-8"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/res/zTree_v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/res/zTree_v3/js/jquery.ztree.core.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/res/zTree_v3/js/jquery.ztree.excheck.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/res/zTree_v3/js/jquery.ztree.exedit.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/css/layui.css"  media="all">
	<script type="text/javascript">
		$(function() {
			if (${USER.type=='2'}) {
				if (${size != null && size > 0}) {
					layer.confirm("有${size}条预约信息,请去处理!", {icon: 3, title:'提示'}, function(index){
						window.location.href="<%=request.getContextPath()%>/register/toShow";
					})
				}
			}
		})
	</script>
</head>
<body>

		<marquee><h1><span style="color: #00F7DE">健康从这里开始</span></h1></marquee>
	
</body>
</html>