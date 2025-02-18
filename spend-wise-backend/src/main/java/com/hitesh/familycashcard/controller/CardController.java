package com.hitesh.familycashcard.controller;

import com.hitesh.familycashcard.model.CardModel;
import com.hitesh.familycashcard.service.CardService;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@CrossOrigin(origins = "*")
public class CardController {

    @Autowired
    private CardService cardService;

    @GetMapping("/cards")
    public ResponseEntity<?> getAllCards() {
        List<CardModel> cards = cardService.findAll();
        if(cards.isEmpty())
            return new ResponseEntity<>("No Cards to display", HttpStatus.NOT_FOUND);
        else
            return new ResponseEntity<>(cards, HttpStatus.OK);
    }

    @PostMapping("/addCard")
    public ResponseEntity<?> save(@Valid @RequestBody CardModel cardModel){

        if(cardModel.getCardName()==null || cardModel.getCardName().isEmpty())
            return ResponseEntity.badRequest().body("Card Name cannot be null");
        if(cardModel.getBalance()<0)
            return ResponseEntity.badRequest().body("Card Balance cant be negative");
        CardModel savedCard = cardService.save(cardModel);
//        cardModel.setId(savedCard.getId());
//        return new ResponseEntity<>("Card details created successfully " +savedCard ,HttpStatus.CREATED);
        return ResponseEntity.status(HttpStatus.CREATED).body(savedCard);
    }

    @GetMapping("/card/{id}")
    public ResponseEntity<?> getCardById(@PathVariable String id){
        Optional<CardModel> card= cardService.findById(id);
        if(card.isEmpty()){
            return new ResponseEntity<>(" Card with id "+id+ " is not available to display", HttpStatus.NOT_FOUND);
        }
        else{
            return  new ResponseEntity<>(card.get() ,HttpStatus.OK);
        }
    }

    @PutMapping("/updateCard/{id}")
    public ResponseEntity<?> updateById(@PathVariable String id, @RequestBody CardModel card){
        Optional<CardModel> existingCard = cardService.findById(id);

        if (existingCard.isPresent()) {
            CardModel updatedCard = existingCard.get();
            updatedCard.setCardName(card.getCardName());
            updatedCard.setBalance(card.getBalance());

            cardService.save(updatedCard); // ✅ Updates instead of creating a new card
            return ResponseEntity.ok(updatedCard); // ✅ Returns 200 OK with updated data
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Card not found");
        }
    }

    @DeleteMapping("/deleteCard/{id}")
    public ResponseEntity<?> deleteById(@PathVariable String id){
        cardService.deleteById(id);
        return ResponseEntity.noContent().build();
    }







}

