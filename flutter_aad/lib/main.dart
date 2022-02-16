import 'dart:async';

import 'package:flutter/material.dart';

var partyInfo = [
  ['title1', 'location1', 'date1'],
  ['title2', 'location2', 'date2']
];

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Upcoming parties'),
            backgroundColor: Colors.lime,
          ),
          body: Party(partyInfo[0][0])),
    ),
  );
}

// Definition of class party
class Party extends StatelessWidget {
  //attributes of each party
  String partyTitle = 'Default';

  //creator methods with parameters
  Party(String title) {
    this.partyTitle = title;
  }

  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Card(
        child: ListTile(title: Text(partyTitle)),
      ),
    );
  }
}
