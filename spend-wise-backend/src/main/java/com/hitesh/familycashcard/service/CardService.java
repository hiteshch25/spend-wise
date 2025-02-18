package com.hitesh.familycashcard.service;

import com.hitesh.familycashcard.model.CardModel;
import com.hitesh.familycashcard.repository.CardRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CardService {
    @Autowired
    private CardRepo cardRepo;

    public CardModel save(CardModel card) {
        return cardRepo.save(card);
    }

    public List<CardModel> findAll() {
        return cardRepo.findAll();
    }

    public Optional<CardModel> findById(String id) {
        return cardRepo.findById(id);
    }

    public void deleteById(String id) {
        cardRepo.deleteById(id);
    }
}

