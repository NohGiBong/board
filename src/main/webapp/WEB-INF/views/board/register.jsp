<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="../includes/header.jsp" %>

<style>
    .uploadResult {
        width: 100%;
        background-color: gray;
    }
    .uploadResult ul {
        display: flex;
        flex-flow: row;
        justify-content: center;
        align-items: center;
    }
    .uploadResult ul li {
        list-style: none;
        padding: 10px;
        align-content: center;
        text-align: center;
    }
    .uploadResult ul li img {
        width: 100px;
    }
    .uploadResult ul li span {
        color: white;
    }

    .bigPictureWrapper {
        position: absolute;
        display: none;
        justify-content: center;
        align-items: center;
        top: 0%;
        width: 100%;
        height: 100%;
        background-color: gray;
        z-index: 100;
        background: rgba(255, 255, 255, 0.5);
    }
    .bigPicture {
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
    }
    .bigPicture img {
        width: 600px;
    }
</style>

<div class="row">
    <div class="container-fluid">
        <div class="col-lg-12">
            <h1 class="page-header">Board Register</h1>
        </div>
        <!--  /.col-lg-12 -->
    </div>
</div>
<!-- /.row -->

<div class="row">
    <div class="container-fluid">
        <div class="col-lg-12">
            <div class="panel panel-default card mb-4">
                <div class="panel-heading card-header">Board Register</div>
                <!--  /.panel-heading -->
                <div class="panel-body card-body">

                    <form role="form" action="/board/register" method="post">
                        <div class="form-group">
                            <label>Title</label>
                            <input class="form-control" name="title">
                        </div>
                        <div class="form-group">
                            <label>Text Area</label>
                            <textarea class="form-control" rows="3" name="content"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Writer</label>
                            <input class="form-control" name="writer">
                        </div>
                        <button type="submit" class="btn btn-success">Submit Button
                        </button>
                        <button type="reset" class="btn btn-warning">Reset Button
                        </button>
                    </form>

                </div>
                <!--  end panel-body -->
            </div>
            <!--  end panel-body -->
        </div>
        <!-- end panel -->
    </div>
</div>
<!--  /.row -->

<div class="row">
    <div class="container-fluid">
        <div class="col-lg-12">
            <div class="panel panel-default card">
                <div class="panel-heading card-header">File Attach</div>
                <!-- /.panel-heading -->
                <div class="panel-body card-body">
                    <div class="form-group uploadDiv">
                        <input type="file" name="uploadFile" multiple>
                    </div>

                    <div class="uploadResult">
                        <ul></ul>
                    </div>

                </div>
                <!-- end panel-body -->
            </div>
            <!-- end panel -->
        </div>
    </div>
</div>
<!-- /.row -->

<script>
    $(document).ready(function (e) {
        var formObj = $("form[role=form]");

        $("button[type=submit]").on("click", function (e) {
            e.preventDefault();

            var str = "";

            $(".uploadResult ul li").each(function (i, obj) {
                var jobj = $(obj);

                str += "<input type='hidden' name='attachList["+i+"].fileName' value='" + jobj.data("filename") + "'>";
                str += "<input type='hidden' name='attachList["+i+"].uuid' value='" + jobj.data("uuid") + "'>";
                str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='" + jobj.data("path") + "'>";
                str += "<input type='hidden' name='attachList["+i+"].fileType' value='" + jobj.data("type") + "'>";

            });
            formObj.append(str).submit();
        });

        // 정규표현식으로 업로드를 제한할 확장자 지정
        var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        // 파일 크기 제한
        // var maxSize = 5242880;  // 5MB
        var maxSize = 20242880;  // 20MB

        function checkExtension(fileName, fileSize) {
            if (fileSize >= maxSize) {
                alert("파일 사이즈 초과");
                return false;
            }
            if (regex.test(fileName)) {
                alert("해당 종류의 파일은 업로드 할 수 없습니다.");
                return false;
            }
            return true;
        }

        var uploadResult = $(".uploadResult ul");

        // 업로드 리스트를 보여주는 함수
        function showUploadedFile(uploadResultArr) {
            var str = "";

            $(uploadResultArr).each(function(i, obj) {
                if(!obj.image) {    // 일반 첨부파일일 경우
                    var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
                    str += "<li data-path='" + obj.uploadPath + "'";
                    str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'>";
                    str += "	<div>";
                    str += "		<span>" + obj.fileName + "</span>";
                    str += "		<button type='button' data-file=\'" + fileCallPath + "\'data-type='file' " +
                        "class='btn btn-warning btn-circle'>" +
                        "<i class='fa fa-times'></i></button><br>";
                    str += "		<img src='/resources/img/attach.png'>";
                    str += "	</div>";
                    str += "</li>";
                } else {            // 이미지 파일일 경우
                    var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);

                    str += "<li data-path='" + obj.uploadPath + "'";
                    str += " data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.image + "'>";
                    str += "	<div>";
                    str += "		<span>" + obj.fileName + "</span>";
                    str += "		<button type='button' data-file=\'" + fileCallPath + "\'data-type='image' " +
                        "class='btn btn-warning btn-circle'>" +
                        "<i class='fa fa-times'></i></button><br>";
                    str += "		<img src='/display?fileName=" + fileCallPath + "'>";
                    str += "	</div>";
                    str += "</li>";
                }
            });
            uploadResult.append(str);
        }

        // 첨부 파일 삭제 버튼 클릭 이벤트
        $(".uploadResult").on("click", "button", function () {
            var targetFile = $(this).data("file");      // 썸네일 파일명
            var type = $(this).data("type");            // 파일인지 이미지인지 구분
            var target_li = $(this).closest("li");      // x 버튼에서 가장 가까운 <li> 태그 지정

            if(!confirm("정말 삭제하시겠습니까?")) {
                return false;
            }

            $.ajax({
                url: '/deleteFile',
                data: { fileName: targetFile, type: type },
                dataType: 'text',
                type: 'POST',
                success: function (result) {
                    // 삭제한 파일을 첨부파일 목록에서 제거
                    target_li.remove();
                    alert(result);
                }
            });
        });

        // 파일에 대한 변화가 있을 시 이벤트
        $("input[type=file]").change(function (){
            var formData = new FormData();
            var inputFile = $("input[name=uploadFile]");
            var files = inputFile[0].files;
            console.log(files);

            // add fileData to formData
            for(var i = 0; i < files.length; i++) {
                if(!checkExtension(files[i].name, files[i].size)) {
                    return false;
                }

                formData.append("uploadFile", files[i]);
            }

            // processData, contentType은 반드시 false!! 로 해야 파일 전송됨
            $.ajax({
                url: "/uploadAjaxAction",
                processData: false,
                contentType: false,
                data: formData,
                type: "post",
                dataType: "json",
                success: function(result) {
                    showUploadedFile(result);

                    $(".uploadDiv").find("input[type=file]").val("");
                }
            });
        });
    });
</script>

<%@ include file="../includes/footer.jsp" %>



