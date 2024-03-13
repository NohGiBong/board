<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@include file="../includes/header.jsp" %>

            <!-- Begin Page Content -->
            <div class="container-fluid">

                <!-- Page Heading -->
                <h1 class="h3 mb-2 text-gray-800">Tables</h1>
                <p class="mb-4">DataTables is a third party plugin that is used to generate the demo table below.
                    For more information about DataTables, please visit the <a target="_blank"
                                                                               href="https://datatables.net">official DataTables documentation</a>.</p>

                <!-- DataTales Example -->
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">DataTables Example
                            <button type="button" class="btn btn-xs btn-info fa-pull-right"
                                onclick="location.href='/board/register'">등록</button>
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered" id="dataTable" width="100%" cellspacing="0">
                                <thead>
                                <tr>
                                    <th>#번호</th>
                                    <th>제목</th>
                                    <th>작성자</th>
                                    <th>작성일</th>
                                    <th>수정일</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="board" items="${list}">
                                    <tr>
                                        <td>${board.bno}</td>
                                        <td>
                                            <a class="move" href="${board.bno}">
                                                    ${board.title}<b>[${board.replyCnt}]</b>
                                            </a>
                                        </td>
                                        <td>${board.writer}</td>
                                        <td>
                                            <fmt:formatDate pattern="yyyy-MM-dd"
                                                            value="${board.regdate}" />
                                        </td>
                                        <td>
                                            <fmt:formatDate pattern="yyyy-MM-dd"
                                                            value="${board.updateDate}" />
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <!-- 검색 추가 -->
                            <div class="row">
                                <div class="col-lg-12">
                                <form id="searchForm" action="/board/list">
                                    <input type="hidden" name="pageNum" value="${pageMaker.paging.pageNum}">
                                    <input type="hidden" name="amount" value="${pageMaker.paging.amount}">
                                    <select name="type">
                                        <option value=""
                                                <c:out value="${pageMaker.paging.type == null ? 'selected' : ''}"/>>--</option>
                                        <option value="T"
                                                <c:out value="${pageMaker.paging.type == 'T' ? 'selected' : ''}"/>>제목</option>
                                        <option value="C"
                                                <c:out value="${pageMaker.paging.type == 'C' ? 'selected' : ''}"/>>내용</option>
                                        <option value="W"
                                                <c:out value="${pageMaker.paging.type == 'W' ? 'selected' : ''}"/>>작성자</option>
                                        <option value="TC"
                                                <c:out value="${pageMaker.paging.type == 'TC' ? 'selected' : ''}"/>>제목 or 내용</option>
                                        <option value="TW"
                                                <c:out value="${pageMaker.paging.type == 'TW' ? 'selected' : ''}"/>>제목 or 작성자</option>
                                        <option value="TCW"
                                                <c:out value="${pageMaker.paging.type == 'TCW' ? 'selected' : ''}"/>>제목 or 내용 or 작성자</option>
                                    </select>
                                    <input type="text" name="keyword" value="${pageMaker.paging.keyword}">
                                    <button class="btn btn-primary">Search</button>
                                </form>
                                </div>
                            </div>

                            <!-- paging 추가 -->
                            <div class="fa-pull-right">
                                <ul class="pagination justify-content-center">
                                    <c:if test="${pageMaker.prev}">
                                    <li class="paginate_button page-item previous" id="dataTable_previous">
                                        <a href="${pageMaker.startPage - 1}" aria-controls="dataTable" data-dt-idx="0"
                                           tabindex="0" class="page-link">Previous</a>
                                    </li>
                                    </c:if>

                                    <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                                        <li class="paginate_button page-item ${pageMaker.paging.pageNum == num ? "active" : "" }">
                                            <a href ="${num}" aria-controls="dataTable" data-dt-idx="${num}" tabindex="0" class="page-link">${num}</a>
                                        </li>
                                    </c:forEach>

                                    <c:if test="${pageMaker.next}">
                                        <li class="paginate_button page-item next" id="dataTable_next">
                                            <a href="${pageMaker.endPage + 1}" aria-controls="dataTable" data-dt-idx="${pageMaker.endPage}"
                                               tabindex="0" class="page-link">Next</a>
                                        </li>
                                    </c:if>
                                </ul>
                            </div>

                            <!-- 페이징 이동 form -->
                            <form id="actionForm" action="/board/list">
                                <input type="hidden" name="bno">
                                <input type="hidden" name="pageNum" value="${pageMaker.paging.pageNum}">
                                <input type="hidden" name="amount" value="${pageMaker.paging.amount}">
                                <input type="hidden" name="type" value="${pageMaker.paging.type}">
                                <input type="hidden" name="keyword" value="${pageMaker.paging.keyword}">
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Modal 추가 -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
                     aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title" id="myModalLabel">Board Register</h4>
                                <button type="button" class="close" data-dismiss="modal"
                                        aria-hidden="true">&times;</button>
                            </div>
                            <div class="modal-body">처리가 완료되었습니다.</div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default" data-dismiss="modal">
                                    Close</button>
                            </div>
                        </div>
                        <!--  /.modal-content -->
                    </div>
                    <!--  /.modal-dialog -->
                </div>
                <!--  /.modal -->

            </div>
            <!-- /.container-fluid -->

<script>
    $(document).ready(function(){
       let result = "${result}";

        checkModal(result);

       function checkModal(result) {
           if(result === '') {  // 게시글 번호(bno)가 빈값이면 종료
               return;
           }

           if(parseInt(result) > 0) {   // 게시글 번호(bno) 값이 있으면 modal-body에 출력
               $(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다.");
           }

           $("#myModal").modal("show");
       }

       var actionForm = $("#actionForm");

       $(".paginate_button a").on("click", function(e){
           e.preventDefault();

           actionForm.attr("action", "/board/list");
           actionForm.find("input[name='pageNum']").val($(this).attr("href"))
           actionForm.submit();
       });

       $(".move").on("click", function(e) {
          e.preventDefault();

          $("input[name=bno]").val($(this).attr("href"));
          actionForm.attr("action", "/board/get");
          actionForm.submit();
       });

       // 검색 처리 ----------------------------------------------------
       var searchForm = $("#searchForm");

       $("#searchForm button").on("click", function(e){
          // if(!searchForm.find("option:selected").val()) {
          //     alert("검색종류를 선택하세요.");
          //     return false;
          // }

          // if(!searchForm.find("input[name=keyword]").val()) {
          //     alert("키워드를 입력하세요.");
          //     return false;
          // }
          // 검색 후 페이지 번호를 1로 하도록
          searchForm.find("input[name=pageNum]").val("1");
          e.preventDefault();

          searchForm.submit();
       });
    });
</script>

<%@include file="../includes/footer.jsp" %>








