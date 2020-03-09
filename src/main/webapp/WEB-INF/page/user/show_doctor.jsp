<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2020/2/4
  Time: 16:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <script type="text/javascript">
        var totalNum = 0;
        $(function() {
            search();
        })
        function search() {
            var index = layer.load(0, {shade:0.5});
            $.post("<%=request.getContextPath() %>/user/doctorShow",
                $("#fm").serialize(),
                function(data){
                    layer.close(index);
                    if (data.code != 200) {
                        layer.msg(data.msg);
                        return;
                    }
                    totalNum = data.data.totalNum;
                    var html = "";
                    for (var i = 0; i < data.data.userList.length; i++) {
                        var u = data.data.userList[i];
                        html += "<tr>";
                        html += "<td><input type='checkbox' name = 'ids' value = '" + data.data.userList[i].id + "'/></td>";
                        html += "<td>"+data.data.userList[i].userName+"</td>";
                        html += data.data.userList[i].sex == "1" ? "<td>男</td>" : "<td>女</td>";
                        html += "<td>"+data.data.userList[i].age+"</td>";
                        html += "<td>"+data.data.userList[i].typeShow+"</td>";
                        html += "<td>"+data.data.userList[i].doctorWork+"</td>";
                        html += "<td>"+data.data.userList[i].createTime+"</td>";
                        html += "</tr>";
                    }
                    $("#tbd").html(html);
                    var pageNo = $("#pageNo").val();
                    var pageHtml = "<button type='button' class='layui-btn layui-btn-primary layui-btn-radius' onclick='page("+(parseInt(pageNo) - 1)+")'>上一页</button>";
                    pageHtml += "<button type='button' class='layui-btn layui-btn-primary layui-btn-radius' onclick='page("+(parseInt(pageNo) + 1)+")')'>下一页</button>";
                    $("#pageInfo").html(pageHtml);
                });
        }
        function page(page) {
            if (page < 1) {
                layer.msg('首页啦!', {icon:0});
                return;
            }
            if (page > totalNum) {
                layer.msg('已经到尾页啦!!', {icon:0});
                return;
            }
            $("#pageNo").val(page);
            search();
        }
        function find(){
            $("#pageNo").val(1);
            search();
        }
        function register() {
            var chkValue = $('input[name="ids"]:checked');
            if (chkValue.length == 0) {
                layer.msg('请选择');
            } else if (chkValue.length > 1) {
                layer.msg('只能选择一个');
            } else {
                var id = chkValue.val();
                layer.open({
                    type: 2,
                    title: '预约用户',
                    shadeClose: false,
                    shade: 0.8,
                    area: ['380px', '90%'],
                    content: '<%=request.getContextPath()%>/user/toRegister?id='+id //iframe的url
                });
            }
        }
    </script>
</head>
<body>


<form id = "fm" align = "center">
    <br/>
    <br/>
    <input type="hidden" name="_method" value="get"/>
    <input type="hidden" value="1" id="pageNo" name="pageNo">
    医生姓名:<input type = "text" name = "userName"/><br/><br/>
    性别:<input type = "radio" name = "sex" value="1"/>男
    <input type = "radio" name = "sex" value="2"/>女<br/><br/>

    <input type = "hidden" name = "isDel" value = "1"/>
    <div class="layui-btn-group">
        <button type = "button" class="layui-btn layui-btn-normal" onclick = "find()"/>搜索</div>
    </div>
    <br><br>
    <div class="layui-btn-group">
        <button type = "button" class="layui-btn layui-btn-normal" onclick = "register()"/>预约</div>
    </div>

    <table class="layui-table"  cellpadding="10px">
        <tr>
            <td></td>
            <td>用户名</td>
            <td>性别</td>
            <td>年龄</td>
            <td>身份</td>
            <td>科室</td>
            <td>注册时间</td>
        </tr>

        <tbody id = "tbd">

        </tbody>

    </table>

</form>
<form align = "center">
    <div id="pageInfo"  class="layui-btn-group">

    </div>
</form>

</body>
</html>