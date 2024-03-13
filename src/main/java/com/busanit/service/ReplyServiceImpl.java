package com.busanit.service;

import com.busanit.domain.PagingHandler;
import com.busanit.domain.ReplyPageDTO;
import com.busanit.domain.ReplyVO;
import com.busanit.mapper.BoardMapper;
import com.busanit.mapper.ReplyMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ReplyServiceImpl implements ReplyService {

    private final BoardMapper boardMapper;
    private final ReplyMapper mapper;

    @Transactional
    @Override
    public int register(ReplyVO vo) {

        boardMapper.updateReplyCnt(vo.getBno(), 1);

        return mapper.insert(vo);
    }

    @Override
    public ReplyVO get(int rno) {
        return mapper.read(rno);
    }

    @Override
    public int modify(ReplyVO vo) {
        return mapper.update(vo);
    }

    @Transactional
    @Override
    public int remove(int rno) {

        ReplyVO vo = mapper.read(rno);
        // 댓글 수 update
        boardMapper.updateReplyCnt(vo.getBno(), -1);

        return mapper.delete(rno);
    }

    @Override
    public List<ReplyVO> getList(PagingHandler paging, int bno) {

        return mapper.getListWithPaging(paging, bno);
    }

    public ReplyPageDTO getListPage(PagingHandler paging, int bno) {
        return new ReplyPageDTO(
                mapper.getCountByBno(bno),
                mapper.getListWithPaging(paging, bno)
        );
    }

}
