import 'package:flutter/material.dart';

class PartyDetailsPage extends StatefulWidget {
  List<List<String>> data = [];

  PartyDetailsPage(List<String> data) {
    data = data;
  }

  _PartyDetailsPage createState() => _PartyDetailsPage(data);
}

// Page to view details of a party
class _PartyDetailsPage extends State<PartyDetailsPage> {
  //Attributes of class
  List<List<String>> data = [];

  // Constructor method
  _PartyDetailsPage(List<List<String>> data) {
    data = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail page of party!'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
