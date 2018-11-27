<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>持名法州主页</title>
<link rel="stylesheet" type="text/css" href="../themes/default/easyui.css">   
<link rel="stylesheet" type="text/css" href="../themes/IconExtension.css">   
<script type="text/javascript" src="../js/jquery.min.js"></script>   
<script type="text/javascript" src="../js/jquery.easyui.min.js"></script>  
<script type="text/javascript" src="../js/easyui-lang-zh_CN.js"></script>
<script type="text/javascript">
	<!--菜单处理-->
    $(function(){

        $("#tt").tabs({
            fit:true
        });

        $.ajax({
            //请求地址
            url:"getmenu.action",
            //发送到后台的数据
            //data:"ids="+ids,




            //执行成功的回调函数
            success:function(data){


                for (var i=0;i<data.length;i++) {
                    var str=" ";
                    for (var j = 0; j< data[i].menus.length; j++) {
                        str +="<a style='margin-left: 30px'  onclick='toAddTabsForUserInfo(\""+data[i].menus[j].title+"\")' href='javaScript:void(0)'>"+ data[i].menus[j].title+"</a>"+"<br/>";

                    }

                        $('#aa').accordion('add', {


                            title: data[i].title,
                            content: str,
                            iconCls: data[i].iconcls,
                            selected: false
                        });
                    }

            },
        });

    });

    //添加一个页签；里面的内容是用户信息===》就是那个datagrid.jsp中的内容
    function toAddTabsForUserInfo(da,img){
        //标题是用户信息的页签是否存在
        var isExists = $("#tt").tabs("exists",da);

        if(isExists){
            //存在
            $("#tt").tabs("select",da);
        }else{
            //不存在
            $("#tt").tabs("add",{
                title: da,
                closable:true,
                iconCls:"icon-tip",
                content:'<iframe src="/pages/login.jsp" width="100%" height="100%"></iframe>'
            });
        }


    }
</script>

</head>
<body class="easyui-layout">

    <div data-options="region:'north',split:true" style="height:60px;background-color:  #5C160C">
    	<div style="font-size: 24px;color: #FAF7F7;font-family: 楷体;font-weight: 900;width: 500px;float:left;padding-left: 20px;padding-top: 10px" >持名法州后台管理系统</div>
    	<div style="font-size: 16px;color: #FAF7F7;font-family: 楷体;width: 300px;float:right;padding-top:15px">欢迎您:${sessionScope.admin.name} &nbsp;<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改密码</a>&nbsp;&nbsp;<a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-01'">退出系统</a></div>
    </div>   
    <div data-options="region:'south',split:true" style="height: 40px;background: #5C160C">
    	<div style="text-align: center;font-size:15px; color: #FAF7F7;font-family: 楷体" >&copy;百知教育 htf@zparkhr.com.cn</div>
    </div>   
       
    <div data-options="region:'west',title:'导航菜单',split:true" style="width:220px;">
    	<div id="aa" class="easyui-accordion" data-options="fit:true">
    		<%--手风琴开始--%>

            <%--手风琴结束--%>
		</div>
    </div>   
    <div data-options="region:'center'">
    	<div id="tt" class="easyui-tabs" data-options="fit:true,narrow:true,pill:true">   
		    <div title="主页" data-options="iconCls:'icon-neighbourhood',"  style="background-image:url(image/shouye.jpg);background-repeat: no-repeat;background-size:100% 100%;"></div>
		</div>  
    </div>   
</body> 
</html>