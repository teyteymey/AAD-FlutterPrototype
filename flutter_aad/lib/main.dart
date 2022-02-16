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
          body: Container(
            child: Column(
              children: [for (var i in partyInfo) Party(i)],
            ),
          )),
    ),
  );
}

// Definition of class party
class Party extends StatelessWidget {
  //attributes of each party
  String titleParty = 'Default';
  String locationParty = 'Default';
  String dateParty = 'Default';

  //creator methods with parameters
  Party(List<String> list) {
    titleParty = list[0];
    locationParty = list[1];
    dateParty = list[2];
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Card(
        child: ListTile(
          title: Text(titleParty),
          subtitle: Text(locationParty + ', ' + dateParty),
        ),
      ),
    );
  }
}
