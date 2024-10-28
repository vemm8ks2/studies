package org.vemm8ks2.service;

import java.util.List;
import org.vemm8ks2.domain.Criteria;
import org.vemm8ks2.domain.ReplyVO;

public interface ReplyService {
  
  public int register(ReplyVO vo);
  
  public ReplyVO get(Long rno);
  
  public int modify(ReplyVO vo);
  
  public int remove(Long rno);
  
  public List<ReplyVO> getList(Criteria cri, Long bno);
}
