package org.vemm8ks2.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
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
		
		log.info("list: " + cri);
		
		int total = service.getTotal(cri);
		
		log.info("total: " + total);
		
		model.addAttribute("list", service.getList(cri));
		model.addAttribute("pageMaker", new PageDTO(cri, total));
	}
	
	@GetMapping("/register")
	public void register() {
		
	}
	
	@PostMapping("/register")
	public String register(BoardVO board, RedirectAttributes attr) {
		
		log.info("register: " + board);
		
		service.register(board);
		
		attr.addFlashAttribute("result", board.getBno());
		
		return "redirect:/board/list";
	}
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno,
					@ModelAttribute("cri") Criteria cri,
					Model model) {

		log.info("/get or /modify");
		
		model.addAttribute("board", service.get(bno));
	}
	
	@PostMapping("/modify")
	public String modify(BoardVO board, 
						 @ModelAttribute("cri") Criteria cri, 
						 RedirectAttributes attr) {
		
		log.info("modify: " + board);
		
		if (service.modify(board)) {
			attr.addFlashAttribute("result", "success");
		}
		
		attr.addAttribute("pageNum", cri.getPageNum());
		attr.addAttribute("amount", cri.getAmount());
		attr.addAttribute("type", cri.getType());
		attr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	public String remove(@RequestParam("bno") Long bno, 
						 @ModelAttribute("cri") Criteria cri, 
						 RedirectAttributes attr) {
		
		log.info("remove ... " + bno);
		
		if (service.remove(bno)) {
			attr.addFlashAttribute("result", "success");
		}
		
		attr.addAttribute("pageNum", cri.getPageNum());
		attr.addAttribute("amount", cri.getAmount());
		attr.addAttribute("type", cri.getType());
		attr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}
}
