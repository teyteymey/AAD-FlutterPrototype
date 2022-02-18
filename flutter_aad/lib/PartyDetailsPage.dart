//import 'dart:html';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aad/main.dart';
import 'package:intl/intl.dart';
import 'globals.dart' as globals;

import 'package:add_2_calendar/add_2_calendar.dart';

List<List<String>> dataParty = [];

class PartyDetailsPage extends StatefulWidget {
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        color: const Color.fromARGB(225, 137, 255, 239),
        child: ListTile(
          trailing: IconButton(
            icon: Icon(Icons.remove_circle_outline),
            onPressed: () {
              deleteContact(contactDetails);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PartyDetailsPage(dataParty)),
              );
            },
          ),
          isThreeLine: true,
          title: Text(contactDetails[0],
              style: const TextStyle(
                fontFamily: 'JosefinSans',
                fontWeight: FontWeight.w900,
                fontSize: 17.0,
              )),
          subtitle: Text(
            contactDetails[1] + '\n' + contactDetails[2],
            style:
                TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 13),
          ),
        ),
      ),
    );
  }
}

void deleteContact(List<String> contactDetailsPar) {
  globals.partyInfo
      .remove(dataParty); // We remove the whole info of the party in globals
  dataParty.remove(contactDetailsPar); // We edit the party details
  globals.partyInfo
      .add(dataParty); //We add again the party with the participants updated
}

// Page to view details of a party
class _PartyDetailsPage extends State<PartyDetailsPage> {
  //Attributes of class
  List<List<String>> dataParty = [];
  Contact _contact = Contact();

  String nameParty = '',
      locationParty = '',
      timeParty = '',
      imageParty = '',
      descriptionParty = '';

  // Constructor method
  _PartyDetailsPage(List<List<String>> data) {
    dataParty = data;
    nameParty = dataParty[0][0];
    locationParty = dataParty[0][1];
    timeParty = dataParty[0][2];
    imageParty = dataParty[0][3];
    descriptionParty = dataParty[0][4];
  }

  void shareEvent() {
    DateFormat dateFormat = DateFormat("dd/MM, HH:mm");
    DateTime dateTime = dateFormat.parse(timeParty);

    print(timeParty);
    print(dateTime);

    final Event event = Event(
      title: nameParty,
      description: descriptionParty,
      location: locationParty,
      //startDate: DateTime(int.parse(date[0])),
      startDate: dateTime,
      endDate: DateTime(2023),
      iosParams: const IOSParams(
        reminder:
            const Duration(), // on iOS, you can set alarm notification after your event.
      ),
      androidParams: const AndroidParams(
        emailInvites: [], // on Android, you can add invite emails to your event.
      ),
    );
    Add2Calendar.addEvent2Cal(event);
  }

  Future<void> _pickContact() async {
    try {
      final Contact? contact = await ContactsService.openDeviceContactPicker();
      setState(() {
        _contact = contact!;

        // We need to add the new contact to the list of data of the party
        List<String> temp = [];
        String email, phone, displayName;

        if (!_contact.displayName!.isEmpty) {
          displayName = contact.displayName!;
        } else {
          displayName = 'There is no name registered';
        }

        if (!_contact.emails!.isEmpty) {
          email = contact.emails!.first.value!;
        } else {
          email = 'There are no emails registered';
        }

        if (!_contact.phones!.isEmpty) {
          phone = contact.phones!.first.value!;
        } else {
          phone = 'There are no phones registered';
        }

        temp = [displayName, phone, email];
        dataParty.add(temp);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(239, 255, 255, 253),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
              child: Container(
            width: MediaQuery.of(context).size.width,
          )),
          FloatingActionButton(
              heroTag: "Share",
              backgroundColor: const Color.fromARGB(255, 252, 85, 19),
              child: const Icon(Icons.share),
              onPressed: () {
                shareEvent();
              }),
          const Padding(
            padding: EdgeInsets.all(10.0),
          ),
          FloatingActionButton(
              heroTag: "Home",
              backgroundColor: const Color.fromARGB(255, 252, 85, 19),
              child: const Icon(Icons.house_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PartiesPage()),
                );
              }),
        ],
      ),
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
              padding: const EdgeInsets.all(15.0),
              child: Image(
                image: AssetImage("images/" + imageParty),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                locationParty + ' on the ' + timeParty,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 116, 78, 28),
                    fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 10, bottom: 20),
              child: Text(
                descriptionParty,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 116, 78, 28),
                    fontSize: 13),
              ),
            ),
            Container(
              height: 40,
              decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Container(
                    width: 20,
                  ),
                  const Text(
                    "Participants:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'JosefinSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  Container(
                    width: 130,
                  ),
                  IconButton(
                    onPressed: () => {_pickContact()},
                    icon: const Icon(Icons.add),
                  )
                ],
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
