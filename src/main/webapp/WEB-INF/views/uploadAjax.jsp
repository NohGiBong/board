<%@ page contentType="text/html; charset=UTF-8" language="java"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
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
</head>
<body>
    <h1>Upload with Ajax</h1>

    <div class="bigPictureWrapper">
        <div class="bigPicture">
        </div>
    </div>

    <div class="uploadDiv">
        <input type="file" name="uploadFile" multiple>
    </div>

    <div class="uploadResult">
        <ul></ul>
    </div>

    <button id="uploadBtn">Upload</button>

<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<script>
    // 원본 이미지를 보여주는 함수
    function showImage(fileCallPath) {
        $(".bigPictureWrapper").css("display", "flex").show();

        $(".bigPicture")
            .html("<img src='/display?fileName=" + encodeURI(fileCallPath) + "'>")
            .animate({ width: '100%', height: '100%' }, 1000);
    }

    $(document).ready(function(){
        // 정규표현식으로 업로드를 제한할 확장자 지정
        var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
        // 파일 크기 제한
        // var maxSize = 5242880;  // 5MB
        var maxSize = 20242880;  // 20MB

        function checkExtension(fileName, fileSize) {
            if(fileSize >= maxSize) {
                alert("파일 사이즈 초과");
                return false;
            }
            if(regex.test(fileName)) {
                alert("해당 종류의 파일은 업로드할 수 없습니다.");
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
                    var fileCallPath =
                        encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
                    str += "<li><div><a href='/download?fileName=" + fileCallPath + "'>" +
                        "<img src='/resources/img/attach.png'>" + obj.fileName + "</a>" +
                        "<span style='cursor: pointer;' data-file=\'" + fileCallPath + "\' data-type='file'> x </span>" +
                        "</div></li>";
                } else {            // 이미지 파일일 경우
                    var fileCallPath =
                        encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
                    var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
                    originPath = originPath.replace(new RegExp(/\\/g), "/");    // 파일 경로 \\ -> / 로 변경

                    console.log(originPath);

                    str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\">" +
                        "<img src='/display?fileName=" + fileCallPath + "'></a>" +
                        "<span style='cursor: pointer;' data-file=\'" + fileCallPath + "\' data-type='image'> x </span>" +
                        "</li>";
                }
            });
            uploadResult.append(str);
        }

        var cloneObj = $(".uploadDiv").clone();

        $("#uploadBtn").on("click", function(){
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

                    $(".uploadDiv").html(cloneObj.html());
                }
           });
        });

        // 첨부 파일 삭제 버튼 클릭 이벤트
        $(".uploadResult").on("click", "span", function () {
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

        // 확대 이미지 닫기
        $(".bigPictureWrapper").on("click", function() {
            $(".bigPicture").animate({ width: '0%', height: '0%' }, 1000);
            setTimeout(function(){
                $(".bigPictureWrapper").hide();
            }, 1000);
        });
    });
</script>
</body>
</html>




