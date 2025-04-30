import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_aad/pages/page_add_contacts_to_party.dart';
import 'package:flutter_aad/pages/page_new_party.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// Displays the form field for name and validates that the input with the validator
Widget formName(PrimitiveWrapper nameParty) {
  return TextFormField(
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
      nameParty.value = value!;
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
Widget formLocation(PrimitiveWrapper locationParty) {
  return TextFormField(
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
      locationParty.value = value!;
    },
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter a location';
      }
      return null;
    },
  );
}

// displays the form for the description: user needs to enter the description of the party
Widget formDescription(PrimitiveWrapper descriptionParty) {
  return TextFormField(
    decoration: const InputDecoration(
      labelText: 'Description',
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color.fromARGB(255, 252, 85, 19)),
      ),
    ),
    onSaved: (value) {
      descriptionParty.value = value!;
    },
  );
}
