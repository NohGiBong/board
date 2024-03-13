console.log("Reply Module!!!");

// 자바스크립트 모듈 패턴
// 관련 있는 함수들을 하나의 모듈처럼 묶음으로 구성하는 것을 의미
// 자바스크립트의 클로저를 이용하는 방법 중 하나

let replyService = (function(){

    function add(reply, callback, error) {
        // JSON.stringify() - JSON형식 -> string 타입으로 변환시킴(직렬화)
        // JSON.parse() - string 타입 -> JSON형식으로 변환시킴(역직렬화)
        // ex) { "mno" : 123, "name" : "hong" } -> { "mno" : "123", "name" : "hong" }
        $.ajax({
            type : 'post',
            url : '/replies/new',
            data : JSON.stringify(reply),
            contentType : 'application/json; charset=utf-8',
            success : function(result, status, xhr) {
                if(callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, err) {
                if(error) {
                    error(err);
                }
            }
        });
    }

    function getList(param, callback, error) {
        var bno = param.bno;
        var page = param.page || 1;

        $.getJSON("/replies/page/" + bno + "/" + page,
            function(data){
                if(callback) {
                    // callback(data);                      //댓글 목록만 가지고 오는 경우
                    callback(data.replyCnt, data.list);     // 댓글 숫자와 목록을 가져옴(페이징)
                }
            }).fail(function(xhr, status, err) {
                if(error) {
                    error(err);
                }
            });
    }

    function remove(rno, callback, error) {
        $.ajax({
           type : "delete",
           url : "/replies/" + rno,
           success : function(deleteResult, status, xhr) {
               if(callback) {
                   callback(deleteResult);
               }
           },
            error : function(xhr, status, err) {
               if(error) {
                   error(err);
               }
            }
        });
    }

    function update(reply, callback, error) {
        $.ajax({
            type : 'put',
            url : '/replies/' + reply.rno,
            data : JSON.stringify(reply),
            contentType : 'application/json; charset=utf-8',
            success : function(result, status, xhr) {
                if(callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, err) {
                if(error) {
                    error(err);
                }
            }
        });
    }

    function get(rno, callback, error) {
        $.get("/replies/" + rno, function(result){
           if(callback) {
               callback(result);
           }
        }).fail(function(xhr, status, err) {
            if(error) {
                error(err);
            }
        });
    }

    // 날짜 처리 - 24시간 이내 -> 시간 표시, 24시간 이후 -> 날짜 표시
    function displayTime(timeValue){
        var today = new Date();

        var gap = today.getTime() - timeValue;

        var dateObj = new Date(timeValue);
        var str = "";

        // 24시간이 지나지 않았으면 시간을 출력
        if(gap < (1000 * 60 * 60 * 24)) {
            var hh = dateObj.getHours();
            var mi = dateObj.getMinutes();
            var ss = dateObj.getSeconds();

            return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
                ':', (ss > 9 ? '' : '0') + ss ].join('');
        } else {	// 24시간이 지났으면 날짜를 출력
            var yy = dateObj.getFullYear();
            var mm = dateObj.getMonth() + 1;
            var dd = dateObj.getDate();

            return [ (yy > 9 ? '' : '0') + yy, '/', (mm > 9 ? '' : '0') + mm,
                '/', (dd > 9 ? '' : '0') + dd ].join('');
        }
    };

    return {
        add: add,
        getList: getList,
        remove: remove,
        update: update,
        get: get,
        displayTime: displayTime
    };
})();








