import 'package:flutter/material.dart';  
import '../widgets/balance_card.dart';  
import '../widgets/transaction_card.dart';  
import '../screens/add_expense_screen.dart';  
import '../screens/add_balance_screen.dart';  

class HomeScreen extends StatefulWidget {  
  final String name; // User's name  
  final String avatarPath; // User's avatar path  

  const HomeScreen({super.key, required this.name, required this.avatarPath}); // Updated constructor  

  @override  
  _HomeScreenState createState() => _HomeScreenState();  
}  

class _HomeScreenState extends State<HomeScreen> {  
  bool _isDarkMode = false;  
  double _totalBalance = 0.0;  
  List<Map<String, dynamic>> _transactions = [];  
  bool _isTrashVisible = false;  
  int? _selectedTransactionIndex;  

  void _toggleTheme(bool value) {  
    setState(() {  
      _isDarkMode = value;  
    });  
  }  

  void _showAddOptionsDialog() {  
    showDialog(  
      context: context,  
      builder: (context) {  
        return AlertDialog(  
          title: Text('Choose an option'),  
          content: Column(  
            mainAxisSize: MainAxisSize.min,  
            children: [  
              ListTile(  
                title: Text('Add Expenses'),  
                onTap: () {  
                  if (_totalBalance <= 0) {  
                    Navigator.of(context).pop();  
                    _showWarningDialog("Cannot add expense. Balance is zero.");  
                  } else {  
                    Navigator.of(context).pop();  
                    Navigator.push(  
                      context,  
                      MaterialPageRoute(  
                        builder: (context) => AddExpenseScreen(  
                          onAddExpense: _addExpense,  
                          currentBalance: _totalBalance,  
                        ),  
                      ),  
                    );  
                  }  
                },  
              ),  
              ListTile(  
                title: Text('Add Balance'),  
                onTap: () {  
                  Navigator.push(  
                    context,  
                    MaterialPageRoute(  
                      builder: (context) => AddBalanceScreen(  
                        onAddBalance: _addBalance,  
                        currentBalance: _totalBalance,  
                      ),  
                    ),  
                  );  
                },  
              ),  
            ],  
          ),  
        );  
      },  
    );  
  }  

  void _showWarningDialog(String message) {  
    showDialog(  
      context: context,  
      builder: (context) {  
        return AlertDialog(  
          title: Text('Warning'),  
          content: Text(message),  
          actions: [  
            TextButton(  
              onPressed: () => Navigator.of(context).pop(),  
              child: Text('OK'),  
            ),  
          ],  
        );  
      },  
    );  
  }  

  void _addBalance(double amount, String note, IconData icon) {  
    setState(() {  
      _totalBalance += amount;  
      _transactions.insert(0, {  
        'amount': amount,  
        'category': 'Balance',  
        'note': note,  
        'icon': icon,  
      });  
    });  
  }  

  void _addExpense(double amount, String category, String note) {  
    if (_totalBalance <= 0) {  
      _showWarningDialog("Cannot add expense. Balance is zero.");  
      return;  
    }  

    setState(() {  
      _totalBalance -= amount;  
      _transactions.insert(0, {  
        'amount': -amount, // Store expenses as negative values  
        'category': category,  
        'note': note,  
        'icon': _getIconForCategory(category),  
      });  
    });  
  }  

  IconData _getIconForCategory(String category) {  
    switch (category) {  
      case 'Food':  
        return Icons.fastfood;  
      case 'Shopping':  
        return Icons.shopping_cart;  
      case 'Entertainment':  
        return Icons.movie;  
      case 'Fare':  
        return Icons.directions_bus;  
      default:  
        return Icons.attach_money;  
    }  
  }  

  double get totalExpenses {  
    return _transactions  
        .where((transaction) => transaction['amount'] < 0)  
        .fold(0.0, (sum, transaction) => sum + transaction['amount']);  
  }  

  void _deleteTransaction(int index) {  
    if (index >= 0 && index < _transactions.length) {  
      setState(() {  
        _totalBalance -= _transactions[index]['amount'];   
        _transactions.removeAt(index);   
        _isTrashVisible = false;   
        _selectedTransactionIndex = null;  
      });  
    }  
  }  

  void _onTransactionTap(String title, String note) {  
    showDialog(  
      context: context,  
      builder: (context) {  
        return AlertDialog(  
          title: Text(title),  
          content: Text('Details for $title\nNote: $note'),  
          actions: [  
            TextButton(  
              onPressed: () => Navigator.of(context).pop(),  
              child: Text('Close'),  
            ),  
          ],  
        );  
      },  
    );  
  }  

  @override  
  Widget build(BuildContext context) {  
    
    final hour = DateTime.now().hour;  
    final isMorning = hour < 12;  

    return MaterialApp(  
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),  
      home: Scaffold(  
        appBar: AppBar(  
         title: Text('Good ${isMorning ? "Morning" : "Evening"}'),   
          actions: [  
            Row(  
              children: [  
                Icon(Icons.wb_sunny, color: _isDarkMode ? Colors.white : Colors.black),  
                SizedBox(width: 8),  
                Switch(value: _isDarkMode, onChanged: _toggleTheme, activeColor: Colors.white),  
                SizedBox(width: 8),  
                Icon(Icons.nights_stay, color: _isDarkMode ? Colors.white : Colors.black),  
              ],  
            ),  
          ],  
        ),  
        body: Padding(  
          padding: const EdgeInsets.all(16.0),  
          child: Column(  
            crossAxisAlignment: CrossAxisAlignment.start,  
            children: [  
              Row(  
                children: [  
                  CircleAvatar(  
                    radius: 30,  
                    backgroundImage: AssetImage(widget.avatarPath), // Display user's avatar  
                  ),  
                  SizedBox(width: 10),  
                  Text(  
                    widget.name, // Display user's name  
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),  
                  ),  
                ],  
              ),  
              SizedBox(height: 20),  
              BalanceCard(totalBalance: _totalBalance, totalExpenses: totalExpenses),  
              SizedBox(height: 20),  
              Text('Transactions', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),  
              Expanded(  
                child: ListView.builder(  
                  itemCount: _transactions.length,  
                  itemBuilder: (context, index) {  
                    var transaction = _transactions[index];  
                    return GestureDetector(  
                      onLongPress: () {  
                        setState(() {  
                          _isTrashVisible = true;  
                          _selectedTransactionIndex = index;  
                        });  
                      },  
                      onTap: () => _onTransactionTap(transaction['category'], transaction['note']),  
                      child: TransactionCard(  
                        title: transaction['category'],  
                        amount: transaction['amount'],  
                        date: 'Today',  
                        icon: Icon(transaction['icon']),  
                        note: transaction['note'],  
                        amountColor: transaction['amount'] < 0  
                            ? Colors.red  
                            : const Color.fromARGB(255, 4, 148, 40),  
                      ),  
                    );  
                  },  
                ),  
              ),  
            ],  
          ),  
        ),  
        floatingActionButton: FloatingActionButton(  
          onPressed: _showAddOptionsDialog,  
          backgroundColor: Colors.blue,  
          child: Icon(Icons.add, size: 30),  
        ),  
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,  
        bottomNavigationBar: _isTrashVisible  
            ? BottomAppBar(  
                child: Row(  
                  mainAxisAlignment: MainAxisAlignment.spaceAround,  
                  children: [  
                    IconButton(  
                      icon: Icon(Icons.delete, color: Colors.red),  
                      onPressed: () {  
                        if (_selectedTransactionIndex != null) {  
                          _deleteTransaction(_selectedTransactionIndex!);  
                        }  
                      },  
                    ),  
                  ],  
                ),  
              )  
            : null,  
      ),  
    );  
  }  
}