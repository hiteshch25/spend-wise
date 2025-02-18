import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_service.dart';
import '../providers/theme_provider.dart';
import '../screens/add_card_screen.dart';
import '../screens/edit_card_screen.dart';
import '../screens/delete_card_screen.dart';
import '../widgets/card_widget.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Map<String, dynamic>> _cards = [];

  @override
  void initState() {
    super.initState();
    loadCards(); // ✅ Fetch cards when the screen loads
  }

  Future<void> loadCards() async {
    List<dynamic> fetchedCards = await ApiService.fetchCards();
    setState(() {
      _cards = List<Map<String, dynamic>>.from(fetchedCards);
    });
  }

  Future<void> _addCard() async {
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCardScreen()),
    );

    if (result == true) {
      loadCards(); // ✅ Reload cards after adding one
    }
  }

  Future<void> _editCard(String cardId, String cardName, double balance) async {
    bool? result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditCardScreen(
          cardId: cardId,
          cardName: cardName,
          balance: balance,
        ),
      ),
    );

    if (result == true) {
      await loadCards(); // ✅ Refresh cards after updating
    }
  }


  Future<void> _deleteCard(String cardId, String cardName) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) => DeleteCardScreen(cardId: cardId, cardName: cardName),
    );

    if (result == true) {
      loadCards(); // ✅ Reload cards after deleting one
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // ✅ Access Theme Provider

    return Scaffold(
      appBar: AppBar(
        title: Text("Family Cash Cards"),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme(); // ✅ Toggle between dark & light mode
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCard, // ✅ Calls function to add card
        child: Icon(Icons.add),
      ),
      body: _cards.isEmpty
          ? Center(child: Text("No Cards Available"))
          : ListView.builder(
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          return CardWidget(
            cardName: _cards[index]['cardName'],
            balance: _cards[index]['balance'],
            onEdit: () => _editCard(_cards[index]['id'], _cards[index]['cardName'], _cards[index]['balance']),
            onDelete: () => _deleteCard(_cards[index]['id'], _cards[index]['cardName']),
          );
        },
      ),
    );
  }
}
