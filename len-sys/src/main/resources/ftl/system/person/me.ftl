<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>个人信息</title>
    <link rel="stylesheet" href="/plugin/layui/css/layui.css">
    <script type="text/javascript" src="/plugin/jquery/jquery-3.2.1.min.js"></script>
    <script type="text/javascript" src="/plugin/layui/layui.all.js" charset="utf-8"></script>
    <script type="text/javascript" src="${re.contextPath}/plugin/common.js" charset="utf-8"></script>
    <script type="text/javascript" src="/plugin/tools/tool.js"></script>
    <script type="text/javascript" src="/plugin/tools/update-setting.js"></script>
</head>
<body>
<form class="layui-form layui-form-pane" style="margin-left: 20px;">
    <div class="layui-form-item">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
            <legend style="font-size:16px;">头像上传</legend>
        </fieldset>
        <div class="layui-input-inline">
            <div class="layui-upload-drag" style="margin-left:10%;" id="test10">
                <i style="font-size:30px;" class="layui-icon"></i>
                <p style="font-size: 10px">点击上传，或将文件拖拽到此处</p>
            </div>
        </div>
        <div class="layui-input-inline">

            <div  id="demo2" style="margin-top: 20px;margin-left: 50px">
                <img src="/images/${re.contextPath}/${user.photo}" width="100px" height="100px" class="layui-upload-img layui-circle">
            </div>

        </div>
    </div>
    <div class="layui-form-item">
        <fieldset class="layui-elem-field layui-field-title" style="margin-top: 10px;">
            <legend style="font-size:16px;">基础信息</legend>
        </fieldset>
    </div>
    <div class="layui-form-item">
        <label for="uname" class="layui-form-label">
            <span class="x-red">*</span>用户名
        </label>
        <div class="layui-input-inline">
            <input value="${user.id}" type="hidden" name="id" id="userId">
            <input type="text"  id="uname" value="${user.username}" readonly
                   autocomplete="off" class="layui-input">
        </div>
        <div id="ms" class="layui-form-mid layui-word-aux">
            <span class="x-red">*</span><span id="ums">将会成为您唯一的登入名</span>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-inline">
            <label for="realName" class="layui-form-label">
                <span class="x-red">*</span>真实姓名
            </label>
            <div class="layui-input-inline">
                <input type="text" id="realName" value="${user.realName}" name="realName" lay-verify="realName"  autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-inline">
            <label for="age" class="layui-form-label">
                <span class="x-red">*</span>年龄
            </label>
            <div class="layui-input-inline">
                <input type="text" id="age" name="age" value="${user.age}" lay-verify="number"
                       autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-inline">
            <label for="email" class="layui-form-label">
                <span class="x-red"></span>邮箱
            </label>
            <div class="layui-input-inline">
                <input type="email" id="email" value="${user.email}"  name="email"  lay-verify="email"
                       autocomplete="off" class="layui-input">
                <input id="photo" value="${user.photo}" name="photo" type="hidden">
            </div>
        </div>
        <div class="layui-inline">
            <label for="L_repass" class="layui-form-label">
                <span class="x-red">*</span>手机号码
            </label>
            <div class="layui-input-inline">
                <input type="phone" id="phone" name="phone" value="${user.phone}" lay-verify="phone" autocomplete="off"
                       class="layui-input">
            </div>
        </div>
    </div>

    <a  class="layui-btn layui-btn-normal" lay-filter="*"  lay-submit>
        更新
    </a>

    <a  class="layui-btn layui-btn-normal" onclick="changePwd()" >修改密码 </a>
</form>
</body>
<script>
    $(function () {
        //所有的带有readyonly的添加背景颜色
        readyOnlyInputById("uname");

    });
    function changePwd(){
        rePwd('修改密码','user/goRePass?id=' + $("#userId").val(),500,350);
    }

    layui.use(['form','layer','upload'], function(){
        $ = layui.jquery;
        var form = layui.form
                ,layer = layui.layer,
                upload = layui.upload;
        upload.render({
            elem: '#test10'
            ,url: '/user/upload'
            ,before: function(obj){
                //预读，不支持ie8
                obj.preview(function(index, file, result){
                    $('#demo2').find('img').remove();
                    $('#demo2').append('<img src="'+ result +'" alt="'+ file.name +'" width="100px" height="100px" class="layui-upload-img layui-circle">');
                });
            },done: function(res){
                if(!res.flag){
                    layer.msg(res.msg,{icon: 5,anim: 6});
                }else{
                    $("#photo").val(res.msg);
                }
            }
        });

        //自定义验证规则
        form.verify({
            email:function(value){
                if(value!=""){
                    if(!/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/.test(value)){
                        return "邮箱格式不正确";
                    }
                }
            }
            ,phone:function (value) {
                if(value.trim()==""){
                    return "电话号码不能为空";
                }
                if(!/^1\d{10}$/.test(value)){
                    return "电话号码格式不正确";
                }
            }
        });

        //监听提交
        form.on('submit(*)', function(data){
            $.ajax({
                url:'/person/updateUser',
                type:'post',
                data:data.field,
                traditional: true,
                success:function(d){
                    if(d.flag){
                        window.top.layer.msg(d.msg,{icon:6,offset: 'rb',area:['200px','80px'],anim:2});
                    }else{
                        layer.msg(d.msg,{icon:5});
                    }
                },error:function(e){
                    layer.msg('发生错误',{icon:6});
                }
            });
            return false;
        });
    });

    function rePwd(title,url,w,h){
        if (title == null || title == '') {
            title = false;
        };
        if (url == null || url == '') {
            url = "404.html";
        };
        if (w == null || w == '') {
            w = ($(window).width() * 0.9);
        };
        if (h == null || h == '') {
            h = ($(window).height() - 50);
        };
        layer.open({
            id: 'user-rePwd',
            type: 2,
            area: [w + 'px', h + 'px'],
            fix: false,
            maxmin: true,
            shadeClose: true,
            shade: 0.4,
            title: title,
            content: url,
        });
    }
</script>
</html>