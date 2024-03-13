package com.busanit.controller;

import com.busanit.domain.BoardAttachVO;
import com.busanit.domain.BoardVO;
import com.busanit.domain.PageDTO;
import com.busanit.domain.PagingHandler;
import com.busanit.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequestMapping("/board/*")
@RequiredArgsConstructor
public class BoardController {

    private final BoardService boardService;

    @GetMapping("/list")
    public void list(PagingHandler paging, Model model) {
        // model.addAttribute("list", boardService.getList());
        model.addAttribute("list", boardService.getList(paging));

        int total = boardService.getTotal(paging);

        model.addAttribute("pageMaker", new PageDTO(paging, total));
    }

    @GetMapping("/register")
    public void register() {}

    @PostMapping("/register")
    public String register(BoardVO board, RedirectAttributes rttr) {
        System.out.println("===================");

        if(board.getAttachList() != null) {
            board.getAttachList().forEach(attach -> System.out.println(attach));
        }
        System.out.println("===================");

        boardService.register(board);

        rttr.addFlashAttribute("result", board.getBno());

        return "redirect:/board/list";
    }

    @GetMapping({"/get", "/modify"})
    public void get(Long bno, @ModelAttribute("paging") PagingHandler paging, Model model) {
        model.addAttribute("board", boardService.get(bno));
    }

    @PostMapping("/modify")
    public String modify(BoardVO board, @ModelAttribute("paging") PagingHandler paging,
                         RedirectAttributes rttr) {
        if(boardService.modify(board)) {
            rttr.addFlashAttribute("result", "success");
        }

        return "redirect:/board/list" + paging.getListLink();
    }

    @PostMapping("/remove")
    public String remove(Long bno, @ModelAttribute("paging") PagingHandler paging,
                         RedirectAttributes rttr) {

        // 첨부 파일 리스트 조회
        List<BoardAttachVO> attachList = boardService.getAttachlist(bno.intValue());


        // 삭제 처리 성공 시
        if(boardService.remove(bno)) {
            // DB에서 삭제 성공 시 실제 파일도 삭제 진행
            deleteFiles(attachList);

            rttr.addFlashAttribute("result", "success");
        }

        return "redirect:/board/list" + paging.getListLink();
    }

    // 첨부 파일 리스트 조회
    @GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<BoardAttachVO>> getAttachList(int bno) {
        return new ResponseEntity<>(boardService.getAttachlist(bno), HttpStatus.OK);
    }

    private void deleteFiles(List<BoardAttachVO> attachlist) {
        if(attachlist == null || attachlist.size() == 0) {
            return;
        }

        attachlist.forEach(attach -> {
            try {
                Path file = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\" +
                        attach.getUuid() + "_" + attach.getFileName());

                // 실제 파일 삭제
                Files.deleteIfExists(file);

                // 파일 타입이 이미지일 경우 썸네일 파일도 같이 삭제
                if(Files.probeContentType(file).startsWith("image")) {
                    Path thumbnail = Paths.get("C:\\upload\\" + attach.getUploadPath() +
                            "\\s_" + attach.getUuid() + "_" + attach.getFileName());

                    // 실제 썸네일 파일 삭제
                    Files.delete(thumbnail);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
    }
}














