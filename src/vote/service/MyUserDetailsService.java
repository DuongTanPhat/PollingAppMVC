package vote.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vote.controller.WelcomeController;
import vote.entity.Users;

@Service
public class MyUserDetailsService implements UserDetailsService {
  @Autowired
  private WelcomeController userDAO;
  @Override
  @Transactional(readOnly = true)
  public UserDetails loadUserByUsername(final String email) throws UsernameNotFoundException {
    Users user = userDAO.loadUserByEmail(email);
    if (user == null) {
      return null;
    }
    return new MyUserDetails(user);
  }
}
