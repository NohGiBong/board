package com.busanit.domain;

import lombok.AllArgsConstructor;
import lombok.Data;

import java.util.List;

@Data
@AllArgsConstructor
public class ReplyPageDTO {
    private int replyCnt;       // 댓글 총 갯수
    private List<ReplyVO> list; // 댓글 리스트
}
