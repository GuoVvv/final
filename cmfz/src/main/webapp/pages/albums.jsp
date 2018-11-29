<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/11/29
  Time: 11:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/themes/IconExtension.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/datagrid-detailview.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.edatagrid.js"></script>

    <script type="text/javascript">

        var toolbar = [{
            iconCls: 'icon-edit',
            text: "专辑详情",
            handler: function () {

                var row = $("#tree").treegrid("getSelected")
                if (row == null) {
                    $.messager.show({
                        title: '警告',
                        msg: '请先选中要查看的专辑。',
                        showType: 'show',
                        style: {
                            right: '',
                            top: document.body.scrollTop + document.documentElement.scrollTop,
                            bottom: ''
                        }
                    });
                } else {
                    if (row.score != null) {
                        $("#albuml").dialog("open")
                        $("#title").html(row.title);
                        $("#auctor").html(row.auctor);
                        $("#gg").html(row.broadcast);
                        $("#ii").prop("src","${pageContext.request.contextPath}/"+row.coverimg);
                        //alert(row.id)
                    } else {
                        alert("请先选中专辑")
                    }
                }
            }
        }, '-',{
            iconCls: 'icon-add',
            text: "添加专辑",
            handler: function () {
                $("#addAlbum").dialog("open")
            }
        }, '-',{
            iconCls: 'icon-add',
            text: "添加章节",
            handler: function () {
                var row = $("#tree").treegrid("getSelected")
                if (row == null) {
                    $.messager.show({
                        title: '警告',
                        msg: '请先选中要添加的专辑。',
                        showType: 'show',
                        style: {
                            right: '',
                            top: document.body.scrollTop + document.documentElement.scrollTop,
                            bottom: ''
                        }
                    });
                } else {
                    if (row.score != null) {
                        $("#addChapter").dialog("open")
                        $("#pid").val(row.id);

                        //alert(row.id)
                    } else {
                        alert("请先选中专辑")
                    }
                }
            }

        }, '-',
            {
                iconCls: 'icon-add',
                text: "下载音频",

                handler: function () {
                    var inp = $("#tree").treegrid("getSelected")
                    /*if(inp==null){
                        alert("请选中章节")
                    }else{
                        if(inp.duration!=null){*/

                            location="${pageContext.request.contextPath}/pages/download?url=/music/51aca196-be22-43f8-93c8-fa5a431cb54e.mp3"+"&title=fffff";
                        /*}else{
                            alert("选错了")
                        }
                    }*/
                }
            },
            ];

        $(function () {
            $("#tree").treegrid({
                onDblClickRow: function (data) {
                    $("#audio").dialog("open")
                    $("#audio_id").prop("src", "${pageContext.request.contextPath}/music/51aca196-be22-43f8-93c8-fa5a431cb54e.mp3")
                },
                url: 'selectAblum',
                idField: 'id',
                treeField: 'title',
                method:"GET",
                fit:true,
                fitColumns: true,
                pageSize: 5,
                pageList: [5, 10, 15, 20, 25],
                pagination: true,
                toolbar: toolbar,
                columns: [[

                    {field: 'title', title: '标题', width: 100},
                    {field: 'size', title: '大小', width: 100},
                    {field: 'duration', title: '描述', width: 100},
                    {field: 'downpath', title: '下载路径', width: 100},
                    {field: 'uploadDate', title: '上传时间', width: 100}
                ]],


            });
        })

        //添加确定开始
        function InChapt(){
            $("#chapter").form("submit", {
                url:"insertChapter",
                /* 	  onSubmit: function(){
                            // do some check
                            // return false to prevent submit;
                        },  */
                success:function(data){
                    //alert(data)
                    if(data=="true"){
                        // alert("添加成功");
                        $.messager.alert("提示框","添加成功","bnm"); //提示框
                        $("#addChapter").dialog("close");
                        $("#tree").treegrid("load");
                    }else{
                        $.messager.alert("提示框","添加失败","bnm"); //提示框
                    }
                }
            });
        }

        //添加确定开始
        function InAlb(){
            $("#album").form("submit", {
                url:"insertAblum",
                /* 	  onSubmit: function(){
                            // do some check
                            // return false to prevent submit;
                        },  */
                success:function(data){
                    //alert(data)
                    if(data=="true"){
                        // alert("添加成功");
                        $.messager.alert("提示框","添加成功","bnm"); //提示框
                        $("#addAlbum").dialog("close");
                        $("#tree").treegrid("load");
                    }else{
                        $.messager.alert("提示框","添加失败","bnm"); //提示框
                    }
                }
            });
        }
    </script>
</head>
<body>
<table id="tree"></table>
<div id="addChapter" class="easyui-dialog" data-options="closed:true">
    <form id="chapter" style="margin:30px" enctype="multipart/form-data" method="post">
        <table>
            <tr><td>
                <input type="hidden" id="pid" name="pid" value="">
                章节名字：<input class="easyui-validatebox"  name="title" data-options="required:true,missingMessage:'请填写章节名字'"/><br/><br/>
                章节内容：<input class="easyui-filebox" name="music" data-options="required:true,missingMessage:'章节内容'"/><br/><br/>

            </td></tr>
        </table>
        <center>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" onClick="InChapt()">确认</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
        </center>
    </form>
</div>
<div id="addAlbum" class="easyui-dialog" data-options="closed:true">
    <form id="album" style="margin:30px" enctype="multipart/form-data" method="post">
        <table>
            <tr><td>

                专辑名字：<input class="easyui-validatebox"  name="title" data-options="required:true,missingMessage:'请填写专辑名字'"/><br/><br/>
                专辑封面：<input class="easyui-filebox" name="img" data-options="required:true,missingMessage:'专辑封面'"/><br/><br/>

            </td></tr>
            <tr><td>

                专辑作者：<input class="easyui-validatebox"  name="auctor" data-options="required:true,missingMessage:'请填写专辑作者'"/><br/><br/>
                专辑朗诵：<input class="easyui-validatebox" name="broadcast" data-options="required:true,missingMessage:'专辑朗诵者'"/><br/><br/>

            </td></tr>
            <tr><td>

                专辑简介：<input class="easyui-validatebox" type="text"  name="brief" data-options="required:true,missingMessage:'请填写专辑简介'"/><br/><br/>


            </td></tr>
        </table>
        <center>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" onClick="InAlb()">确认</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
        </center>
    </form>
</div>
<div id="albuml" class="easyui-dialog" data-options="closed:true">
    <form id="albumll" style="margin:30px"  method="post">
        <table>
            <tr><td>

                专辑标题：<p id="title"></p><br/>
                专辑作者：<p id="auctor"></p><br/>
                专辑歌手：<p id="gg"></p><br/>
                专辑封面：<img id="ii" src=""><br/><br/>

            </td></tr>
        </table>
    </form>
</div>
<div id="audio" class="easyui-dialog" data-options="closed:true">
    <audio id="audio_id" src="" autoplay="autoplay" controls="controls" loop="loop"></audio>
</div>
</body>
</html>
