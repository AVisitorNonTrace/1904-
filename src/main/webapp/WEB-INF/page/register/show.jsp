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
            $.post("<%=request.getContextPath() %>/register/showRegister",
                $("#fm").serialize(),
                function(data){
                    layer.close(index);
                    if (data.code != 200) {
                        layer.msg(data.msg);
                        return;
                    }
                    totalNum = data.data.totalNum;

                    var html = "";
                    for (var i = 0; i < data.data.registerlist.length; i++) {
                        var u = data.data.registerlist[i];
                        html += "<tr>";
                        html += "<td><input type='checkbox' name = 'ids' value = '" + data.data.registerlist[i].id + "'/></td>";
                        html += "<td>"+data.data.registerlist[i].userId+"</td>";
                        if (data.data.registerlist[i].orderStatus == 1) {
                            html += "<td>预约中</td>";
                        } else if (data.data.registerlist[i].orderStatus == 2){
                            html += "<td>接收预约</td>";
                        } else {
                            html += "<td>拒绝预约</td>";
                        }
                        html += "<td>"+data.data.registerlist[i].doctorId+"</td>";
                        html += "<td>"+data.data.registerlist[i].illnessName+"</td>";
                        html += "<td>"+data.data.registerlist[i].remarks+"</td>";
                        html += "</tr>";
                    }
                    $("#tbd").html(html);
                    var pageNo = $("#pageNo").val();
                    var pageHtml = "<input type='button' class='layui-btn layui-btn-primary layui-btn-radius' value='上一页' onclick='page("+(parseInt(pageNo) - 1)+")'>";
                    pageHtml += "<input type='button' class='layui-btn layui-btn-primary layui-btn-radius' value='下一页' onclick='page("+(parseInt(pageNo) + 1)+")')'>";
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

        function toUpdate() {
            var chkValue = $('input[name="ids"]:checked');
            if (chkValue.length == 0) {
                layer.msg('请选择');
            } else if (chkValue.length > 1) {
                layer.msg('只能选择一个');
            } else {
                var id = chkValue.val();
                layer.open({
                    type: 2,
                    title: '预约处理',
                    shadeClose: true,
                    shade: 0.8,
                    area: ['380px', '90%'],
                    content: '<%=request.getContextPath()%>/register/toUpdate/'+id //iframe的url
                });
            }
        }

        function del() {
            var chkValue = $('input[name="ids"]:checked');
            if (chkValue.length == 0) {
                layer.msg('请选择');
            } else if (chkValue.length > 1) {
                layer.msg('只能选择一个');
            } else {
                var id = chkValue.val();
                var index = layer.load(0, {shade:0.5});
                $.post("<%=request.getContextPath()%>/register/",
                    {"id" : id, "isDel" : 0, "_method" : "delete"},
                    function(data){

                        layer.msg(data.msg, function(){
                            if (data.code != 200) {
                                layer.close(index);
                                return;
                            }
                            location.href = "<%=request.getContextPath()%>/register/toShow";
                        });

                    })
            }
        }

        function add(){
            layer.open({
                type: 2,
                title: '前往预约',
                shadeClose: false,
                shade: 0.8,
                area: ['380px', '90%'],
                content: '<%=request.getContextPath()%>/register/toAdd' //iframe的url
            });
        }

    </script>
</head>
<body>


<form id = "fm" align = "center">
    <br/>
    <br/>
    <input type="hidden" value="1" id="pageNo" name="pageNo">
    <div class="layui-btn-group">
        <c:if test="${USER.type == '3'}">
            <button type="button"  class="layui-btn layui-btn-normal" onclick="add()"/>前往预约</button>
        </c:if>
        <%--           <button type="button"  class="layui-btn layui-btn-normal" onclick="add()"/>前往预约</button>--%>
        <c:if test="${USER.type != '3'}">
        <button type="button" class="layui-btn layui-btn-normal" onclick="del()"/>删除预约</button>
    </div>
    <div class="layui-btn-group">

        <button type="button" class="layui-btn layui-btn-normal" onclick="toUpdate()"/>处理预约</button>

    </div>
    </c:if>
    <table class="layui-table"  cellpadding="10px">
        <tr>
            <td></td>
            <td>预约患者</td>
            <td>预约状态</td>
            <td>预约医生</td>
            <td>病例</td>
            <td>备注</td>
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
