package com.busanit.mapper;

import com.busanit.domain.BoardAttachVO;

import java.util.List;

public interface BoardAttachMapper {

    public void insert(BoardAttachVO vo);

    public void delete(String uuid);

    public void deleteAll(int bno);

    public List<BoardAttachVO> findByBno(int bno);
}
