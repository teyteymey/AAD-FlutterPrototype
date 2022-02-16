import 'package:flutter/material.dart';

var partyInfo = [
  ['title1', 'location1', 'date1', '1.jpg'],
  ['title2', 'location2', 'date2', '2.jpg'],
  ['title3', 'location3', 'date3', '3.jpg']
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
        child: ListTile(
          //leading: Image.asset(imageParty),
          leading: Image(image: AssetImage("images/" + imageParty)),
          title: Text(titleParty),
          subtitle: Text(locationParty + ', ' + dateParty),
        ),
      ),
    );
  }
}
