import 'package:flutter/material.dart';
import '../services/api_service.dart';

class DeleteCardScreen extends StatelessWidget {
  final String cardId;
  final String cardName;

  DeleteCardScreen({required this.cardId, required this.cardName});

  Future<void> _deleteCard(BuildContext context) async {
    bool success = await ApiService.deleteCard(cardId);
    if (success) {
      Navigator.pop(context, true); // Return success response
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to delete card")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete Card"),
      content: Text("Are you sure you want to delete the card '$cardName'?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false), // Cancel
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () => _deleteCard(context), // Confirm Delete
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          child: Text("Delete"),
        ),
      ],
    );
  }
}
