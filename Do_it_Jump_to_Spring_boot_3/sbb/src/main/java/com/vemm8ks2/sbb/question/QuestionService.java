package com.vemm8ks2.sbb.question;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import org.springframework.stereotype.Service;
import com.vemm8ks2.sbb.DataNotFoundException;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class QuestionService {

  private final QuestionRepository questionRepository;

  public List<Question> getList() {
    return questionRepository.findAll();
  }

  public Question getQuestion(Integer id) {
    Optional<Question> question = questionRepository.findById(id);

    if (question.isPresent()) {
      return question.get();
    } else {
      throw new DataNotFoundException("question not found");
    }
  }
  
  public void create(String subject, String content) {
    Question q = new Question();
    
    q.setSubject(subject);
    q.setContent(content);
    q.setCreateDate(LocalDateTime.now());
    
    questionRepository.save(q);
  }
}
