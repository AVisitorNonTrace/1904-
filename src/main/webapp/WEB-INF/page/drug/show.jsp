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
        $.post("<%=request.getContextPath() %>/drug/list",
            $("#fm").serialize(),
            function(data){
                layer.close(index);
                if (data.code != 200) {
                    layer.msg(data.msg);
                    return;
                }
                totalNum = data.data.totalNum;

                var html = "";
                for (var i = 0; i < data.data.druglist.length; i++) {
                    var u = data.data.druglist[i];
                    html += "<tr>";
                    html += "<td><input type='checkbox' name = 'ids' value = '" + data.data.druglist[i].id + "'/></td>";
                    html += "<td>"+data.data.druglist[i].drugName+"</td>";
                    html += "<td>"+data.data.druglist[i].count+"</td>";
                    html += "<td>"+data.data.druglist[i].price+"</td>";
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

    function del() {
        var chkValue = $('input[name="ids"]:checked');
        if (chkValue.length == 0) {
            layer.msg('请选择');
        } else if (chkValue.length > 1) {
            layer.msg('只能选择一个');
        } else {
            var id = chkValue.val();
            var index = layer.load(0, {shade:0.5});
            $.post("<%=request.getContextPath()%>/user/",
                {"id" : id, "isDel" : 0, "_method" : "delete"},
                function(data){

                    layer.msg(data.msg, function(){
                        if (data.code != 200) {
                            layer.close(index);
                            return;
                        }
                        location.href = "<%=request.getContextPath()%>/user/toShow";
                    });

                })
        }
    }




</script>
</head>
<body>


<form id = "fm">
    <input type="hidden" name="_method" value="get"/>
    <input type="hidden" value="1" id="pageNo" name="pageNo">
        药名:<input type = "text" name = "drugName"/>
        <input type = "hidden" name = "isDel" value = "1"/>
        <input type = "button" value = "搜索"  class="layui-btn layui-btn-normal" onclick = "find()"/><br/>
    <center>
        <div class="layui-btn-group">
                <button type="button" class="layui-btn layui-btn-normal" onclick="add()">新增</button>
                <button type="button" class="layui-btn layui-btn-normal" onclick="del()">删除</button>
        </div>
    </center>
    <table border="1px"  class="layui-table"  cellpadding="10px">
        <tr>
                <td>id</td>
                <td>药名</td>
                <td>库存</td>
                <td>价格</td>
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
