package org.vemm8ks2.mapper;

import java.util.List;
import java.util.stream.IntStream;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;
import org.vemm8ks2.domain.Criteria;
import org.vemm8ks2.domain.ReplyVO;
import lombok.extern.log4j.Log4j;

@RunWith(SpringRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReplyMapperTests {

  @Autowired
  private ReplyMapper mapper;

  private Long[] bnoArr = {524312L, 524311L, 524310L, 524309L, 524308L};

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

  @Test
  public void testDelete() {

    Long targetRno = 1L;

    mapper.delete(targetRno);
  }

  @Test
  public void testUpdate() {

    Long targetRno = 10L;

    ReplyVO vo = mapper.read(targetRno);

    vo.setReply("Update Reply");

    int count = mapper.update(vo);

    log.info("UPDATE COUNT: " + count);
  }
  
  @Test
  public void testList() {
    
    Criteria cri = new Criteria();
    
    List<ReplyVO> replies = mapper.getListWithPaging(cri, bnoArr[0]);
    
    replies.forEach(reply -> log.info(reply));
  }
  
  @Test
  public void testList2() {
    
    Criteria cri = new Criteria(2, 10);
    
    List<ReplyVO> replies = mapper.getListWithPaging(cri, 524312L);
    
    replies.forEach(reply -> log.info(reply));
  }
}
