import 'package:flutter/material.dart';
import 'package:flutter_aad/PartyDetailsPage.dart';

import 'NewPartyPage.dart';

var partyInfo = [
  ['House Party', 'Deventer', '20 Feb, 20:00h', '2.jpg'],
  ['Disco', 'Deventer', '20 Feb, 20:00h', '3.jpg'],
  ['Costume Party', 'Den Heks, Deventer', '15 Feb, 17:00h', '1.jpg'],
];

void main() {
  runApp(
    MaterialApp(home: PartiesPage()),
  );
}

class PartiesPage extends StatefulWidget {
  _PartiesPageState createState() => _PartiesPageState();
}

class _PartiesPageState extends State<PartiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming parties'),
        backgroundColor: Color.fromARGB(255, 252, 85, 19),
      ),
      backgroundColor: Color.fromARGB(228, 249, 245, 227),
      body: Column(
        children: [for (var i in partyInfo) Party(i)],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 252, 85, 19),
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPartyPage()),
            );
          }),
    );
  }
}

// Definition of element party
class Party extends StatelessWidget {
  //attributes of each party
  String titleParty = 'Default';
  String locationParty = 'Default';
  String dateParty = 'Default';
  String imageParty = "1.jpg";

  //creator methods with parameters
  Party(List<String> list) {
    titleParty = list[0];
    locationParty = list[1];
    dateParty = list[2];
    imageParty = list[3];
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Card(
        color: Color.fromARGB(255, 146, 255, 219),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        child: ListTile(
          leading: Image(image: AssetImage("images/" + imageParty)),
          title: Text(titleParty,
              style: const TextStyle(
                fontFamily: 'JosefinSans',
                fontWeight: FontWeight.w900,
                fontSize: 20.0,
              )),
          subtitle: Text(
            locationParty + '\n' + dateParty,
            style: const TextStyle(
                fontFamily: 'JosefinSans',
                fontWeight: FontWeight.w500,
                fontSize: 15.0,
                color: Colors.black),
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
