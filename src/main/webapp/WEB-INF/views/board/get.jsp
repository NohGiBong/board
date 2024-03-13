<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ include file="../includes/header.jsp" %>

<div class="row">
    <div class="container-fluid">
        <div class="col-lg-12">
            <h1 class="page-header">Board Read Page</h1>
        </div>
        <!--  /.col-lg-12 -->
    </div>
</div>
<!-- /.row -->

<div class="row">
    <div class="container-fluid">
        <div class="col-lg-12">
            <div class="panel panel-default card mb-4">
                <div class="panel-heading card-header">Board Read Page</div>
                <!--  /.panel-heading -->
                <div class="panel-body card-body">
                    <div class="form-group">
                        <label>Bno</label>
                        <input class="form-control" name="bno" value="${board.bno}" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Title</label>
                        <input class="form-control" name="title" value="${board.title}" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label>Text Area</label>
                        <textarea class="form-control" rows="3" name="content" readonly="readonly">${board.content}</textarea>
                    </div>
                    <div class="form-group">
                        <label>Writer</label>
                        <input class="form-control" name="writer" value="${board.writer}" readonly="readonly">
                    </div>
                    <button data-oper="modify" class="btn btn-warning">Modify</button>
                    <button data-oper="list" class="btn btn-info">List</button>

                    <form id="operForm" action="/board/modify">
                        <input type="hidden" id="bno" name="bno" value="${board.bno}">
                        <input type="hidden" name="pageNum" value="${paging.pageNum}">
                        <input type="hidden" name="amount" value="${paging.amount}">
                        <input type="hidden" name="type" value="${paging.type}">
                        <input type="hidden" name="keyword" value="${paging.keyword}">
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
<div class="bigPictureWrapper">
    <div class="bigPicture">
    </div>
</div>
<div class="row">
    <div class="container-fluid">
        <div class="col-lg-12">
            <div class="panel panel-default card mb-4">
                <div class="panel-heading card-header">Files</div>
                <!-- /.panel-heading -->
                <div class="panel-body card-body">

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

<div class="row">
    <div class="container-fluid">
        <div class="col-lg-12">
            <div class="card mb-4">
                <!-- /.panel -->
                <div class="panel panel-default card-header">
                    <i class="fa fa-comments fa-fw"></i> Reply
                    <button id="addReplyBtn" class="btn btn-primary btn-xs pull-right float-right">New Reply</button>
                </div>

                <!-- /.panel-heading -->
                <div class="panel-body card-body">
                    <ul class="chat">
                        <!-- start reply -->
                        <li class="left clearfix" data-rno="12">
                            <div>
                                <div class="header">user00
                                    <small class="pull-right text-muted">2018-01-01 13:13</small>
                                </div>
                                <p><strong class="primary-font">Good job!</strong></p>
                            </div>
                        </li>
                        <!-- end reply -->
                    </ul>
                    <!-- ./ end ul -->
                </div>
                <!-- /.panel .chat-panel -->
                <div class="panel-footer card-footer">

                </div>
            </div>
        </div>
    </div>
    <!-- ./ end row -->
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <!-- 		        <button type="button" class="close" data-dismiss="modal" -->
                <!-- 		          aria-hidden="true">&times;</button> -->
                <h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label>Reply</label>
                    <input class="form-control" name='reply' value='New Reply!!!!'>
                </div>
                <div class="form-group">
                    <label>Replyer</label>
                    <input class="form-control" name='replyer' value='replyer'>
                </div>
                <div class="form-group">
                    <label>RegDate</label>
                    <input class="form-control" name='regDate' value='2018-01-01 13:13'>
                </div>
            </div>
            <div class="modal-footer">
                <button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
                <button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
                <button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
                <button id='modalCloseBtn' type="button" class="btn btn-primary">Close</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->

<script type="text/javascript" src="/resources/js/reply.js"></script>

<script>
    // 원본 이미지를 보여주는 함수
    function showImage(fileCallPath) {
        $(".bigPictureWrapper").css("display", "flex").show();

        $(".bigPicture")
            .html("<img src='/display?fileName=" + fileCallPath + "'>")
            .animate({ width: '100%', height: '100%' }, 1000);
    }

    $(document).ready(function () {
        var bno = "${board.bno}";

        $.getJSON("/board/getAttachList", {bno: bno}, function(arr) {
           var str = "";

           $(arr).each(function(i, attach) {
              if(attach.fileType) {     // 이미지일 경우
                  var fileCallPath = encodeURIComponent(attach.uploadPath + "/s_" + attach.uuid + "_" + attach.fileName);

                  str += "<li data-path='" + attach.uploadPath + "'";
                  str += "    data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "'>";
                  str += "      <div>";
                  str += "          <img src='/display?fileName=" + fileCallPath + "'>";
                  str += "      </div>";
                  str += "</li>";
              } else {                  // 일반 파일일 경우
                  str += "<li data-path='" + attach.uploadPath + "'>";
                  str += "    data-uuid='" + attach.uuid + "' data-filename='" + attach.fileName + "' data-type='" + attach.fileType + "'>";
                  str += "      <div>";
                  str += "          <span>" + attach.fileName + "</span>";
                  str += "          <img src='/resources/img/attach.png'>";
                  str += "      </div>";
                  str += "</li>";
              }
           });
            $(".uploadResult ul").html(str);
        });

        // 확대 이미지 닫기
        $(".bigPictureWrapper").on("click", function() {
            $(".bigPicture").animate({width: '0%', height: '0%'}, 1000);
            setTimeout(function () {
                $(".bigPictureWrapper").hide();
            }, 1000);
        });

        // 첨부 파일 각 항목 클릭 이벤트
        $(".uploadResult").on("click", "li", function () {
            var liObj = $(this);
            var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));

            if (liObj.data("type")) {       // 이미지인 경우
                showImage(path.replace(new RegExp(/\\/g), "/"));
            } else {                        // 일반 파일인 경우
                self.location = "/download?fileName=" + path;
            }
        });
    });


</script>

<script>
    $(document).ready(function(){

        var operForm = $("#operForm");

        $("button[data-oper='modify']").on("click", function(){
            operForm.attr("action", "/board/modify");
            operForm.submit();
        });

        $("button[data-oper='list']").on("click", function(){
            operForm.find("#bno").remove();
            operForm.attr("action", "/board/list");
            operForm.submit();
        });
    });
</script>

<script>
    $(document).ready(function(){
        // 댓글 리스트 조회
        var bnoValue = "${board.bno}";
        var replyUL = $(".chat");

        function showList(page) {
            replyService.getList({ bno: bnoValue, page: page||1 }, function(replyCnt, list) {
               var str = "";
               if(list == null || list.length == 0) {
                   replyUL.html("");
                   return;
               }
               for(var i = 0, len = list.length || 0; i < len; i++) {
                   str += '<li className="left clearfix" data-rno="' + list[i].rno + '">';
                   str += '     <div>';
                   str += '        <div className="header">' + list[i].replyer;
                   str += '            <small className="pull-right text-muted">' + replyService.displayTime(list[i].regDate) + '</small>';
                   str += '        </div>';
                   str += '        <p><strong className="primary-font">' + list[i].reply + '</strong></p>';
                   str += '    </div>';
                   str += '</li>';
               }
               replyUL.html(str);

               // 페이징 조회(아직 미구현)
                showReplyPage (replyCnt)

            });
        }

        showList(1);

        var pageNum = 1;
        var replyPageFooter = $(".panel-footer");

        function showReplyPage(replyCnt) {
            var endNum = Math.ceil(pageNum / 5.0) * 5;
            var startNum = endNum - 4;      // (5(한 페이지에 보여질 게시글 갯수) - 1)

            var prev = startNum != 1;
            var next = false;

            if(endNum * 5 >= replyCnt) {
                endNum = Math.ceil(replyCnt / 5.0);
            }

            if(endNum * 5 < replyCnt) {
                next = true;
            }

            var str = "<ul class='pagination justify-content-center'>";

            if(prev){
                str += "<li class='page-item'><a class='page-link' href='" + (startNum - 1) + "'>Previous</a></li>";
            }

            for(var i = startNum; i <= endNum; i++){
                var active = pageNum == i ? "active" : "";

                str += "<li class='page-item " + active + " '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
            }

            if(next){
                str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
            }

            str += "</ul></div>";

            replyPageFooter.html(str);
        }

        // 페이지 번호 클릭 이벤트
        replyPageFooter.on("click", "li a", function (e) {
            e.preventDefault();

            var targetPageNum = $(this).attr("href");
            pageNum = targetPageNum;

            showList(pageNum);
        });

        // 댓글 쓰기 modal 창 열기
        var modal = $(".modal");
        var modalInputReply = modal.find("input[name=reply]");
        var modalInputReplyer = modal.find("input[name=replyer]");
        var modalInputRegDate = modal.find("input[name=regDate]");

        var modalModBtn = $("#modalModBtn");
        var modalRemoveBtn = $("#modalRemoveBtn");
        var modalRegisterBtn = $("#modalRegisterBtn");

        // 'New Reply' 버튼 클릭
        $("#addReplyBtn").on("click", function() {
            // modal의 입력 부분값 전부 ""로
            modal.find("input").val("");
            // 댓글 쓰기 시 RegDate(등록일) 부분(div)은 보여주지 않기
            modalInputRegDate.closest("div").hide();
            // Modify/Remove/Register/Close 버튼 중에 Close를 제외한 버튼은 숨기기
            modal.find("button[id != 'modalCloseBtn']").hide();

            // Register 버튼 보이게 하기(등록을 해야 하므로...)
            modalRegisterBtn.show();

            modal.modal("show");
        });

        // 모달 내 close 버튼 클릭 이벤트
        $("#modalCloseBtn").on("click", function(){
            // 모달 창 닫기
            modal.modal("hide");
        });

        // 새 댓글 입력
        modalRegisterBtn.on("click", function(){
           var reply = {
                reply : modalInputReply.val(),
                replyer : modalInputReplyer.val(),
                bno : bnoValue
           };

           // 댓글 내용/작성자 validation check
            var replyArea = $("#myModal").find("input[name=reply]");
            var replyerArea = $("#myModal").find("input[name=replyer]");

            if(replyArea.val() == "" || replyArea.val().length < 1) {
                alert("내용을 입력해주세요.");
                replyArea.focus();
                return false;
            }

            if(replyerArea.val() == "" || replyerArea.val().length < 1) {
                alert("작성자를 입력해주세요.");
                replyerArea.focus();
                return false;
            }

            replyService.add(reply, function(result){
               modal.find("input").val("");
               modal.modal("hide");

               // 댓글 리스트 새로고침
               // showList(1);
               showList(pageNum);
            });
        });

        // 댓글 항목 클릭 이벤트
        $(".chat").on("click", "li", function() {
            var rno = $(this).data("rno");

            replyService.get(rno, function(reply) {
                modalInputReply.val(reply.reply);
                modalInputReplyer.val(reply.replyer);
                modalInputRegDate.val(replyService.displayTime(reply.regDate)).attr("readonly", "readonly");
                modal.data("rno", reply.rno);

                // closest() -> 가장 가까이에 있는 부모 태그 선택
                modalInputRegDate.closest("div").show();
                modal.find("button[id != 'modalCloseBtn']").hide();  // 닫기 버튼 이외 모든 버튼 숨기기
                modalModBtn.show();     // 수정 버튼 보이게 하기
                modalRemoveBtn.show();  // 삭제 버튼 보이게 하기

                modal.modal("show");
            });
        });

        // 댓글 수정 버튼 클릭 이벤트
        modalModBtn.on("click", function() {
           var reply = {
               rno: modal.data("rno"),
               reply: modalInputReply.val(),
               replyer: modalInputReplyer.val()
           }
           replyService.update(reply, function(result){
              modal.modal("hide");
              showList(pageNum);
           });
        });

        // 댓글 삭제 버튼 클릭 이벤트
        modalRemoveBtn.on("click", function() {
            var rno = modal.data("rno");

            if(!confirm("정말 삭제하시겠습니까?")) {
                return false;
            }

            replyService.remove(rno, function(result){
                modal.modal("hide");
                showList(pageNum);
            });
        });
    });
</script>

<%@ include file="../includes/footer.jsp" %>









