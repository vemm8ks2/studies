package org.vemm8ks2.mapper;

import java.util.stream.IntStream;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.vemm8ks2.domain.ReplyVO;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

  @Autowired
  private ReplyMapper mapper;
  
  private Long[] bnoArr = { 524312L, 524311L, 524310L, 524309L, 524308L }; 

  @Test
  public void testMapper() {
    
    log.info(mapper);
  }
  
  @Test
  public void testCreate() {
    
    IntStream.rangeClosed(1, 10).forEach(i -> {
      
      ReplyVO vo = new ReplyVO();
      
      vo.setBno(bnoArr[i % 5]);
      vo.setReply("´ñƒJ Å×½ºÆ® " + i);
      vo.setReplyer("replyer " + i);
      
      mapper.insert(vo);
    });
  }
  
  @Test
  public void testRead() {
    
    Long targetRno = 5L;
    
    ReplyVO vo = mapper.read(targetRno);
    
    log.info(vo);
  }
}
