package com.hitesh.familycashcard.repository;

import com.hitesh.familycashcard.model.CardModel;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CardRepo extends MongoRepository<CardModel, String> {

}
