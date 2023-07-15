import 'package:flutter/material.dart';
import 'package:suitmediatest/screen/second_screen.dart';

class PalindromeScreen extends StatefulWidget {
  @override
  _PalindromeScreenState createState() => _PalindromeScreenState();
}

class _PalindromeScreenState extends State<PalindromeScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _sentenceController = TextEditingController();
  bool _isPalindrome = false;

  bool isPalindrome(String text) {
    String cleanText = text.replaceAll(' ', '').toLowerCase();
    String reversedText = cleanText.split('').reversed.join('');
    return cleanText == reversedText;
  }

  void checkPalindrome() {
    String sentence = _sentenceController.text;
    bool palindrome = isPalindrome(sentence);
    setState(() {
      _isPalindrome = palindrome;
    });

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Palindrome Checker'),
          content: Text(palindrome ? 'Palindrome' : 'Not Palindrome'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void goToNextScreen() {
    String showName = _nameController.text;
    String sentence = _sentenceController.text;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondScreen( showName: showName)),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sentenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Palindrome Checker'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'lib/assets/background.png'), // Replace with your background image asset path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'lib/assets/logo.png', // Replace with your logo image asset path
                height: 100,
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: TextField(
                  controller: _sentenceController,
                  decoration: InputDecoration(
                    labelText: 'Sentence',
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: checkPalindrome,
                child: Text(
                  'Check',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(43, 99, 123, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: goToNextScreen,
                child: Text(
                  'Next',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(43, 99, 123, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}