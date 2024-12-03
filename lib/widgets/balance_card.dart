import 'package:flutter/material.dart';  

class BalanceCard extends StatelessWidget {  
  final double totalBalance;  
  final double totalExpenses;  

  const BalanceCard({  
    Key? key,  
    required this.totalBalance,  
    required this.totalExpenses,  
  }) : super(key: key);  

  @override  
  Widget build(BuildContext context) {  
    return Container(  
      padding: const EdgeInsets.all(20),  
      decoration: BoxDecoration(  
        gradient: LinearGradient(  
          colors: [Colors.pink, Colors.blue],  
          begin: Alignment.topLeft,  
          end: Alignment.bottomRight,  
        ),  
        borderRadius: BorderRadius.circular(12),  
      ),  
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,  
        children: [  
          Text(  
            'Total Balance',  
            style: TextStyle(color: Colors.white, fontSize: 18),  
          ),  
          SizedBox(height: 8),  
          Text(  
            '₱${totalBalance.toStringAsFixed(2)}',  
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),  
          ),  
          SizedBox(height: 20),  
          Row(  
            mainAxisAlignment: MainAxisAlignment.spaceBetween,  
            children: [  
              Column(  
                crossAxisAlignment: CrossAxisAlignment.start,  
                children: [  
                  Text(  
                    'Total Expenses',  
                    style: TextStyle(color: Colors.white, fontSize: 16),  
                  ),  
                  Text(  
                    '₱${totalExpenses.toStringAsFixed(2)}',  
                    style: TextStyle(color: Colors.white, fontSize: 20),  
                  ),  
                ],  
              ),  
            ],  
          ),  
        ],  
      ),  
    );  
  }  
}