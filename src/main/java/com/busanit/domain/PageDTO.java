package com.busanit.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {

    private int startPage;      // (화면에 보여지는) 시작 페이지번호
    private int endPage;        // (화면에 보여지는) 끝 페이지번호
    private boolean prev, next; // 이전과 다음으로 이동 가능한 링크의 표시 여부

    private int total;          // 전체 데이터 수
    private PagingHandler paging;

    public PageDTO(PagingHandler paging, int total) {
        this.paging = paging;
        this.total = total;

        /*
            끝 페이지 번호 계산
            this.endPage = (int)(Math.ceil(페이지번호 / 10.0)) * 10;
            Math.ceil()은 소수점을 올림으로 처리
            1페이지의 경우: Math.ceil(0.1) * 10 = 10
            10페이지의 경우: Math.ceil(1) * 10 = 10
            11페이지의 경우: Math.ceil(1.1) * 10 = 20
         */
        this.endPage = (int) (Math.ceil(paging.getPageNum() / (double)paging.getAmount())) * paging.getAmount();

        /*
            시작 페이지 번호 계산
         */
        this.startPage = (paging.getPageNum() - 1) / paging.getAmount() * paging.getAmount() + 1;

        // 실제 끝 페이지
        // 전체 데이터 수가 80개라고 하면 endPage는 10이 아닌 8이 되어야함
        int realEnd = (int) (Math.ceil((total * 1.0) / paging.getAmount()));
        if(realEnd < this.endPage) {
            this.endPage = realEnd;
        }

        // prev 표시 여부 - startPage가 1보다 큰 경우 존재
        this.prev = this.startPage > 1;

        // next 표시 여부 - realEnd가 endPage보다 큰 경우에만 존재
        this.next = this.endPage < realEnd;

    }
}





