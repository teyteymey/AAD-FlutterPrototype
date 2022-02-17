import 'main.dart';
import 'package:flutter/material.dart';

import 'package:contacts_service/contacts_service.dart';

class ContactPickerPage extends StatefulWidget {
  @override
  _ContactPickerPageState createState() => _ContactPickerPageState();
}

class _ContactPickerPageState extends State<ContactPickerPage> {
  Contact _contact = new Contact();

  @override
  void initState() {
    super.initState();
  }

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
