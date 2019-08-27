<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; utf-8" %>
<script>
    $(function () {
        $("#bannerList").jqGrid({
            url: "${pageContext.request.contextPath}/banner/findAll",
            editurl: "${pageContext.request.contextPath}/banner/edit",
            datatype: "json",
            colNames: ["编号", "标题", "状态", "描述", "创建时间", "图片"],
            colModel: [
                {name: "id"},
                {name: "title", editable: true},
                {
                    name: "status", editable: true, edittype: "select",
                    editoptions: {value: "y:展示;n:不展示"}
                },
                {name: "describe", editable: true},
                {name: "createdate", formatter: "date"},
                {
                    name: "imgpic", editable: true, edittype: "file",
                    formatter: function (cellvalues, options, rowObject) {
                        return "<img style='height:100px;width:150px' src='${pageContext.request.contextPath}/img/" + cellvalues + "'/>"
                    }
                },
            ],
            styleUI: "Bootstrap",
            autowidth: true,//宽度自适应
            pager: "#bannerPager",//分页栏
            height: "60%",//高度
            page: 1,
            rowNum: 2,
            viewrecords: true,//显示总条数
            rowList: [2, 4, 6],//每页显示多少条
            multiselect: true//多选框
        }).jqGrid("navGrid", "#bannerPager",//分页工具栏  删除/添加/修改
            {
                //第一个括号操作按钮的展示雨不展示
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
                        url: "${pageContext.request.contextPath}/banner/upload",
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
    })
</script>
<table id="bannerList"></table>
<div style="heigth: 50px" id="bannerPager"></div>