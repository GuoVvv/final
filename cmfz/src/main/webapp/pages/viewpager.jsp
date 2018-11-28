<%--
  Created by IntelliJ IDEA.
  User: lenovo
  Date: 2018/11/28
  Time: 16:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../themes/IconExtension.css">
    <script type="text/javascript" src="../js/jquery.min.js"></script>
    <script type="text/javascript" src="../js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="../js/datagrid-detailview.js"></script>
    <script type="text/javascript" src="../js/jquery.edatagrid.js"></script>
    <script type="text/javascript">

        var toolbar = [{
            iconCls: 'icon-edit',
            text: "添加",
            handler: function () {
                $("#addProdia").dialog("open");
            }
            }, '-', {
            iconCls: 'icon-help',
            text: "删除",
            handler: function () {
                var a= $("#dg").edatagrid("getSelected");
                alert(a)
                $.ajax({
                    //请求地址
                    url:"delete.action",
                    //发送到后台的数据
                    data:{"id":a.id},
                    //请求方式
                    type:"post",
                    //执行成功的回调函数
                    success:function(data){
                        alert(data)
                        if(data){
                            $.messager.show({
                                title: '成功',
                                msg: '删除成功',
                                showType: 'show',
                                style: {
                                    right: '',
                                    top: document.body.scrollTop + document.documentElement.scrollTop,
                                    bottom: ''
                                }
                            });
                            $("#dg").edatagrid("load");
                        }else{

                            $("#dg").edatagrid("load");
                        }
                    },
                    //告诉jquery后台响应回来的是json串
                    //jquery会把响应回来的json串解析为js对象
                    /* dataType:"json" */
                })
            }
            }, '-', {
            iconCls: 'icon-help',
            text: "修改",
            handler: function () {
                /*获取选中列*/
                var row=$("#dg").edatagrid("getSelected")
                if(row==null){
                    $.messager.show({
                        title: '警告',
                        msg: '请选中修改行。',
                        showType: 'show',
                        style: {
                            right: '',
                            top: document.body.scrollTop + document.documentElement.scrollTop,
                            bottom: ''
                        }
                    });
                }else{
                   /* var a= $("#dg").edatagrid("getSelected");*/
                    /*将当前行变成可编辑模式*/
                    var index = $("#dg").edatagrid("getRowIndex", row);
                    $("#dg").edatagrid("editRow", index);

                }
            }
            }, '-', {
            iconCls: 'icon-help',
            text: "保存",
            handler: function () {
                $("#dg").edatagrid("saveRow");  //自动传

            }



        }];

            $(function(){

                $('#dg').edatagrid({
                    updateUrl:"update",  //修改方法
                    toolbar: toolbar,
                    url:'selectAll.action',
                    pagination:true,
                    columns:[[
                        {field:'id',title:'id'},
                        {field:'title',title:'标题',width:100},
                        {field:'status',title:'状态',width:100,editor:{
                                type:"text",
                                options:{
                                    required:true
                                }
                            }},
                        {field:'date',title:'时间',width: 100,align: 'right'},
                    ]],
                    onLoadSuccess:function(data){
                        if(data.rows[0].sidaluanjian==undefined){
                            $("#dg").datagrid("hideColumn", "id"); // 设置隐藏列
                        }
                    },
                    fit: true,
                    fitColumns: true,
                    pagination: true,
                    pageSize: 5,
                    pageList: [5, 10, 20],
                    view: detailview,
                    detailFormatter: function (rowIndex, rowData) {
                        return '<table><tr>' +
                            '<td rowspan=2 style="border:0"><img src="${pageContext.request.contextPath}/img/'+ rowData.imgpath + '" style="height:90px;"></td>' +
                            '<td style="border:0">' +
                            '<p>时间: ' + rowData.date + '</p>' +
                            '<p>描述:' + rowData.desc + '</p>' +
                            '<p>图片:' + 'img/'+rowData.imgpath + '</p>' +
                            '</td>' +
                            '</tr></table>';
                    }
                });
            });

        //添加确定开始
        function doInput(){
            $("#prof1").form("submit", {
                url:"insert.action",
                /* 	  onSubmit: function(){
                            // do some check
                            // return false to prevent submit;
                        },  */
                success:function(data){
                    //alert(data)
                    if(data=="true"){
                        // alert("添加成功");
                        $.messager.alert("提示框","添加成功","bnm"); //提示框
                        $("#addProdia").dialog("close");
                        $("#dg").datagrid("load");
                    }else{
                        $.messager.alert("提示框","添加失败","bnm"); //提示框
                    }
                }
            });
        }
        //添加确定结束
    </script>
</head>
<body>
<table id="dg"></table>
<div id="addProdia" class="easyui-dialog" data-options="closed:true">
    <form id="prof1" style="margin:30px" enctype="multipart/form-data" method="post">
        <table>
            <tr><td>
                图片名字：<input class="easyui-validatebox"  name="title" data-options="required:true,missingMessage:'请填写图片名字'"/><br/><br/>
                图片展示：<input class="easyui-filebox" name="uploadFile" data-options="required:true,missingMessage:'请选择图片'"/><br/><br/>

            </td></tr>
            <tr><td>
                    图片备注：<input class="easyui-validatebox" name="desc" type="text" data-options="required:true,missingMessage:'请输入图片备注'"/> <br/><br/>
                    图片状态：<input class="easyui-validatebox"  name="status" type="text"  data-options="required:true,missingMessage:'请输入图片状态'"/><br/><br/>
                </td></tr>
        </table>
        <center>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" onClick="doInput()">确认</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
        </center>
    </form>
</div>
</body>
</html>
