package com.busanit.mapper;

import com.busanit.domain.BoardVO;
import com.busanit.domain.PagingHandler;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardMapper {

    // 게시글 리스트
    public List<BoardVO> getList();

    // 게시글 리스트(페이징)
    public List<BoardVO> getListWithPaging(PagingHandler paging);

    // 게시글 등록
    public void insert(BoardVO board);

    // 게시글 등록 후 pk값 얻기
    public void insertSelectKey(BoardVO board);

    // 게시글 상세
    public BoardVO read(Long bno);

    // 게시글 삭제
    public int delete(Long bno);

    // 게시글 수정
    public int update(BoardVO board);

    // 게시글 총 갯수
    public int getTotalCount(PagingHandler paging);

    public void updateReplyCnt(@Param("bno") int bno,
                               @Param("amount") int amount);

}









