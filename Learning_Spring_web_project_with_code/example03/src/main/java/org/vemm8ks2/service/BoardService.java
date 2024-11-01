package org.vemm8ks2.service;

import java.util.List;
import org.vemm8ks2.domain.BoardAttachVO;
import org.vemm8ks2.domain.BoardVO;
import org.vemm8ks2.domain.Criteria;

public interface BoardService {

	public void register(BoardVO board);
	
	public BoardVO get(Long bno);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long bno);
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
	
	public List<BoardAttachVO> getAttachList(Long bno); 
}
