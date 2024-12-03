import 'package:flutter/material.dart';  

class TransactionCard extends StatelessWidget {  
  final String title;  
  final double amount;  
  final String date;  
  final Icon icon;  
  final String note; // Expect note as a parameter  
  final Color? amountColor;  

  const TransactionCard({  
    Key? key,  
    required this.title,  
    required this.amount,  
    required this.date,  
    required this.icon,  
    required this.note,  
    this.amountColor,  
  }) : super(key: key);  

  @override  
  Widget build(BuildContext context) {  
    return Card(  
      child: ListTile(  
        leading: icon,  
        title: Text(title),  
        subtitle: Column( // Use Column to show note below the date  
          crossAxisAlignment: CrossAxisAlignment.start,  
          children: [  
            Text(date),  
            Text(note, style: TextStyle(fontSize: 12, color: Colors.grey)), // Display note below date  
          ],  
        ),  
        trailing: Text(  
          '${amount < 0 ? '-' : '+'}₱${amount.abs().toStringAsFixed(2)}',   
          style: TextStyle(color: amountColor ?? (amount < 0 ? Colors.red : Colors.black)),  
        ),  
      ),  
    );  
  }  
}