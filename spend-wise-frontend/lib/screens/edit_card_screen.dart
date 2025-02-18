import 'package:flutter/material.dart';
import '../services/api_service.dart';

class EditCardScreen extends StatefulWidget {
  final String cardId;
  final String cardName;
  final double balance;

  EditCardScreen({required this.cardId, required this.cardName, required this.balance});

  @override
  _EditCardScreenState createState() => _EditCardScreenState();
}

class _EditCardScreenState extends State<EditCardScreen> {
  late TextEditingController _cardNameController;
  late TextEditingController _balanceController;

  @override
  void initState() {
    super.initState();
    _cardNameController = TextEditingController(text: widget.cardName);
    _balanceController = TextEditingController(text: widget.balance.toString());
  }

  Future<void> _updateCard() async {
    double balance = double.tryParse(_balanceController.text) ?? 0.0;

    bool success = await ApiService.updateCard(widget.cardId, _cardNameController.text, balance);
    if (success) {
      Navigator.pop(context, true); // Return success response
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to update card"))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Cash Card")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _cardNameController, decoration: InputDecoration(labelText: "Card Name")),
            TextField(controller: _balanceController, decoration: InputDecoration(labelText: "Balance"), keyboardType: TextInputType.number),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _updateCard, child: Text("Update Card"))
          ],
        ),
      ),
    );
  }
}
