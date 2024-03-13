package com.busanit.service;

import com.busanit.domain.BoardAttachVO;
import com.busanit.domain.BoardVO;
import com.busanit.domain.PagingHandler;
import com.busanit.mapper.BoardAttachMapper;
import com.busanit.mapper.BoardMapper;
import com.busanit.mapper.ReplyMapper;
import lombok.AllArgsConstructor;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

    private BoardMapper boardMapper;
    private ReplyMapper replyMapper;
    private BoardAttachMapper attachMapper;

    @Override
//    public List<BoardVO> getList() {
//        return boardMapper.getList();
//    }
    public List<BoardVO> getList(PagingHandler paging) {
        return boardMapper.getListWithPaging(paging);
    }

    @Override
    public BoardVO get(Long bno) {
        return boardMapper.read(bno);
    }

    @Transactional
    @Override
    public void register(BoardVO board) {

        // tbl_board 테이블에 insert 진행 후
        boardMapper.insertSelectKey(board);

        if(board.getAttachList() == null || board.getAttachList().size() <= 0) {
            return;
        }

        // tbl_attach 테이블에 insert 진행
        board.getAttachList().forEach(attach -> {
            attach.setBno(board.getBno());
            attachMapper.insert(attach);
        });
    }

    @Transactional
    @Override
    public boolean modify(BoardVO board) {

        // DB - 기존 첨부 파일 데이터 모두 삭제 후 첨부 목록에 있는 것만 다시 등록
        // 기존 첨부 파일을 DB에서 삭제
        attachMapper.deleteAll(board.getBno());

        boolean modifyResult = boardMapper.update(board) == 1;

        // 첨부 파일이 있는 만큼 DB에 insert

        if(modifyResult && board.getAttachList() !=null && board.getAttachList() != null && board.getAttachList().size() > 0) {
            board.getAttachList().forEach(attach -> {
                attach.setBno(board.getBno());
                attachMapper.insert(attach);
            });
        }

        return modifyResult;
    }

    @Transactional
    @Override
    public boolean remove(Long bno) {

        // 해당 게시글 번호에 해당하는 댓글 DB에서 모두 삭제
        replyMapper.deleteAll(bno.intValue());

        // 해당 게시글 번호에 해당하는 첨부 파일을 DB에서 모두 삭제
        attachMapper.deleteAll(bno.intValue());

        return boardMapper.delete(bno) == 1;
    }

    @Override
    public int getTotal(PagingHandler paging) {
        return boardMapper.getTotalCount(paging);
    }

    // 첨부 파일 리스트 조회
    @Override
    public List<BoardAttachVO> getAttachlist(int bno) {
        return attachMapper.findByBno(bno);
    }
}



