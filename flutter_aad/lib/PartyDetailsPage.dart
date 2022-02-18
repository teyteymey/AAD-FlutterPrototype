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

class contactInfo extends StatelessWidget {
  List<String> contactDetails = [];

  contactInfo(List<String> contactDetailsPar) {
    contactDetails = contactDetailsPar;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 90,
      child: Card(
        color: Color.fromARGB(225, 137, 255, 239),
        child: ListTile(
          isThreeLine: true,
          title: Text(contactDetails[0],
              style: const TextStyle(
                fontFamily: 'JosefinSans',
                fontWeight: FontWeight.w900,
                fontSize: 15.0,
              )),
          subtitle: Text(
            contactDetails[1] + '\n' + contactDetails[2],
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
      ),
    );
  }
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
      backgroundColor: const Color.fromARGB(239, 255, 255, 253),
      appBar: AppBar(
        title: const Text('Detail page of party!'),
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 252, 85, 19),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(padding: EdgeInsets.all(10)),
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
            Container(
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: const EdgeInsets.all(15.0),
              child: const Center(
                child: Text(
                  "Participants:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'JosefinSans',
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              ),
            ),
            //add los contacts
            for (int i = 1; i < dataParty.length; i++)
              contactInfo(dataParty.elementAt(i))
          ],
        )),
      ),
    );
  }
}
