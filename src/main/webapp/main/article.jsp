<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; utf-8" %>
<script>
    $(function () {
        $("#articleList").jqGrid({
            url: "${pageContext.request.contextPath}/article/getAll",
            datatype: "json",
            colNames: ["编号", "书名", "作者", "内容", "创建时间", "状态", "操作"],
            colModel: [
                {name: "id"},
                {name: "title"},
                {name: "author"},
                {name: "content", hidden: true},
                {name: "createdate", formatter: "date"},
                {name: "status"},
                {
                    name: "", formatter: function (a, b, c) {
                        console.log(c);
                        return "<a onclick=\"lookModel('" + c.id + "')\" href='#'>查看详情</a>"
                    }
                },
            ],
            styleUI: "Bootstrap",
            autowidth: true,//宽度自适应
            pager: "#bannerPager",//分页栏
            height: "60%",//高度
            page: 1,
            rowNum: 40,
            viewrecords: true,//显示总条数
            rowList: [2, 4, 6],//每页显示多少条
            multiselect: true//多选框
        })
    })

    function showModel() {
        $("#myModal").modal("show");
        /*  清空表单  */
        $("#addArticleFrom")[0].reset();
        $("#modal_footer").html(
            "<button type=\"button\" onclick=\"addArticle()\" class=\"btn btn-primary\">添加</button>\n" +
            "<button type=\"button\" class=\"btn btn-danger\" data-dismiss=\"modal\">取消</button>"
        );
        /*初始化属性*/
        KindEditor.create('#editor', {
            /*指定图片及回显路径*/
            uploadJson: "${pageContext.request.contextPath}/kindeditor/upload",

            filePostName: "img",/*指定上传图片的名称*/

            allowFileManager: true, /*图片空间按钮显示*/

            /*图片空间 的路径*/
            fileManagerJson: "${pageContext.request.contextPath}/kindeditor/allImages",

            /* 编辑器失去焦点  */
            afterBlur: function () {
                this.sync();
            }
        });
        /*  清空编辑器  */
        KindEditor.html("#editor", "");
    }

    /*  添加  */
    function addArticle() {
        $.ajax({
            url: "${pageContext.request.contextPath}/article/add",
            datatype: "json",
            type: "post",
            data: $("#addArticleFrom").serialize(),
            success: function (data) {
                //执行完之后隐藏 modal框
                $("#myModal").modal("toggle");
            }
        })
    }

    /*  查看数据  */
    function lookModel(id) {
        $("#myModal").modal("show");
        /*getRowData 返回指定行的值*/
        var value = $("#articleList").jqGrid("getRowData", id);
        console.log(value);


        /*给input框赋值*/

        $("#articleId").val(value.id);
        $("#title").val(value.title);
        $("#author").val(value.author);
        $("#status").val(value.status);

        $("#modal_footer").html(
            "<button type=\"button\" onclick=\"updateArticle()\" class=\"btn btn-primary\">修改</button>\n" +
            "<button type=\"button\" class=\"btn btn-danger\" data-dismiss=\"modal\">取消</button>"
        );
        KindEditor.create('#editor', {
            uploadJson: "${pageContext.request.contextPath}/kindeditor/upload",
            filePostName: "img",
            allowFileManager: true,
            fileManagerJson: "${pageContext.request.contextPath}/kindeditor/allImages",
            afterBlur: function () {
                this.sync();
            }
        });
        /*  html再次刷新 删除数据   appendHtml追加数据*/
        KindEditor.appendHtml("#editor", value.content);
    }

    /*  修改按钮  */
    function updateArticle() {
        $.ajax({
            url: "${pageContext.request.contextPath}/article/update",
            datatype: "json",
            type: "post",
            data: $("#addArticleFrom").serialize(),
            success: function (data) {
                $("#myModal").modal("toggle");
            }
        })
    }

</script>
<%--  标签页  --%>
<div>
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab"
                                                  data-toggle="tab">文章列表</a></li>
        <li role="presentation"><a href="#profile" onclick="showModel()" aria-controls="profile" role="tab"
                                   data-toggle="tab">添加文章</a></li>
    </ul>
</div>


<table id="articleList"></table>
<div style="heigth: 50px" id="articlePager"></div>


<%--  模态框  --%>
<div class="modal fade" id="myModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content" style="width:750px">
            <!--模态框标题-->
            <div class="modal-header">
                <!--
                    用来关闭模态框的属性:data-dismiss="modal"
                -->
                <button type="button" class="close" data-dismiss="modal"><span>&times;</span></button>
                <h4 class="modal-title">编辑用户信息</h4>
            </div>

            <!--模态框内容体-->
            <div class="modal-body">
                <form action="${pageContext.request.contextPath}/article/editArticle" class="form-horizontal"
                      id="addArticleFrom">

                    <div class="form-group">

                        <div class="col-sm-5">
                            <input type="hidden" name="id" id="articleId">
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-sm-1 control-label">标题</label>
                        <div class="col-sm-5">
                            <input type="text" name="title" id="title" placeholder="请输入标题" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">作者</label>
                        <div class="col-sm-5">
                            <input type="text" name="author" id="author" placeholder="请输入标题" class="form-control">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label">状态</label>
                        <div class="col-sm-5">
                            <select class="form-control" name="status" id="status">
                                <option value="y">展示</option>
                                <option value="n">不展示</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-sm-12">
                            <textarea id="editor" name="content" style="width:700px;height:300px;"></textarea>
                        </div>
                    </div>
                    <input id="addInsertImg" name="insertImg" hidden>
                </form>
            </div>
            <!--模态页脚-->
            <div class="modal-footer" id="modal_footer">
                <%--<button type="button" class="btn btn-primary">保存</button>
                <button type="button" class="btn btn-danger" data-dismiss="modal">取消</button>--%>
            </div>
        </div>
    </div>
</div>