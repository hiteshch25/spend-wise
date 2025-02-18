import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddCardScreen extends StatefulWidget {
  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _addCard() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    if (_cardNameController.text.isEmpty || _balanceController.text.isEmpty) {
      setState(() {
        _errorMessage = "All fields are required!";
        _isLoading = false;
      });
      return;
    }

    double? balance = double.tryParse(_balanceController.text);
    if (balance == null || balance < 0) {
      setState(() {
        _errorMessage = "Balance must be a positive number!";
        _isLoading = false;
      });
      return;
    }

    bool success = await ApiService.addCard(_cardNameController.text, balance);
    if (success) {
      Navigator.pop(context, true);
    } else {
      setState(() {
        _errorMessage = "Failed to add card. Please try again.";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Family Cash Card")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cardNameController,
              decoration: InputDecoration(
                labelText: "Card Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _balanceController,
              decoration: InputDecoration(
                labelText: "Balance",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 14),
              ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: _isLoading ? null : _addCard,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text("Add Card", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
