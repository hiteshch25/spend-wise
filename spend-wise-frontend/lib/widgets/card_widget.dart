import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String cardName;
  final double balance;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  CardWidget({required this.cardName, required this.balance, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [Colors.redAccent, Colors.orangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  "Family Cash Card",
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
            Column(
              children: [
                Text("\$${balance.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                Row(
                  children: [
                    IconButton(icon: Icon(Icons.edit, color: Colors.white), onPressed: onEdit),
                    IconButton(icon: Icon(Icons.delete, color: Colors.white), onPressed: onDelete),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
