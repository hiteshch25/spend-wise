package com.hitesh.familycashcard.model;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Document(collection = "CashCard")
public class CardModel {

    @Id
    private String id;
//    @JsonProperty("cardName")
    @NotBlank(message = "card name cannot be empty")
    private String cardName;
//    @JsonProperty("balance")
    @NotNull(message= "balance cannot be null")
    private double balance;
    private ParentModel parentModel;


    @Override
    public String toString() {
        return "CardModel{" +
                "id='" + id + '\'' +
                ", cardName='" + cardName + '\'' +
                ", balance=" + balance +
                '}';
    }


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCardName() {
        return cardName;
    }

    public void setCardName(String cardName) {
        this.cardName = cardName;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }
}
