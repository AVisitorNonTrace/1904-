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
    <script type="text/javascript">
        var setting = {
            view: {
                fontCss: getFont,
                nameIsHTML: true
            }
        };

        var zNodes =[
            { name:"患者管理菜单", open:true,
                children: [
                    <c:if test="${USER.type == 3}">
                    { name: "自身信息管理", url : "<%=request.getContextPath()%>/user/toShow", "target" : "right"},
                    { name: "预约医生管理", url : "<%=request.getContextPath()%>/user/toShowDoctor", "target" : "right"},
                    { name: "病史管理", url : "<%=request.getContextPath()%>/order/toShow", "target" : "right"},
                    </c:if>
                ]},
        ];
        var zNodes =[
            { name:"系统管理", isParent:true, font:{'color':'blue', url:"http://www.treejs.cn/", target:"_blank"},
                children: [
                    { name:"医生管理"},
                    { name:"病患管理"},
                    { name:"药品管理"},
                    { name:"疾病管理"},
                ]},
            { name:"预约管理", isParent:true, font:{'color':'blue'}},
            { name:"病史管理", isParent:true, font:{'color':'blue'}},
            { name:"管理员管理", isParent:true, font:{'color':'blue'}}

        ];
        function getFont(treeId, node) {
            return node.font ? node.font : {};
        }
        $(document).ready(function(){
            $.fn.zTree.init($("#ztree"), setting, zNodes);
        });
    </script>
</head>
<body align="center"lay-size="20px">
<div id="ztree" class="ztree" align="center">

</div>
</body>
<script>

</script>
</html>