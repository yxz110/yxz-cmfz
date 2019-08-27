<%@ page pageEncoding="utf-8" contentType="text/html;charset=utf-8" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"></c:set>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"
          content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Document</title>
    <link rel="icon" href="${path}/img/favicon.ico">
    <link rel="stylesheet" href="${path}/boot/css/bootstrap.min.css">
    <link rel="stylesheet" href="${path}/jqgrid/css/jquery-ui.css">
    <link rel="stylesheet" href="${path}/jqgrid/css/trirand/ui.jqgrid-bootstrap.css">
    <script src="${path}/boot/js/jquery-2.2.1.min.js"></script>
    <script src="${path}/boot/js/bootstrap.min.js"></script>
    <script src="${path}/jqgrid/js/trirand/jquery.jqGrid.min.js"></script>
    <script src="${path}/jqgrid/js/trirand/i18n/grid.locale-cn.js"></script>
    <script src="../boot/js/ajaxfileupload.js"></script>
    <script charset="utf-8" src="../kindeditor/kindeditor-all-min.js"></script>
    <script charset="utf-8" src="../kindeditor/lang/zh-CN.js"></script>

    <script>

    </script>
</head>
<body>
<nav class="navbar navbar-default">
    <div class="container-fluid">
        <div class="navbar-header">
            <a class="navbar-brand" href="#">持明法州管理系统V2.0</a>
        </div>

        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">

            <ul class="nav navbar-nav navbar-right">
                <li><a href="#">欢迎:<span class="text-primary">${admin.username}</span></a></li>
                <li><a href="#">退出登陆<span class="glyphicon glyphicon-log-out"></span></a></li>
            </ul>
        </div>
    </div>
</nav>
<%--这是左边--%>
<div class="container-fluid">
    <div class="row">
        <!--这是左边-->
        <div class="col-sm-2">
            <%--用户管理--%>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="heading1">
                    <h4 class="panel-title">
                        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse1"
                           aria-expanded="true" aria-controls="collapse1">
                            用户管理
                        </a>
                    </h4>
                </div>
                <div id="collapse1" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading1">
                    <div class="panel-body">
                        <li><a href="javascript:$('#rightTable').load('user.jsp')">用户列表</a></li>
                    </div>
                </div>
            </div>
            <%--上师管理--%>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="heading2">
                    <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                           href="#collapse2" aria-expanded="false" aria-controls="collapse2">
                            上师管理
                        </a>
                    </h4>
                </div>
                <div id="collapse2" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading2">
                    <div class="panel-body">
                        <li><a href="#">上师列表</a></li>
                    </div>
                </div>
            </div>
            <%--文章管理--%>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="heading3">
                    <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                           href="#collapse3" aria-expanded="false" aria-controls="collapse3">
                            文章管理
                        </a>
                    </h4>
                </div>
                <div id="collapse3" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading3">
                    <div class="panel-body">
                        <li><a href="javascript:$('#rightTable').load('article.jsp')">文章列表</a></li>
                    </div>
                </div>
            </div>
            <%--专辑管理--%>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="heading4">
                    <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                           href="#collapse4" aria-expanded="false" aria-controls="collapse4">
                            专辑管理
                        </a>
                    </h4>
                </div>
                <div id="collapse4" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading4">
                    <div class="panel-body">
                        <li><a href="javascript:$('#rightTable').load('album.jsp')">专辑列表</a></li>
                    </div>
                </div>
            </div>
            <%--轮播图管理--%>
            <div class="panel panel-default">
                <div class="panel-heading" role="tab" id="heading5">
                    <h4 class="panel-title">
                        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion"
                           href="#collapse5" aria-expanded="false" aria-controls="collapse5">
                            轮播图管理
                        </a>
                    </h4>
                </div>
                <div id="collapse5" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading5">
                    <div class="panel-body">
                        <li><a href="javascript:$('#rightTable').load('banner.jsp')">轮播图列表</a></li>
                    </div>
                </div>
            </div>

        </div>

        <!--这是右边-->
        <div class="col-sm-10" id="rightTable">
            <div class="jumbotron">
                <h3>欢迎来到持明法洲后台管理系统</h3>
            </div>
            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                <!-- Indicators -->
                <ol class="carousel-indicators">
                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                </ol>

                <!-- Wrapper for slides -->
                <div class="carousel-inner" role="listbox">
                    <div class="item active">
                        <img src="${path}/img/shouye.jpg" alt="...">
                        <div class="carousel-caption">
                        </div>
                    </div>
                    <div class="item">
                        <img style="width: 100%;height: 327.59px" src="${path}/img/A2.jpg" alt="...">
                        <div class="carousel-caption">
                        </div>
                    </div>
                </div>

                <!-- Controls -->
                <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                </a>
            </div>


        </div>
    </div>

</div>
</div>


<%-- 面板 --%>
<nav class="navbar navbar-default navbar-fixed-bottom">
    <div class="panel panel-default">
        <div style="text-align: center" class="panel-body">
            版权所有 © 2011 zparkhr.cn 北京百知教育信息技术有限公司
        </div>
    </div>
</nav>
</body>
</html>
