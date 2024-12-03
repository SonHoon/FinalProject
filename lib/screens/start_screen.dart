import 'package:flutter/material.dart';  
import 'home_screen.dart'; // Ensure this path is correct  

class StartScreen extends StatefulWidget {  
  @override  
  _StartScreenState createState() => _StartScreenState();  
}  

class _StartScreenState extends State<StartScreen> {  
  String? _selectedGender;  
  final TextEditingController _nameController = TextEditingController();  
  bool _isLoading = false; // Loading state for navigation  

  void _navigateToHome() {  
    if (_selectedGender != null && _nameController.text.trim().isNotEmpty) {  
      setState(() {  
        _isLoading = true; // Start loading  
      });  

      // Simulate a delay to show loading (for demonstration)  
      Future.delayed(Duration(seconds: 1), () {  
        Navigator.pushReplacement(  
          context,  
          MaterialPageRoute(  
            builder: (context) => HomeScreen(  
              name: _nameController.text,  
              avatarPath: _selectedGender == 'Male'  
                  ? 'images/male avatar.jpg'  
                  : 'images/female avatar.jpg',  
            ),  
          ),  
        );  
      });  
    } else {  
      _showWarningDialog();  
    }  
  }  

  void _showWarningDialog() {  
    showDialog(  
      context: context,  
      builder: (context) {  
        return AlertDialog(  
          title: Text('Warning'),  
          content: Text('Please select a gender and enter your name before proceeding.'),  
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

  Widget _buildGenderOption(String gender, String imagePath) {  
    final isSelected = _selectedGender == gender;  

    return GestureDetector(  
      onTap: () {  
        setState(() {  
          _selectedGender = gender; // Set selected gender  
        });  
      },  
      child: Container(  
        decoration: BoxDecoration(  
          shape: BoxShape.circle,  
          border: Border.all(  
            color: isSelected ? Colors.blue : Colors.transparent, // Show border if selected  
            width: 4,  
          ),  
        ),  
        child: CircleAvatar(  
          radius: 60,  
          backgroundImage: AssetImage(imagePath),  
        ),  
      ),  
    );  
  }  

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      body: Container(  
        decoration: BoxDecoration(  
          gradient: LinearGradient(  
            colors: [Colors.lightBlue, Colors.pink],  
            begin: Alignment.topLeft,  
            end: Alignment.bottomRight,  
          ),  
        ),  
        child: Padding(  
          padding: const EdgeInsets.all(16.0),  
          child: Center(  
            child: _buildStartScreenContent(),  
          ),  
        ),  
      ),  
    );  
  }  

  Widget _buildStartScreenContent() {  
    return Column(  
      mainAxisAlignment: MainAxisAlignment.center,  
      children: [  
        Image.asset(  
          'images/logo_transparent.png',  
          height: 200,  
          width: 200,  
        ),  
        SizedBox(height: 20),  
        _buildWelcomeText(),  
        SizedBox(height: 20),  
        _buildNameInput(),  
        SizedBox(height: 20),  
        _buildGenderOptions(),  
        SizedBox(height: 20),  
        _buildStartButton(),  
      ],  
    );  
  }  

  Widget _buildWelcomeText() {  
    return Text(  
      'Welcome to Expense Tracker! Please enter your name and pick an avatar to get started.',  
      textAlign: TextAlign.center,  
      style: TextStyle(  
        fontSize: 20,  
        fontWeight: FontWeight.bold,  
        color: Colors.white,  
      ),  
    );  
  }  

  Widget _buildNameInput() {  
    return TextField(  
      controller: _nameController,  
      decoration: InputDecoration(  
        hintText: 'Enter your name',  
        hintStyle: TextStyle(color: Colors.grey[700]),  
        enabledBorder: OutlineInputBorder(  
          borderSide: BorderSide(color: Colors.grey),  
        ),  
        focusedBorder: OutlineInputBorder(  
          borderSide: BorderSide(color: Colors.blue, width: 2),  
        ),  
        filled: true,  
        fillColor: Colors.white,  
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),  
      ),  
      cursorColor: Colors.blue,  
    );  
  }  

  Widget _buildGenderOptions() {  
    return Row(  
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,  
      children: [  
        _buildGenderOption('Male', 'images/male avatar.jpg'),  
        _buildGenderOption('Female', 'images/female avatar.jpg'),  
      ],  
    );  
  }  

  Widget _buildStartButton() {  
    return ElevatedButton(  
      onPressed: _isLoading ? null : _navigateToHome,  
      child: _isLoading  
          ? CircularProgressIndicator(color: Colors.blue)  
          : Text('Start'),  
      style: ElevatedButton.styleFrom(  
        backgroundColor: Colors.white,  
        foregroundColor: Colors.blue,  
        minimumSize: Size(double.infinity, 50),  
        textStyle: TextStyle(fontSize: 18),  
      ),  
    );  
  }  
}