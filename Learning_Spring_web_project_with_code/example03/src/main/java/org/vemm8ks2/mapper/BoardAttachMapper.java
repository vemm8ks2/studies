package org.vemm8ks2.mapper;

import java.util.List;
import org.vemm8ks2.domain.BoardAttachVO;

public interface BoardAttachMapper {

  public void insert(BoardAttachVO vo);
  
  public void delete(String uuid);
  
  public List<BoardAttachVO> findByBno(Long bno);
  
  public void deleteAll(Long bno);
}
