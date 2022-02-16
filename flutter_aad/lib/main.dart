import 'package:flutter/material.dart';

var partyInfo = [
  ['House Party', 'Deventer', '20 Feb, 20:00h', '2.jpg'],
  ['Disco', 'Deventer', '20 Feb, 20:00h', '3.jpg'],
  ['Costume Party', 'Den Heks, Deventer', '15 Feb, 17:00h', '1.jpg'],
];

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Upcoming parties'),
          backgroundColor: Color.fromARGB(255, 252, 85, 19),
        ),
        body: Container(
          color: Color.fromARGB(228, 249, 245, 227),
          child: Column(
            children: [for (var i in partyInfo) Party(i)],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 252, 85, 19),
            child: const Icon(Icons.add),
            onPressed: () {
              PartyDetails();
            }),
      ),
    ),
  );
}

// Definition of class party
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

class PartyDetails extends StatelessWidget {
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
