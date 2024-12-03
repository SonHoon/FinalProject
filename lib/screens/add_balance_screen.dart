import 'package:flutter/material.dart';  

class AddBalanceScreen extends StatelessWidget {  
  final Function(double, String, IconData) onAddBalance; // Callback to add balance  
  final TextEditingController amountController = TextEditingController();  
  final TextEditingController noteController = TextEditingController(); // Controller for the note  
  final IconData selectedIcon = Icons.money; // Fixed money icon  
  final double currentBalance; // Current balance  

  AddBalanceScreen({  
    super.key,  
    required this.onAddBalance,  
    required this.currentBalance, // Receive current balance  
  });  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: Text('Add Balance'),  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(16.0),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            Text(  
              'Current Balance: ${_formatAmount(currentBalance)}', // Display current balance  
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),  
            ),  
            SizedBox(height: 20), // Space between balance and input fields  
            Text(  
              '₱ ${amountController.text.isEmpty ? '0.00' : _formatAmount(double.tryParse(amountController.text) ?? 0)}',  
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),  
            ),  
            TextField(  
              controller: amountController,  
              decoration: InputDecoration(labelText: 'Amount'),  
              keyboardType: TextInputType.number,  
            ),  
            TextField(  
              controller: noteController,  
              decoration: InputDecoration(labelText: 'Note'), // Field for a note  
            ),  
            SizedBox(height: 20),  
            Center(  
              child: ElevatedButton(  
                onPressed: () {  
                  double amount = double.tryParse(amountController.text) ?? 0;  
                  String note = noteController.text; // Get the note  
                  if (amount > 0) {  
                    onAddBalance(amount, note, selectedIcon); // Use the money icon for balance  
                    Navigator.pop(context); // Go back to the home screen  
                  }  
                },  
                style: ElevatedButton.styleFrom(  
                  backgroundColor: Colors.pink,  
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),  
                  shape: RoundedRectangleBorder(  
                    borderRadius: BorderRadius.circular(30),  
                  ),  
                ),  
                child: Text('SAVE', style: TextStyle(color: Colors.white)),  
              ),  
            ),  
          ],  
        ),  
      ),  
    );  
  }  

  // Method to format the amount with a '+' sign  
  String _formatAmount(double amount) {  
    return (amount >= 0 ? '+' : '') + '₱' + amount.toStringAsFixed(2);  
  }  
}