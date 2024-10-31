package org.vemm8ks2.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.vemm8ks2.domain.BoardVO;
import org.vemm8ks2.domain.Criteria;

public interface BoardMapper {

  public List<BoardVO> getList();

  public List<BoardVO> getListWithPaging(Criteria cri);

  public int getTotalCount(Criteria cri);

  public void insert(BoardVO board);

  public void insertSelectKey(BoardVO board);

  public BoardVO read(Long bno);

  public int delete(Long bno);

  public int update(BoardVO board);

  public void updateReplyCnt(@Param("bno") Long bno, @Param("amount") int amount);
  
}
