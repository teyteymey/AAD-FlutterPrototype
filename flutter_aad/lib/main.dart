import 'package:flutter/material.dart';
import 'package:flutter_aad/PartyDetailsPage.dart';
import 'globals.dart' as globals;
//import 'dart:html';

import 'NewPartyPage.dart';

void main() {
  runApp(
    MaterialApp(home: PartiesPage()),
  );
}

class PartiesPage extends StatefulWidget {
  _PartiesPageState createState() => _PartiesPageState();
}

class _PartiesPageState extends State<PartiesPage> {
  // builds the list of all the parties in the system.
  // it also has the floating button that helps us add a new party
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Upcoming parties'),
          backgroundColor: const Color.fromARGB(255, 252, 85, 19),
        ),
        backgroundColor: const Color.fromARGB(239, 255, 255, 253),
        body: Column(
          children: [
            for (var i in globals.partyInfo) Party(i)
          ], //pass all the info of the party, so if we click the details of the contacts are already there
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 252, 85, 19),
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewPartyPage()),
              );
            }),
      ),
    );
  }
}

// Definition of element party
// in here there is also the builder who contains the details of a party
class Party extends StatelessWidget {
  //attributes of each party
  String titleParty = 'Default';
  String locationParty = 'Default';
  String dateParty = 'Default';
  String imageParty = "1.jpg";
  List<List<String>> allPartyDetails = [];

  //creator methods with parameters
  // it sets each attribute
  Party(List<List<String>> list) {
    titleParty = list[0][0];
    locationParty = list[0][1];
    dateParty = list[0][2];
    imageParty = list[0][3];
    allPartyDetails = list;
  }

  // builder for party details.
  // when clicked, the details of the party are displayed
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PartyDetailsPage(allPartyDetails)),
        );
      },
      child: Card(
        color: const Color.fromARGB(255, 152, 255, 221),
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
          trailing: IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: () {
              deleteParty();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PartiesPage()),
              );
            },
          ),
        ),
      ),
    );
  }

  // allows to delete a party from the data, so it will no longer show
  void deleteParty() {
    globals.partyInfo.remove(allPartyDetails);
  }
}
