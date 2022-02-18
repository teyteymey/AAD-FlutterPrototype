//import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PartyDetailsPage extends StatefulWidget {
  List<List<String>> dataParty = [];

  PartyDetailsPage(List<List<String>> data) {
    dataParty = data;
  }

  _PartyDetailsPage createState() => _PartyDetailsPage(dataParty);
}

// Page to view details of a party
class _PartyDetailsPage extends State<PartyDetailsPage> {
  //Attributes of class
  List<List<String>> dataParty = [];
  String nameParty = '',
      locationParty = '',
      timeParty = '',
      imageParty = '',
      descriptionParty = '';

  // Constructor method
  _PartyDetailsPage(List<List<String>> data) {
    print(data);
    dataParty = data;
    nameParty = dataParty[0][0];
    locationParty = dataParty[0][1];
    timeParty = dataParty[0][2];
    imageParty = dataParty[0][3];
    descriptionParty = dataParty[0][4];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(239, 255, 255, 253),
      appBar: AppBar(
        title: const Text('Detail page of party!'),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 252, 85, 19),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(padding: EdgeInsets.all(10)),
            Text(
              nameParty,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 116, 78, 28),
                  fontSize: 30),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image(
                image: AssetImage("images/" + imageParty),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                locationParty + '\n' + timeParty,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 116, 78, 28),
                    fontSize: 15),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
