import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aad/page_add_contacts_to_party.dart';
import 'package:flutter_aad/page_party_details.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'main.dart';
import 'globals.dart' as globals;

List<List<String>> dataParty = [];

class EditPartyPage extends StatefulWidget {
  EditPartyPage(List<List<String>> dataPartyPar) {
    dataParty = dataPartyPar;
    //print(' dentro de editar, lo que llega $dataParty');
  }
  @override
  State<StatefulWidget> createState() {
    return _EditPartyPage();
  }
}

// Page to view details of a party
class _EditPartyPage extends State<EditPartyPage> {
  // Attributes of parties
  String nameParty = 'default';
  String dateParty = 'default';
  String locationParty = 'default';
  String descriptionParty = 'default';
  String timeParty = 'default';
  String image = '1.jpg';
  TimeOfDay _time = const TimeOfDay(hour: 20, minute: 15);
  DateTime _date = new DateTime(2022);

  List<String> partyInfo = [];

  final _formKey = GlobalKey<FormState>();
  /**
   * Chooses a random image for the party from the assets available
   */
  void randomImage() {
    Random random = new Random();
    int randomNumber = random.nextInt(7) + 1;
    image = '$randomNumber.jpg';
  }

  // Displays the form field for name and validates that the input with the validator
  Widget formName() {
    return TextFormField(
      initialValue: dataParty[0]
          [0], //we access the old info to put it as default
      decoration: const InputDecoration(
        icon: Icon(
          Icons.attractions_outlined,
          size: 25,
        ),
        focusColor: Colors.orange,
        labelText: "Name",
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 252, 85, 19),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 252, 85, 19)),
        ),
      ),
      onSaved: (value) {
        nameParty = value!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }

// Displays the form field for location and validates that the input with the validator
  Widget formLocation() {
    return TextFormField(
      initialValue: dataParty[0]
          [1], //we access the old info to put it as default
      decoration: const InputDecoration(
        icon: Icon(Icons.add_location_alt_outlined),
        focusColor: Colors.orange,
        labelText: "Location",
        labelStyle: TextStyle(
          color: Color.fromARGB(255, 252, 85, 19),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 252, 85, 19)),
        ),
      ),
      onSaved: (value) {
        locationParty = value!;
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a location';
        }
        return null;
      },
    );
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

  // it is unused, but in case we wanted more material feel, we can check which system is running and display a different
  // material style
  Widget formTimeIOS() {
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
          DatePicker.showDateTimePicker(context, showTitleActions: true,
              onChanged: (date) {
            print('change $date in time zone ' +
                date.timeZoneOffset.inHours.toString());
          }, onConfirm: (date) {
            int helper = 0;
            dateParty = '';
            helper = date.day;
            dateParty += "$helper";
            dateParty += '/';
            helper = date.month;
            dateParty += "$helper";
            dateParty += ', ';
            helper = date.hour;
            dateParty += "$helper";
            dateParty += ':';
            helper = date.minute;
            if (helper <= 9)
              dateParty += "0$helper";
            else
              dateParty += "$helper";
            dateParty += 'h';
            print('confirm $dateParty');
          }, currentTime: DateTime(2022, 2, 20, 16, 00, 00));
        },
        label: const Text(
          'Choose a date and time',
          style: TextStyle(color: Color.fromARGB(255, 248, 248, 248)),
        ));
  }

  // displays the form for the description: user needs to enter the description of the party
  Widget formDescription() {
    return TextFormField(
      initialValue: dataParty[0]
          [4], //we access the old info to put it as default
      decoration: const InputDecoration(
        labelText: 'Description',
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 252, 85, 19)),
        ),
      ),
      onSaved: (value) {
        descriptionParty = value!;
      },
    );
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
                formName(),
                Container(
                  height: 25,
                ),
                formLocation(),
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
                formDescription(),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.save),
          backgroundColor: const Color.fromARGB(255, 74, 206, 162),
          onPressed: () => {
                if (_formKey.currentState!.validate())
                  {
                    _formKey.currentState!.save(),
                  },
                randomImage(),
                partyInfo.addAll([
                  nameParty,
                  locationParty,
                  dateParty + ', ' + timeParty,
                  image,
                  descriptionParty,
                ]),
                changeInfo(),
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PartyDetailsPage(dataParty)),
                )
              }),
    );
  }

  // Serves to edit the details of the party by removing the info from the party and then adding the new party with the changed details
  void changeInfo() {
    print('globals ${globals.partyInfo}');
    globals.partyInfo
        .remove(dataParty); // delete the original party from globals

    print('globals despues de borrar la fiesta ${globals.partyInfo}');

    print('info original antes de borrar la info ${dataParty}');
    dataParty.removeAt(0);
    // original data of party with contacts, we remove the data of the party
    // the only thing left are contacts
    print('info original despues de borrar la info ${dataParty}');

    dataParty.insert(0, partyInfo); // add the new details at index 0
    print('info original despues de acttualizar la info ${dataParty}');
    globals.partyInfo.add(dataParty); //add it back to globals

    print('globals despues de añadir la fiesta updated ${globals.partyInfo}');
  }
}
