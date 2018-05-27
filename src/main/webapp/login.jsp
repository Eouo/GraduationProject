<%@ page language="java" import="java.util.*" pageEncoding="utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <title>水果买卖平台</title>

    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<jsp:include page="WEB-INF/view/include/header.jsp"></jsp:include>

<link href="${pageContext.request.contextPath}/resources/css/login.css" rel="stylesheet"/>

<jsp:include page="WEB-INF/view/include/header.jsp"></jsp:include>
</head>
<body>

<div id="login-container">

    <div id="login-header">

        <h1>水果买卖平台</h1>

    </div>

    <div id="login-content" class="clearfix">

        <form class="form-inline" method="post" id="loginForm" action="loginIn">

            <div class="form-group">
                <input class="form-control" type="text" name="userName" id="userName" placeholder="用户名">
            </div>

            <div class="form-group">
                <input class="form-control" type="password" name="Password" id="Password" placeholder="密码">
            </div>

            <label> <input class="radio-inline" id="type" name="RadioList" type="radio" value="1" checked/>用户 </label>
            <label> <input class="radio-inline" id="type" name="RadioList" type="radio" value="0"/>管理员 </label>

            <div class="login-a">
                <a class="btn btn-warning btn-large" onclick="login()">登陆</a>
            </div>


            <div class="end-a">
                <label> <a href="#" onclick="add();">还没注册？马上注册</a> </label>
            </div>
        </form>
    </div>


    <!-- edit Modal start -->
    <div class="modal hide fade" id="addUser" tabindex="-1" role="dialog">
        <div class="modal-header">
            <button class="close" type="button" data-dismiss="modal">×</button>
            <h3>用户注册</h3>
        </div>
        <div class="modal-body">
            <jsp:include page="WEB-INF/view/user/addUser.jsp"></jsp:include>
        </div>
    </div>


    <script type="text/javascript" src="${ctx}/resources/js/jquery.easyui.min.js"></script>

    <script type="text/javascript">


        $(function () {

            var space = "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"
            $('#addForm').bootstrapValidator({
                fields: {
                    userName: {
                        message: '用户名验证失败',
                        validators: {
                            notEmpty: {
                                message: space + '用户名不能为空'
                            },
                            regexp: {
                                regexp: /^[a-zA-Z0-9]+$/,
                                message: space + '用户名只能包含大小写和数字'
                            },
                            stringLength: {
                                min: 2,
                                max: 15,
                                message: space + '用户名长度必须在2到20之间'
                            },
                        }
                    },
                    password: {
                        validators: {
                            notEmpty: {
                                message: space + '密码不能为空'
                            },
                            regexp: {//匹配规则
                                regexp: /^[a-zA-Z0-9]+$/,
                                message: space + '密码只能包含大小写和数字'
                            },
                            stringLength: {
                                min: 3,
                                max: 20,
                                message: space + '密码长度必须在3到20之间'
                            },
                        }
                    },
                    repassword: {
                        validators: {
                            notEmpty: {
                                message: space + '不能为空'
                            },
                            identical: {//相同
                                field: 'password',
                                message: space + '两次密码不一致'
                            },
                        }
                    },
                    phone: {
                        validators: {
                            notEmpty: {
                                message: space + '电话不能为空'
                            },
                            stringLength: {
                                min: 11,
                                max: 11,
                                message: space + '请输入11位手机号码'
                            },
                        }
                    }, age: {
                        validators: {
                            stringLength: {
                                min: 1,
                                max: 3,
                                message: space + '请输入正确的年龄'
                            },
                        }
                    }, eMail: {
                        validators: {
                            notEmpty: {
                                message: space + '邮箱不能为空'
                            },
                            regexp: {
                                regexp: /^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+(.[a-zA-Z0-9_-])+/,
                                message: space + '邮箱输入有误'
                            },
                        }
                    },
                }
            });

        });


        function add() {
            $('#addUser').modal('show');
        }

        var message = "${message}"
        if ("no" == message) {
            $.messager.alert("警告", "无此用户！");
        } else if ("error" == message) {
            $.messager.alert("警告", "密码错误!");
        } else if ("black" == message) {
            $.messager.alert("警告", "您已被拉黑！");
        }

        function login() {

            $('#loginForm').submit();

        }

    </script>
</body>
</html>
