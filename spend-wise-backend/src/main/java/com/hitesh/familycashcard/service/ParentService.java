package com.hitesh.familycashcard.service;

import com.hitesh.familycashcard.model.ParentModel;
import com.hitesh.familycashcard.repository.ParentRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class ParentService {

    @Autowired
    private ParentRepo parentRepo;

    @Autowired
    private PasswordEncoder passwordEncoder;

    public Optional<ParentModel> getParentById(String id) {
        return parentRepo.findById(id);
    }

    public ParentModel register(ParentModel parent) {
        if(parentRepo.findByParentEmail(parent.getParentEmail()).isPresent())
            throw new IllegalArgumentException("Email id is already registered please try logging in");

        parent.setParentPassword(passwordEncoder.encode(parent.getParentPassword()));
        return parentRepo.save(parent);
    }

}

