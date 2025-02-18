package com.hitesh.familycashcard.repository;

import com.hitesh.familycashcard.model.ParentModel;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.Optional;

public interface ParentRepo extends MongoRepository<ParentModel,String> {
    Optional<ParentModel> findByParentEmail(String parentEmail);
}
