import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aad/pages/page_edit_party_details.dart';
import 'package:flutter_aad/main.dart';
import 'package:flutter_aad/pages/page_party_details.dart';
import 'package:intl/intl.dart';
import 'globals.dart' as globals;

import 'package:add_2_calendar/add_2_calendar.dart';

class contactInfo extends StatelessWidget {
  List<String> contactDetails = [];
  List<List<String>> dataParty = [];

  contactInfo(List<String> contactDetailsPar, List<List<String>> dataParty) {
    contactDetails = contactDetailsPar;
    dataParty = dataParty;
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
              deleteContact(contactDetails, dataParty);
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

void deleteContact(
    List<String> contactDetailsPar, List<List<String>> dataParty) {
  globals.partyInfo
      .remove(dataParty); // We remove the whole info of the party in globals
  dataParty.remove(contactDetailsPar); // We edit the party details
  globals.partyInfo
      .add(dataParty); //We add again the party with the participants updated
}
