package com.busanit.service;


import com.busanit.domain.PagingHandler;
import com.busanit.domain.ReplyPageDTO;
import com.busanit.domain.ReplyVO;

import java.util.List;

public interface ReplyService {

    public int register(ReplyVO vo);

    public ReplyVO get(int rno);

    public int modify(ReplyVO vo);

    public int remove(int rno);

    public List<ReplyVO> getList(PagingHandler paging, int bno);

    public ReplyPageDTO getListPage(PagingHandler paging, int bno);
}
