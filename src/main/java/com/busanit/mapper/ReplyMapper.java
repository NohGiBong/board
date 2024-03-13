package com.busanit.mapper;

import com.busanit.domain.PagingHandler;
import com.busanit.domain.ReplyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReplyMapper {

    public int insert(ReplyVO vo);

    public ReplyVO read(int rno);

    public int delete(int rno);

    public int deleteAll(int bno);

    public int update(ReplyVO vo);

    // mybatis에서 두 개 이상의 데이터를 파리미터로 전달하기
    // 1. 별도의 객체로 구성
    // 2. Map을 이용하는 방식
    // 3. @Param을 이용해서 이름을 사용하는 방식
    public List<ReplyVO> getListWithPaging(
            @Param("paging")PagingHandler paging,
            @Param("bno") int bno);

    public int getCountByBno(int bno);

}





