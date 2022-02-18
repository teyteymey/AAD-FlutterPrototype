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
      appBar: AppBar(
        title: const Text('Detail page of party!'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [Text(nameParty)],
      )),
    );
  }
}
