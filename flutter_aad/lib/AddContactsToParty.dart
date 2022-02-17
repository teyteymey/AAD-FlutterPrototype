import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class AddContactsToParty extends StatefulWidget {
  const AddContactsToParty({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AddContactsToParty();
  }
}

class ContactContainer extends StatelessWidget {
  String name = 'def';
  List<String> contactDetails = [];

  ContactContainer(List<String> contactDetails) {
    contactDetails = contactDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 20,
      height: 100,
      child: Card(),
    );
  }
}

// Page to view details of a party
class _AddContactsToParty extends State<AddContactsToParty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select contacts'),
        backgroundColor: const Color.fromARGB(255, 252, 85, 19),
      ),
      body: Column(
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
                  onPressed: () => {},
                  icon: Icon(Icons.add),
                )
              ],
            ),
          ),
          //add los contacts
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 252, 85, 19),
          child: const Icon(Icons.check),
          onPressed: () {
            /*  Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPartyPage()),
            );
          */
          }),
    );
  }
}
