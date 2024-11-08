package org.vemm8ks2.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.vemm8ks2.domain.MemberVO;
import org.vemm8ks2.mapper.MemberMapper;
import org.vemm8ks2.security.domain.CustomUser;
import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

  @Autowired
  private MemberMapper memberMapper;

  @Override
  public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

    log.warn("|| --- Load User By Username : " + username);

    // username means userid
    MemberVO vo = memberMapper.read(username);

    log.warn("|| --- Queried by member mapper : " + vo);

    return vo == null ? null : new CustomUser(vo);
  }

}
