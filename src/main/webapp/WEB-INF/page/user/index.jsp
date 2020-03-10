<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-ch">
<head>
<meta charset="UTF-8">
	<title>医院挂号系统</title>
	<script type="text/javascript" src="<%=request.getContextPath()%>/res/js/jquery-1.12.4.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/res/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/res/js/ui.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/res/layer-v3.1.1/layer/layer.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/css/layui.css" media="all">
	<script src="<%=request.getContextPath()%>/res/validate/jquery.validate.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>\res\md5-min.js"></script>
	<script src="https://static.runoob.com/assets/jquery-validation-1.14.0/dist/localization/messages_zh.js"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/res/css/layout.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/res/css/base.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/res/css/ui-component.css">
	<script type="text/javascript">

		function toLogin(){
			layer.open({
				type: 2,
				title: '登录',
				shadeClose: false,
				shade: 0.8,
				area: ['380px', '90%'],
				content: '<%=request.getContextPath()%>/user/toLogin' //iframe的url
			});
		}

		function toFind(){
			layer.open({
				type: 2,
				title: '注册',
				shadeClose: false,
				shade: 0.8,
				area: ['380px', '90%'],
				content: '<%=request.getContextPath()%>/user/toAdd' //iframe的url
			});
		}

		if(window.top.document.URL != document.URL){
			//将窗口路径与加载路径同步
			window.top.location = document.URL;
		}

	</script>
</head>
<body>
<div id="top" class="top">
	<div class="wrap">
		<p class="call">010-114/116114电话预约</p>
		<p class="welcome">欢迎来到城市预约挂号统一平台&nbsp;请&nbsp;
		&nbsp;&nbsp;	<a href="#1" onclick="toLogin()" >登录</a>
			<a href="#1" onclick="toFind()" >注册</a>
			<a href="#3">帮助中心</a>
		</p>
	</div>
</div>
<div id="header" class="header">
	<div class="wrap">
		<a href="#4" class="logo"><img src="<%=request.getContextPath()%>/res/img/logo.png"></a>
		<div class="search ui-search">
			<div class="ui-search-selected">医院</div>
			<div class="ui-search-select-list" >
				<a href="#">科室</a>
				<a href="#">疾病</a>
				<a href="#">医院</a>
			</div>
			<input type="text" name="" class="ui-search-input" placeholder="请输入搜索内容" />
			<a href="#" class="ui-search-submit">&nbsp;</a>
		</div>
	</div>
</div>
<div id="nav" class="nav">
	<div class="wrap">
		<div href="#6" class="link menu">全部科室
			<div class="menu-list ui-menu">

				<div class="ui-menu-item clearfix">

					<a href="#1" class="ui-menu-item-department">内科</a>
						<a href="#2" class="ui-menu-item-disease">高血压</a>
						<a href="#3" class="ui-menu-item-disease">冠心病</a>

						<div class="ui-menu-item-detail" >
							<div class="ui-menu-item-detail-group">
								<div class="ui-menu-item-detail-group-caption">内科</div>

								<div class="ui-menu-item-detail-group-list">
									<a href="#1">心血管内科</a>
									<a href="#1">神经内科</a>
									<a href="#1">内分泌科</a>
									<a href="#1">血液科</a>
									<a href="#1">心血管内科</a>
									<a href="#1">神经内科</a>
									<a href="#1">内分泌科</a>
									<a href="#1">血液科</a>
									<a href="#1">心血管内科</a>
									<a href="#1">神经内科</a>
									<a href="#1">内分泌科</a>
									<a href="#1">血液科</a>
									<a href="#1">内分泌科</a>
									<a href="#1">血液科</a>
								</div>

							</div>
						</div>

				</div>


				<div class="ui-menu-item clearfix">

					<a href="#1" class="ui-menu-item-department">外科</a>
						<a href="#2" class="ui-menu-item-disease">肾结石</a>
						<a href="#3" class="ui-menu-item-disease">脑外伤</a>

						<div class="ui-menu-item-detail" >

							<div class="ui-menu-item-detail-group">
								<div class="ui-menu-item-detail-group-caption">外科</div>

								<div class="ui-menu-item-detail-group-list">
									<a href="#1">神经外科</a>
									<a href="#1">功能神经外科</a>
									<a href="#1">内分泌科</a>
									<a href="#1">血液科</a>
									<a href="#1">心血管内科</a>
									<a href="#1">神经内科</a>
									<a href="#1">内分泌科</a>
									<a href="#1">血液科</a>
									<a href="#1">心血管内科</a>
									<a href="#1">神经内科</a>
									<a href="#1">内分泌科</a>
									<a href="#1">血液科</a>
									<a href="#1">内分泌科</a>
									<a href="#1">血液科</a>
								</div>

							</div>
							<div class="ui-menu-item-detail-group">
								<div class="ui-menu-item-detail-group-caption">外科常见疾病</div>

								<div class="ui-menu-item-detail-group-list">
									<a href="#1">神经外科</a>
									<a href="#1">功能神经外科</a>
									<a href="#1">内分泌科</a>
									<a href="#1">血液科</a>
									<a href="#1">心血管内科</a>
									<a href="#1">神经内科</a>
									<a href="#1">内分泌科</a>
									<a href="#1">血液科</a>
									<a href="#1">心血管内科</a>
									<a href="#1">神经内科</a>
									<a href="#1">内分泌科</a>
									<a href="#1">血液科</a>
									<a href="#1">内分泌科</a>
									<a href="#1">血液科</a>
								</div>

							</div>

						</div>

				</div>




			</div>
		</div>
		<a href="hospitals.html" class="link">按医院挂号</a>
		<a href="department.html" class="link">按科室挂号</a>
		<a href="hospitals.html"  class="link">按疾病挂号</a>
		<a href="hospitals.html"  class="link">最新公告</a>
		<a href="hospitals.html" class="link right">社会知名医院</a>
	</div>
</div>
<div id="banner" class="banner clearfix">
	<div class="banner-slider ui-slider">

		<div class="ui-slider-wrap clearfix">
			<a href="" class="item"><img src="<%=request.getContextPath()%>/res/img/banner_1.jpg" alt="banner-1"></a>
			<a href="" class="item"><img src="<%=request.getContextPath()%>/res/img/banner_2.jpg" alt="banner-2"></a>
			<a href="" class="item"><img src="<%=request.getContextPath()%>/res/img/banner_3.jpg" alt="banner-3"></a>
		</div>

		<div class="ui-slider-arrow">
			<a href="#" class="item left">&nbsp;</a>
			<a href="#" class="item right">&nbsp;</a>
		</div>

		<div class="ui-slider-process">
			<a href="#" class="item item_focus">&nbsp;</a>
			<a href="#" class="item ">&nbsp;</a>
			<a href="#" class="item ">&nbsp;</a>
		</div>

	</div>
	<div class="banner-search">
		<div class="caption"> <span class="text"><a href="hospitals.html" class="link">快速预约</a></span> </div>
		<div class="form ui-cascading">
			<div class="line"><select name="area"><option>医院地区</option></select></div>
			<div class="line"><select name="level"><option>医院等级</option></select></div>
			<div class="line"><select name="name"><option>医院名称</option></select></div>
			<div class="line"><select name="department"><option>医院科室</option></select></div>
		</div>
		<div class="submit">
			<input type="button" class="button" value="快速查询" onclick="toLogin()">
		</div>
	</div>
	<div class="banner-help">
		<div class="caption"> <span class="text">帮助中心</span> </div>
		<div class="list">
			<a href="#7" class="link">账号指南</a>
			<a href="#7" class="link">预约指南</a>
			<a href="#7" class="link">账号找回</a>
			<a href="#7" class="link">常见问题</a>
		</div>
	</div>
</div>
<div id="content" class="content">
	<div class="wrap clearfix">

		<div class="content-tab">

			<div class="caption clearfix">
				<a href="#7" class="item item_focus">医院</a>
				<a href="#7" class="item">科室</a>
			</div>

			<div class="block">
				<div class="item">

					<div class="block-caption">
						<a href="#8" class="block-capiton-item block-capiton-item_focus">全部</a>
						<a href="#8" class="block-capiton-item">全部东城区</a>
						<a href="#8" class="block-capiton-item">西城区</a>
						<a href="#8" class="block-capiton-item">朝阳区</a>
						<a href="#8" class="block-capiton-item">丰台区</a>
						<a href="#8" class="block-capiton-item">石景山区</a>
						<a href="#8" class="block-capiton-item">海淀区</a>
						<a href="#8" class="block-capiton-item">门头沟区</a>
						<a href="#8" class="block-capiton-item">房山区</a>
						<a href="#8" class="block-capiton-item">其他</a>
					</div>

					<div class="block-wrap"><!--新增的-->

						<div class="block-content">

							<div class="block-list clearfix">

								<div class="item">
									<img src="<%=request.getContextPath()%>/res/img/hospital-1.jpg" alt="xx医院">
									<div class="item-name">北京协和医院<span class="item-level">【三级甲等】</span></div>
									<div class="item-phone">电话：东院咨询台:010-69155564..</div>
									<div class="item-address">电话： [东院]北京市东城区帅府园一号 [西院]北京市西城区大木仓...</div>
								</div>
								<div class="item">
									<img src="<%=request.getContextPath()%>/res/img/hospital-1.jpg" alt="xx医院">
									<div class="item-name">北京协和医院<span class="item-level">【三级甲等】</span></div>
									<div class="item-phone">电话：东院咨询台:010-69155564..</div>
									<div class="item-address">电话： [东院]北京市东城区帅府园一号 [西院]北京市西城区大木仓...</div>
								</div>

								<div class="item">
									<img src="<%=request.getContextPath()%>/res/img/hospital-1.jpg" alt="xx医院">
									<div class="item-name">北京协和医院<span class="item-level">【三级甲等】</span></div>
									<div class="item-phone">电话：东院咨询台:010-69155564..</div>
									<div class="item-address">电话： [东院]北京市东城区帅府园一号 [西院]北京市西城区大木仓...</div>
								</div>

								<div class="item">
									<img src="<%=request.getContextPath()%>/res/img/hospital-1.jpg" alt="xx医院">
									<div class="item-name">北京协和医院<span class="item-level">【三级甲等】</span></div>
									<div class="item-phone">电话：东院咨询台:010-69155564..</div>
									<div class="item-address">电话： [东院]北京市东城区帅府园一号 [西院]北京市西城区大木仓...</div>
								</div>

							</div>

							<div class="block-text-list clearfix">
								<a href="#9" class="item">首都儿科研究所附属儿童医院 <span class="level">【三级甲等】</span></a>
								<a href="#9" class="item">中国中医科学院望京医院 <span class="level">【三级合格】</span></a>
								<a href="#9" class="item">首都儿科研究所附属儿童医院 <span class="level">【三级甲等】</span></a>
								<a href="#9" class="item">中国中医科学院望京医院 <span class="level">【三级合格】</span></a>
								<a href="#9" class="item">首都儿科研究所附属儿童医院 <span class="level">【三级甲等】</span></a>
								<a href="#9" class="item">中国中医科学院望京医院 <span class="level">【三级合格】</span></a>
							</div>

							<a href="#" class="block-more">更多医院</a>
						</div>
					</div>
					<div class="block-wrap" style="display: none;"><!--新增的-->
						其他城区内容
					</div>

				</div>
				<div class="item" style="display: none;">
					科室内容
				</div>
			</div>

		</div>
		<div class="content-news">
			<div class="caption"> 最新公告 <a href="#8" class="more">|更多</a> </div>
			<div class="list">
				<a href="#8" class="link">阜外医院特需门诊暂停更新号源通...</a>
				<a href="#8" class="link">防护策略升级通知</a>
				<a href="#8" class="link">阜外医院特需门诊暂停更新号源通...</a>
				<a href="#8" class="link">防护策略升级通知</a>
				<a href="#8" class="link">阜外医院特需门诊暂停更新号源通...</a>
				<a href="#8" class="link">防护策略升级通知</a>
			</div>
		</div>
		<div class="content-close">
			<div class="caption"> 停诊公告 <a href="#8" class="more">|更多</a> </div>
			<div class="list">
				<a href="#8" class="link">首都医科大学附属北京安贞医院消...</a>
				<a href="#8" class="link">首都医科大学附属北京安贞医院妇</a>
				<a href="#8" class="link">北京安贞医院妇</a>
				<a href="#8" class="link">首都医科大学附属北京安贞医院消...</a>
				<a href="#8" class="link">首都医科大学附属北京安贞医院妇</a>
				<a href="#8" class="link">北京安贞医院妇</a>
			</div>
		</div>

	</div>
</div>
<div id="footer" class="footer">
	<div class="wrap">
		Copyright&nbsp;&copy;&nbsp;2017慕课网版权所有
	</div>
</div>
<a href="#0" class="go-top"></a>
</body>
</html>