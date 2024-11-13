package com.vemm8ks2.sbb.user;

import java.util.Optional;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import com.vemm8ks2.sbb.DataNotFoundException;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class UserService {

  private final PasswordEncoder passwordEncoder;
  private final UserRepository userRepository;

  public SiteUser create(String username, String email, String password) {

    SiteUser user = new SiteUser();

    user.setUsername(username);
    user.setEmail(email);
    user.setPassword(passwordEncoder.encode(password));

    userRepository.save(user);

    return user;
  }

  public SiteUser getUser(String username) {
    Optional<SiteUser> siteUser = userRepository.findByUsername(username);

    if (siteUser.isPresent()) {
      return siteUser.get();
    } else {
      throw new DataNotFoundException("siteuser not found");
    }
  }
}
