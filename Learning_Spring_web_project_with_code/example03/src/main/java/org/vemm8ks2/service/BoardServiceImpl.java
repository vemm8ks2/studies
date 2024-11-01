package org.vemm8ks2.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.vemm8ks2.domain.BoardAttachVO;
import org.vemm8ks2.domain.BoardVO;
import org.vemm8ks2.domain.Criteria;
import org.vemm8ks2.mapper.BoardAttachMapper;
import org.vemm8ks2.mapper.BoardMapper;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class BoardServiceImpl implements BoardService {

    @Autowired
	private BoardMapper mapper;
    
    @Autowired
	private BoardAttachMapper attachMapper;

    @Transactional
	@Override
	public void register(BoardVO board) {

		log.info("|| --- register: " + board);
		
		mapper.insertSelectKey(board);
		
		if (board.getAttachList() == null || board.getAttachList().size() <= 0) {
		  return;
		}
		
		board.getAttachList().forEach(attach -> {
		  attach.setBno(board.getBno());
		  attachMapper.insert(attach);
		});
	}

	@Override
	public BoardVO get(Long bno) {

		log.info("|| --- get ...");
		
		return mapper.read(bno);
	}

	@Override
	public boolean modify(BoardVO board) {

		log.info("modify ... " + board);
		
		return mapper.update(board) == 1;
	}

	@Transactional
	@Override
	public boolean remove(Long bno) {

		log.info("|| --- remove ... " + bno);
		
		attachMapper.deleteAll(bno);
		
		return mapper.delete(bno) == 1;
	}

	@Override
	public List<BoardVO> getList(Criteria cri) {

		log.info("getList with criteria: " + cri);
		
		return mapper.getListWithPaging(cri);
	}

	@Override
	public int getTotal(Criteria cri) {

		log.info("get total count");
		
		return mapper.getTotalCount(cri);
	}

  @Override
  public List<BoardAttachVO> getAttachList(Long bno) {

    log.info("|| --- get attach list by bno: " + bno);
    
    return attachMapper.findByBno(bno);
  }
	
}
