<%@page pageEncoding="UTF-8" isELIgnored="false" contentType="text/html; utf-8" %>
<script>
    $(function () {
        $("#albumList").jqGrid({
            url: "${pageContext.request.contextPath}/album/getAll",
            editurl: "${pageContext.request.contextPath}/album/edit",
            datatype: "json",
            colNames: ["id", "名称", "分数", "作者", "播音员", "集数", "简介", "状态", "上传时间", "插图"],
            colModel: [
                {name: "id", hidden: true},
                {name: "title", editable: true},
                {name: "score"},
                {name: "author", editable: true},
                {name: "broadcast", editable: true},
                {name: "acount"},
                {name: "brief", editable: true},
                {
                    name: "status", editable: true, edittype: "select",
                    editoptions: {value: "展示:展示;不展示:不展示"}
                },
                {name: "createdate", formatter: "date"},
                {
                    name: "imgpic", editable: true, edittype: "file",
                    formatter: function (cellValue, options, rowObject) {
                        return "<img style='height:80px;width:100px' src='${pageContext.request.contextPath}/img/" + cellValue + "'/>"
                    }
                }
            ],
            styleUI: "Bootstrap",
            autowidth: true,
            pager: "#albumPager",
            height: "60%",
            page: 1,
            rowNum: 2,
            viewrecords: true,
            rowList: [2, 4, 6],
            multiselect: true,
            subGrid: true,   //1.开启子表
            subGridRowExpanded: function (subGirdId, albumId) {
                addSubGrid(subGirdId, albumId);
            }
        }).jqGrid("navGrid", "#albumPager", {search: false, del: false},
            {
                closeAfterEdit: true,
                beforeShowForm: function (obj) {
                    obj.find("#imgpic").attr("disabled", true);
                }
            },
            {
                closeAfterAdd: true,
                afterSubmit: function (response) {
                    var albumId = response.responseJSON.id;
                    $.ajaxFileUpload({
                        url: "${pageContext.request.contextPath}/album/upload",
                        fileElementId: "imgpic",
                        data: {albumId: albumId},
                        success: function () {
                            $("#albumList").trigger("reloadGrid");
                        }
                    });

                    return response;
                }
            }
        )
    });   /*   +++++++++子表++++++++++++++++    */
    function addSubGrid(subGirdId, albumId) {
        var subGridTableId = subGirdId + "table";
        var subGridPagerId = subGirdId + "pager";
        $("#" + subGirdId).html(
            "<table id='" + subGridTableId + "' class=\"table table-striped\"></table>" +
            "<div id='" + subGridPagerId + "' style=\"height: 50px\"></div>")
        $("#" + subGridTableId).jqGrid({
            url: "${pageContext.request.contextPath}/chapter/getAll?albumId=" + albumId,
            editurl: "${pageContext.request.contextPath}/chapter/edit?albumId=" + albumId,
            datatype: "json",
            colNames: ["id", "标题", "音频", "大小", "时长", "状态", "创建时间", "专辑ID", "操作"],
            colModel: [
                {name: "id"},
                {name: "title", editable: true},
                {name: "url", editable: true, edittype: "file"},
                {name: "size"},
                {name: "duration"},
                {
                    name: "status", editable: true,
                    edittype: "select",
                    editoptions: {value: "y:已授权;n:未授权"}
                },
                {name: "createdate", formatter: "date"},
                {name: "albumId"},
                {
                    name: "url",
                    formatter: function (urlvalue, b, c) {
                        return "<a href='#' onclick=\"playAudio('" + urlvalue + "')\"><span class='glyphicon glyphicon-play-circle'></span></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" +
                            "<a href='#' onclick=\"downLoadAudio('" + urlvalue + "')\"><span class='glyphicon glyphicon-download'></span></a> "
                    }
                },
            ],
            pager: "#" + subGridPagerId,
            rowNum: 5,
            rowList: [3, 4, 7],
            viewrecords: true,
            height: '100px',
            multiselect: true,
            rownumbers: true,
            viewrecords: true,
            styleUI: "Bootstrap",
            autowidth: true
        }).jqGrid("navGrid", "#" + subGridPagerId, {search: false, del: false, edit: false},
            {},
            {
                closeAfterAdd: true,
                afterSubmit: function (response) {
                    var chapterId = response.responseText;
                    $.ajaxFileUpload({
                        url: "${pageContext.request.contextPath}/chapter/upload",
                        fileElementId: "url",
                        data: {chapterId: chapterId},
                        success: function () {
                            $('#' + tableId).trigger("reloadGrid");
                        }
                    })
                    return response;
                }
            }
        )
    }

    function playAudio(urlvalue) {
        $("#audioModel").modal("show");
        $("#audioId").attr("src", "${pageContext.request.contextPath}/music/" + urlvalue);
    }

    function downLoadAudio(urlvalue) {
        location.href = "${pageContext.request.contextPath}/chapter/down?audioName=" + urlvalue;
    }
</script>

<div id="audioModel" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <audio id="audioId" src="" controls></audio>
    </div>
</div>

<table id="albumList" class="table table-striped"></table>
<div id="albumPager" style="height:50px"></div>