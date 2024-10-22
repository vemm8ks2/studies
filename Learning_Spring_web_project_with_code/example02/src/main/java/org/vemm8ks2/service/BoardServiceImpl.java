package org.vemm8ks2.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.vemm8ks2.domain.BoardVO;
import org.vemm8ks2.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {

	// spring 4.3 이상에서 자동 처리
	private BoardMapper mapper;

	@Override
	public void register(BoardVO board) {

		log.info("register: " + board);
		
		mapper.insertSelectKey(board);
	}

	@Override
	public BoardVO get(Long bno) {

		log.info("get ...");
		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public boolean remove(Long bno) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<BoardVO> getList() {

		log.info("getList ...");
		
		return mapper.getList();
	}
	
}
