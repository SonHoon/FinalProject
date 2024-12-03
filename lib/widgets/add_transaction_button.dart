import 'package:flutter/material.dart';  
import '../screens/add_expense_screen.dart';  

class AddTransactionButton extends StatelessWidget {  
  final Function(double, String, String) onAddExpense;  
  final double currentBalance; // Add this line  

  const AddTransactionButton({super.key, required this.onAddExpense, required this.currentBalance});  
  
  @override  
  Widget build(BuildContext context) {  
    return FloatingActionButton(  
      onPressed: () {  
        Navigator.push(  
          context,  
          MaterialPageRoute(builder: (context) => AddExpenseScreen(  
            onAddExpense: onAddExpense,  
            currentBalance: currentBalance, // Pass the current balance here  
          )),  
        );  
      },  
      backgroundColor: Colors.pink,  
      child: Icon(Icons.add),  
    );  
  }  
}