package org.vemm8ks2.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.vemm8ks2.domain.BoardAttachVO;
import org.vemm8ks2.domain.BoardVO;
import org.vemm8ks2.domain.Criteria;
import org.vemm8ks2.domain.PageDTO;
import org.vemm8ks2.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {

  private BoardService service;

  @GetMapping("/list")
  public void list(Criteria cri, Model model) {

    log.info("|| --- list: " + cri);

    int total = service.getTotal(cri);

    log.info("|| --- total: " + total);

    model.addAttribute("list", service.getList(cri));
    model.addAttribute("pageMaker", new PageDTO(cri, total));
  }

  @GetMapping("/register")
  public void register() {

  }

  @PostMapping("/register")
  public String register(BoardVO board, RedirectAttributes attr) {

    log.info("||");
    log.info("|| --- register: " + board);

    if (board.getAttachList() != null) {
      board.getAttachList().forEach(attach -> log.info("|| --- " + attach));
    }

    log.info("||");

    service.register(board);

    attr.addFlashAttribute("result", board.getBno());

    return "redirect:/board/list";
  }

  @GetMapping({"/get", "/modify"})
  public void get(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri, Model model) {

    log.info("|| --- /get or /modify");

    model.addAttribute("board", service.get(bno));
  }

  @PostMapping("/modify")
  public String modify(BoardVO board, @ModelAttribute("cri") Criteria cri,
      RedirectAttributes attr) {

    log.info("|| --- modify: " + board);

    if (service.modify(board)) {
      attr.addFlashAttribute("result", "success");
    }

    return "redirect:/board/list" + cri.getListLink();
  }

  @PostMapping("/remove")
  public String remove(@RequestParam("bno") Long bno, @ModelAttribute("cri") Criteria cri,
      RedirectAttributes attr) {

    log.info("|| --- remove ... " + bno);
    
    List<BoardAttachVO> attachList = service.getAttachList(bno);

    if (service.remove(bno)) {
      // delete Attach Files
      deleteFiles(attachList);
      attr.addFlashAttribute("result", "success");
    }

    return "redirect:/board/list" + cri.getListLink();
  }

  @GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
  public ResponseEntity<List<BoardAttachVO>> getAttachList(Long bno) {

    log.info("|| --- getAttachList " + bno);

    return new ResponseEntity<>(service.getAttachList(bno), HttpStatus.OK);
  }

  private void deleteFiles(List<BoardAttachVO> attachList) {

    if (attachList == null || attachList.size() == 0) {
      return;
    }

    log.info("|| --- delete attach files ...");
    log.info("|| --- " + attachList);

    attachList.forEach(attach -> {
      try {
        Path file = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\" + attach.getUuid()
            + "_" + attach.getFileName());

        Files.deleteIfExists(file);

        if (Files.probeContentType(file).startsWith("image")) {
          Path thumbnail = Paths.get("C:\\upload\\" + attach.getUploadPath() + "\\s_"
              + attach.getUuid() + "_" + attach.getFileName());

          Files.delete(thumbnail);
        }
      } catch (Exception e) {
        log.error("|| --- delete file error: " + e.getMessage());
      }
    });
  }
}
