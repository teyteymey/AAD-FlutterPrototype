import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_aad/page_add_contacts_to_party.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'form_fields.dart';

class NewPartyPage extends StatefulWidget {
  const NewPartyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewPartyPage();
  }
}

//Class to pass primitives by reference
class PrimitiveWrapper {
  var value;
  PrimitiveWrapper(this.value);
}

// Page to view details of a party
class _NewPartyPage extends State<NewPartyPage> {
  // Attributes of parties
  var nameParty = PrimitiveWrapper('default');
  String dateParty = 'default';
  var locationParty = PrimitiveWrapper('default');
  var descriptionParty = PrimitiveWrapper('default');
  String timeParty = 'default';
  String image = '1.jpg';
  TimeOfDay _time = const TimeOfDay(hour: 20, minute: 15);
  DateTime _date = DateTime(2022);

  List<String> partyInfo = [];

  final _formKey = GlobalKey<FormState>();

  /**
   * Chooses a random image for the party from the assets available
   */
  void randomImage() {
    Random random = Random();
    int randomNumber = random.nextInt(7) + 1;
    image = '$randomNumber.jpg';
  }

// Displays the time picker by using the package 'package:flutter_datetime_picker/flutter_datetime_picker.dart'
  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
    }
  }

  // Displays the date picker by using the package 'package:flutter_datetime_picker/flutter_datetime_picker.dart'
  void _selectDate() async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2032, 7),
      helpText: 'Select a date',
      initialDate: DateTime.now(),
    );
    if (newDate != null) {
      setState(() {
        _date = newDate;
        print(_date);
      });
    }
  }

  // it is the form for the time.
// it is a button that when clicked calls the function called _selectTime()
  Widget formTime() {
    return TextButton.icon(
        icon: const Icon(
          Icons.add_alarm,
          size: 25,
          color: Colors.white,
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
                (state) => const Color.fromARGB(255, 252, 85, 19))),
        onPressed: () {
          timeParty = '';
          _selectTime();
          timeParty = '${_time.format(context)}h';
        },
        label: const Text(
          'Choose a time',
          style: TextStyle(color: Color.fromARGB(255, 248, 248, 248)),
        ));
  }

// it is the form for the time.
// it is a button that when clicked calls the function called _selectDate()
  Widget formDate() {
    return TextButton.icon(
        icon: const Icon(
          Icons.calendar_today,
          size: 25,
          color: Colors.white,
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
                (state) => const Color.fromARGB(255, 252, 85, 19))),
        onPressed: () {
          dateParty = "";
          _selectDate();
          dateParty = '${_date.day}/${_date.month}';
        },
        label: const Text(
          'Choose a date',
          style: TextStyle(color: Color.fromARGB(255, 248, 248, 248)),
        ));
  }

  // builds the page with all the methods above, which set the attributes for the party
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Create a new party'),
        backgroundColor: const Color.fromARGB(255, 252, 85, 19),
      ),
      backgroundColor: const Color.fromARGB(228, 249, 245, 227),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                ),
                formName(nameParty),
                Container(
                  height: 25,
                ),
                formLocation(locationParty),
                Container(
                  height: 40,
                ),
                formTime(),
                Container(
                  height: 20,
                ),
                formDate(),
                Container(
                  height: 50,
                ),
                formDescription(descriptionParty),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check),
          backgroundColor: const Color.fromARGB(255, 74, 206, 162),
          onPressed: () => {
                if (_formKey.currentState!.validate())
                  {
                    _formKey.currentState!.save(),
                  },
                randomImage(),
                partyInfo.addAll([
                  nameParty.value,
                  locationParty.value,
                  dateParty + ', ' + timeParty,
                  image,
                  descriptionParty.value,
                ]),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddContactsToParty(partyInfo)),
                )
              }),
    );
  }
}
