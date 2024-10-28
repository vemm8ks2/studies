package org.vemm8ks2.mapper;

import org.vemm8ks2.domain.ReplyVO;

public interface ReplyMapper {

  public int insert(ReplyVO vo);
  
  public ReplyVO read(Long rno); // 특정 댓글 읽기
}
