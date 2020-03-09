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
    <link rel="stylesheet" href="<%=request.getContextPath()%>/res/layui-v2.5.5/layui/css/layui.css"  media="all">
<script type="text/javascript">

    var totalNum = 0;

    $(function() {
        search();
    })


    function search() {
        var index = layer.load(0, {shade:0.5});
        $.post("<%=request.getContextPath() %>/register/list",
            {"orderStatus" : 3, "pageNo" : $("#pageNo").val()},
            function(data){
                layer.close(index);
                if (data.code != 200) {
                    layer.msg(data.msg);
                    return;
                }
                totalNum = data.data.totalNum;

                var html = "";
                for (var i = 0; i < data.data.registerList.length; i++) {
                    var u = data.data.registerList[i];
                    html += "<tr>";
                    html += "<td><input type='checkbox' name = 'ids' value = '" + u.id + "'/></td>";
                    html += "<td>"+u.illnessName+"</td>";
                    html += "<td>"+u.remarks+"</td>";
                    html += "<td>"+u.orderStatus+"</td>";
                    html += "<td>"+u.createTime+"</td>";
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
                title: '修改页',
                shadeClose: true,
                shade: 0.8,
                area: ['380px', '90%'],
                content: '<%=request.getContextPath()%>/user/toUpdate/'+id //iframe的url
            });
        }
    }

    function seeDrug() {
        var chkValue = $('input[name="ids"]:checked');
        if (chkValue.length == 0) {
            layer.msg('请选择');
        } else if (chkValue.length > 1) {
            layer.msg('只能选择一个');
        } else {
            var id = chkValue.val();
            layer.open({
                type: 2,
                title: '查看开药信息',
                shadeClose: true,
                shade: 0.8,
                area: ['380px', '90%'],
                content: '<%=request.getContextPath()%>/register/toSeeDrug/'+id //iframe的url
            });

        }
    }




</script>
</head>
<body>


<form id = "fm">
    <br />
    <br />
    <br />
    <input type="hidden" name="_method" value="get"/>
    <input type="hidden" value="1" id="pageNo" name="pageNo">
    <center>
        <div class="layui-btn-group">
                <button type="button" class="layui-btn layui-btn-normal" onclick="seeDrug()">已开药品查看</button>
        </div>
    </center>
    <table border="1px"  class="layui-table"  cellpadding="10px">
        <tr>
                <td>id</td>
                <td>病名</td>
                <td>备注</td>
                <td>预约状态</td>
                <td>预约时间</td>
        </tr>

        <tbody id = "tbd">

        </tbody>

    </table>

</form>
<div id="pageInfo">
    <form align = "center">
        <div id = "page" class="layui-btn-group">

        </div>
    </form>
</div>



</body>
</html>
