import 'package:flutter/material.dart';
import 'package:suitmediatest/screen/third_screen.dart';

class SecondScreen extends StatefulWidget {
  final String showName;

  SecondScreen({required this.showName});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String _selectedUserName = '';

  void goToThirdScreen(BuildContext context) async {
    final selectedUserName = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThirdScreen()),
    );

    if (selectedUserName != null) {
      setState(() {
        _selectedUserName = selectedUserName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 16.0),
            child: Text(
              'Welcome',
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.0, top: 8.0),
            child: Text(
              '${widget.showName}',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          Center(
            child: Text(
              'Selected User Name: $_selectedUserName',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () => goToThirdScreen(context),
            child: Text(
              'Choose a User',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(43, 99, 123, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(double.infinity, 50.0),
            ),
          ),
        ],
      ),
    );
  }
}
