import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'PartyDetailsPage.dart';
import 'contacts_picker_page.dart';
import 'globals.dart' as globals;

class AddContactsToParty extends StatefulWidget {
  //const AddContactsToParty({Key? key}) : super(key: key);

  List<String> dataParty = [];

  AddContactsToParty(List<String> data) {
    dataParty = data;
  }

  @override
  State<StatefulWidget> createState() {
    return _AddContactsToParty(dataParty);
  }
}

// Is the method wich builds a contact information widget
class ContactContainer extends StatelessWidget {
  // attributes
  String name = 'def';
  String email = '';
  String phone = '';
  Contact contactDetails = Contact();

  // Creator method of the contact container
  /*
  We check if the email and the phone exist and then build a card with the information needed
  */
  ContactContainer(Contact contactDetails) {
    contactDetails = contactDetails;
    name = contactDetails.displayName!;

    if (!contactDetails.emails!.isEmpty) {
      email = contactDetails.emails!.first.value!;
    } else {
      email = 'There are no emails registered';
    }

    if (!contactDetails.phones!.isEmpty) {
      phone = contactDetails.phones!.first.value!;
    } else {
      phone = 'There are no phones registered';
    }
  }

  // building method for the contact card details.
  // Shows the name, the email and the phone.

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 90,
      child: Card(
        color: Color.fromARGB(215, 255, 201, 119),
        child: ListTile(
          isThreeLine: true,
          title: Text(name,
              style: const TextStyle(
                fontFamily: 'JosefinSans',
                fontWeight: FontWeight.w900,
                fontSize: 22.0,
              )),
          subtitle: Text(
            email + '\n' + phone,
            style: TextStyle(color: Colors.black.withOpacity(0.6)),
          ),
        ),
      ),
    );
  }
}

// Class to add contacts to a party
class _AddContactsToParty extends State<AddContactsToParty> {
  // Contact selected
  Contact _contact = new Contact();
  //attributes
  List<Contact> contacts = [];
  List<String> partyDetails = [];
  List<List<String>> finalDetailsParty = [];
  //constructor method that sets the parameter into the atribute of the object
  _AddContactsToParty(List<String> data) {
    partyDetails = data;
  }

/**
 * We build the details of the party to the finalDetailsParty List, which contains the party details in the first position
 * (like name, location...) and
 * then the info of each participant.
 */
  void formatDetailsOfParty() {
    List<String> temp = [];
    String email, phone, displayName;

    // in the first position, we add the details of the party.
    // the following lists are going to be details of participants of the party
    finalDetailsParty.add(partyDetails);

    // For each contact, we extract the details that are going to be associated to a party
    for (Contact contact in contacts) {
      if (!contact.displayName!.isEmpty) {
        displayName = contact.displayName!;
      } else {
        displayName = 'There is no name registered';
      }

      if (!contact.emails!.isEmpty) {
        email = contact.emails!.first.value!;
      } else {
        email = 'There are no emails registered';
      }

      if (!contact.phones!.isEmpty) {
        phone = contact.phones!.first.value!;
      } else {
        phone = 'There are no phones registered';
      }

      temp = [displayName, phone, email];
      finalDetailsParty.add(temp);
    }
  }

//Opens a new view to pick a contact from the native app for contacts
//when selected a contact, we add it to the list of contacts coming to the party
  Future<void> _pickContact() async {
    try {
      final Contact? contact = await ContactsService.openDeviceContactPicker();
      setState(() {
        _contact = contact!;
        contacts.add(_contact);
      });
    } catch (e) {
      print(e.toString());
    }
  }

/**
 * Builder method for adding contacts to the party.
 */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select contacts'),
        backgroundColor: const Color.fromARGB(255, 252, 85, 19),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(20)),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.all(20)),
                  const Text(
                    "Contacts:",
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
                    icon: Icon(Icons.add),
                  )
                ],
              ),
            ),
            //add los contacts
            for (var contact in contacts) ContactContainer(contact)
          ],
        ),
      ),
      // Button that confirms data introduced in the party -> now the party details will be shown
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 252, 85, 19),
          child: const Icon(Icons.check),
          onPressed: () {
            //this will make the corresponding list with details of the party and info about the participants
            formatDetailsOfParty();
            AddParty();
            createEvent();
            //print(finalDetailsParty);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PartyDetailsPage(finalDetailsParty)),
            );
          }),
    );
  }

//this will add the party with all the details to the global variables. this is needed to show the party after in the home page
  void AddParty() {
    globals.partyInfo.add(finalDetailsParty);
    print(finalDetailsParty);
  }

//creates an event in native calendar- it adds the party details we had.
  void createEvent() {
    final Event event = Event(
      title: partyDetails[0],
      description: partyDetails[4],
      location: partyDetails[1],
      startDate: DateTime(2022),
      endDate: DateTime(2023),
      iosParams: IOSParams(
        reminder:
            Duration(), // on iOS, you can set alarm notification after your event.
      ),
      androidParams: AndroidParams(
        emailInvites: [], // on Android, you can add invite emails to your event.
      ),
    );
    Add2Calendar.addEvent2Cal(event);
  }
}
