package com.busanit.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.web.util.UriComponentsBuilder;

@Getter
@Setter
@ToString
public class PagingHandler {

    private int pageNum;        // 페이지번호
    private int amount;         // 한 페이지에 보여질 데이터 수

    private String type;        // 검색 유형
    private String keyword;     // 검색어

    public int getOffset() {
        return (this.pageNum - 1) * this.amount;
    }

    public PagingHandler() {
        this(1, 10);
    }

    public PagingHandler(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    // T - Title 검색
    // C - Content 검색
    // TC - Title + Content 검색
    public String[] getTypeArr() {
        // TC -> {"T", "C"}
        return type == null ? new String[]{} : type.split("");
    }

    // web.util.UriComponentsBuilder
    // 여러 개의 파라미터들을 연결해서 URL 형태로 만들어줌
    // GET 방식에 적합한 URL을 인코딩된 결과로 만들어줌(한글 처리에 신경쓰지 않아도 됨)
    public String getListLink() {

        UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
                .queryParam("pageNum", this.pageNum)
                .queryParam("amount", this.getAmount())
                .queryParam("type", this.getType())
                .queryParam("keyword", this.getKeyword());

        return builder.toUriString();
    }

}







