//import 'dart:html';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aad/page_edit_party_details.dart';
import 'package:flutter_aad/main.dart';
import 'package:intl/intl.dart';
import 'contact_info.dart';
import 'globals.dart' as globals;

import 'package:add_2_calendar/add_2_calendar.dart';

List<List<String>> dataParty = [];

class PartyDetailsPage extends StatefulWidget {
  PartyDetailsPage(List<List<String>> data) {
    dataParty = data;
  }

  _PartyDetailsPage createState() => _PartyDetailsPage();
}

// Page to view details of a party
class _PartyDetailsPage extends State<PartyDetailsPage> {
  //Attributes of class
  //List<List<String>> dataParty = [];
  Contact _contact = Contact();

  String nameParty = '',
      locationParty = '',
      timeParty = '',
      imageParty = '',
      descriptionParty = '';

  // Constructor method
  _PartyDetailsPage() {
    nameParty = dataParty[0][0];
    locationParty = dataParty[0][1];
    timeParty = dataParty[0][2];
    imageParty = dataParty[0][3];
    descriptionParty = dataParty[0][4];
  }
  // Shares the event to the native app using the package 'package:add_2_calendar/add_2_calendar.dart'
  void shareEvent() {
    DateFormat dateFormat = DateFormat("dd/MM, HH:mm");
    DateTime dateTime = dateFormat.parse(timeParty);

    List<String> emails = [];

    for (int i = 1; i < dataParty.length; i++) {
      emails.add(dataParty[i][2]); // Where the emails are stored
    }

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
      androidParams: AndroidParams(
        emailInvites:
            emails, // on Android, you can add invite emails to your event.
      ),
    );
    Add2Calendar.addEvent2Cal(event);
  }

  // Allows us to pick a contact from the native app using the package 'package:contacts_service/contacts_service.dart'
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

  // builds the details of the party page
  // it also displays all the contacts invited to the party
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
          children: [
            Padding(padding: EdgeInsets.only(top: 8)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 20,
                  children: [
                    Text(
                      nameParty,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 116, 78, 28),
                          fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    IconButton(
                      onPressed: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditPartyPage(dataParty)),
                        )
                      },
                      icon: const Icon(Icons.edit),
                    )
                  ],
                ),
              ],
            ),

            Image(
              image: AssetImage("images/" + imageParty),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 13),
              child: Text(
                locationParty + ' on the ' + timeParty,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 116, 78, 28),
                    fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 5),
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
              contactInfo(dataParty.elementAt(i), dataParty)
          ],
        )),
      ),
    );
  }
}
