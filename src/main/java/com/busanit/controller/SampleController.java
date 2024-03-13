package com.busanit.controller;

import com.busanit.domain.SampleVO;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/sample")
public class SampleController {

    @GetMapping(value = "/getText", produces = "text/plain; charset=UTF-8")
    public String getText() {

        return "안녕하세요?";
    }

    // http://localhost:8080/sample/getText2/3/2
    @GetMapping("/getText2/{bno}/{page}")
    public String getText2(@PathVariable("bno") int bno, @PathVariable("page") int page) {

        return "안녕하세요? bno=" + bno + " page=" + page;
    }

    @GetMapping(value="/getSample", produces = { MediaType.APPLICATION_JSON_VALUE,
                                                    MediaType.APPLICATION_XML_VALUE })
    public SampleVO getSample() {
        return new SampleVO(112, "길동", "홍");
    }

    @GetMapping(value = "/check", params = {"height", "weight"})
    public ResponseEntity<SampleVO> check(Double height, Double weight) {
        SampleVO vo = new SampleVO(0, "" + height, "" + weight);

        ResponseEntity<SampleVO> result = null;

        if(height < 150) {
            // BAD_GATEWAY - 502
            result = ResponseEntity.status(HttpStatus.BAD_GATEWAY).body(vo);
        } else {
            // OK - 200
            result = ResponseEntity.status(HttpStatus.OK).body(vo);
        }

        return result;
    }

    @PostMapping("/getSample2")
    public SampleVO getSample2(@RequestBody SampleVO sampleVO) {

        return sampleVO;
    }
}
