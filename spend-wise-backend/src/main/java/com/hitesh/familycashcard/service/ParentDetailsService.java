package com.hitesh.familycashcard.service;

import com.hitesh.familycashcard.repository.ParentRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class ParentDetailsService implements UserDetailsService {

    @Autowired
    private ParentRepo parentRepo;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        return parentRepo.findByParentEmail(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found with email: "+ username));
    }
}
