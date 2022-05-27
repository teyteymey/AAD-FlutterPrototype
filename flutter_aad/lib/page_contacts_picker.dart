import 'main.dart';
import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';

class ContactPickerPage extends StatefulWidget {
  @override
  _ContactPickerPageState createState() => _ContactPickerPageState();
}

// This class comes from the documentation of the package used 'package:contacts_service/contacts_service.dart'
// Since it was not very clear how it was used, I took the methods I needed and created my own class.
class _ContactPickerPageState extends State<ContactPickerPage> {
  Contact _contact = new Contact();

  @override
  void initState() {
    super.initState();
  }

  // allows to pick a contact from the native app. Then it reads the contact information and we can use
  // it to link it with the party
  Future<void> _pickContact() async {
    try {
      final Contact? contact = await ContactsService.openDeviceContactPicker();
      setState(() {
        _contact = contact!;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  //Builds the page to pick contacts for a party
  // it calls the method above, which displays the native app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contacts Picker Example')),
      body: SafeArea(
          child: Column(
        children: <Widget>[
          ElevatedButton(
            child: const Text('Pick a contact'),
            onPressed: _pickContact,
          ),
          if (_contact != null)
            Text('Contact selected: ${_contact.displayName}'),
        ],
      )),
    );
  }
}
