<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; utf-8" %>
<script>
    $(function () {
        $("#albumList").jqGrid({
            url: "${pageContext.request.contextPath}/user/getAll",
            datatype: "json",
            colNames: ["id", "姓名", "密码", "性别", "法名", "省市", "创建日期", "签名", "图片", "状态"],
            colModel: [
                {name: "id", hidden: true},
                {name: "name", editable: true},
                {name: "passwrod"},
                {name: "sex", editable: true},
                {name: "dharma", editable: true},
                {name: "provice"},
                {name: "createdate", formatter: "date"},
                {name: "sign", editable: true},
                {
                    name: "imgpic", editable: true, edittype: "file",
                    formatter: function (cellValue, options, rowObject) {
                        return "<img style='height:80px;width:100px' src='${pageContext.request.contextPath}/img/" + cellValue + "'/>"
                    }
                },
                {
                    name: "status", editable: true, edittype: "select",
                    editoptions: {value: "y:展示;n:不展示"}
                }
            ],
            styleUI: "Bootstrap",
            autowidth: true,
            pager: "#albumPager",
            height: "90%",
            page: 1,
            rowNum: 4,
            viewrecords: true,
            rowList: [4, 8, 10],
            multiselect: true,
            subGrid: true,   //1.开启子表
            subGridRowExpanded: function (subGirdId, albumId) {
                addSubGrid(subGirdId, albumId);
            }
        }).jqGrid("navGrid", "#albumPager",//分页工具栏  删除/添加/修改
            {
                //第一个括号操作按钮的展示 不展示
                search: false
            },

            { //执行编辑时进行的操作
                closeAfterEdit: true,
                beforeShowForm: function (obj) {
                    obj.find("#title").attr("readonly", true);
                    obj.find("#describe").attr("readonly", true);
                    obj.find("#imgpic").attr("disabled", true);
                }
            },
            {//执行添加时进行额外操作
                closeAfterAdd: true,
                afterSubmit: function (response) {
                    var bannerId = response.responseJSON.id;
                    console.log(bannerId);
                    $.ajaxFileUpload({
                        url: "${pageContext.request.contextPath}/user/add",
                        fileElementId: "imgpic",
                        data: {bannerId: bannerId},
                        success: function () {
                            $("#bannerList").trigger("reloadGrid");
                        }
                    });
                    return response;
                }
            },
            {//删除时。。。。

            }
        )
    });

    function outUserMsg() {
        location.href = "${pageContext.request.contextPath}/user/all"
    }
</script>

<div>
    <!-- Nav tabs -->
    <ul class="nav nav-tabs" role="tablist">
        <li role="presentation" class="active"><a href="#home" aria-controls="home" role="tab"
                                                  data-toggle="tab">用户信息</a></li>
        <li><a href="#" onclick="outUserMsg()">导出用户信息</a></li>

    </ul>
</div>

<table id="albumList" class="table table-striped"></table>
<div id="albumPager" style="height:60px"></div>