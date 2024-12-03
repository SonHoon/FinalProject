import 'package:flutter/material.dart';  

class AddExpenseScreen extends StatefulWidget {  
  final Function(double, String, String) onAddExpense; // Callback for adding expense  
  final double currentBalance; // Add current balance parameter  

  AddExpenseScreen({super.key, required this.onAddExpense, required this.currentBalance}); // Add callback and current balance in constructor  

  @override  
  _AddExpenseScreenState createState() => _AddExpenseScreenState();  
}  

class _AddExpenseScreenState extends State<AddExpenseScreen> {  
  final TextEditingController amountController = TextEditingController();  
  final TextEditingController noteController = TextEditingController();  
  String selectedCategory = 'Food'; // Default category  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: Text('Add Expenses'),  
      ),  
      body: Padding(  
        padding: const EdgeInsets.all(16.0),  
        child: Column(  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            Text(  
              'Current Balance: ₱ ${widget.currentBalance.toStringAsFixed(2)}', // Display current balance  
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),  
            ),   
            Text(  
              '₱ ${amountController.text.isEmpty ? '0' : amountController.text}',  
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),  
            ),  
            TextField(  
              controller: amountController,  
              decoration: InputDecoration(labelText: 'Amount'),  
              keyboardType: TextInputType.number,  
            ),  
            SizedBox(height: 20),  
            // Dropdown for category selection  
            DropdownButton<String>(  
              value: selectedCategory,  
              items: <String>['Food', 'Shopping', 'Entertainment', 'Fare']  
                  .map<DropdownMenuItem<String>>((String value) {  
                return DropdownMenuItem<String>(  
                  value: value,  
                  child: Text(value),  
                );  
              }).toList(),  
              onChanged: (String? newValue) {  
                if (newValue != null) {  
                  setState(() {  
                    selectedCategory = newValue; // Update selected category and rebuild UI  
                  });  
                }  
              },  
              hint: Text('Select Category'),  
            ),  
            TextField(  
              controller: noteController,  
              decoration: InputDecoration(labelText: 'Note (optional)'),  
            ),  
            SizedBox(height: 20),  
            Center(  
              child: ElevatedButton(  
                onPressed: () {  
                  double amount = double.tryParse(amountController.text) ?? 0;  
                  if (amount > 0) {  
                    widget.onAddExpense(amount, selectedCategory, noteController.text); // Call the callback  
                    Navigator.pop(context); // Go back to home screen  
                  } else {  
                    // Optionally show an error message if the amount is invalid  
                    ScaffoldMessenger.of(context).showSnackBar(  
                      SnackBar(content: Text('Please enter a valid amount')),  
                    );  
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
}