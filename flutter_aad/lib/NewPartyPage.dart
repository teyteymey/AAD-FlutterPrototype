import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class NewPartyPage extends StatefulWidget {
  const NewPartyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _NewPartyPage();
  }
}

// Page to view details of a party
class _NewPartyPage extends State<NewPartyPage> {
  // Attributes of parties
  String nameParty = 'default';
  String dateParty = 'default';

  final _formKey = GlobalKey<FormState>();

  Widget formName() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Name of the party',
        labelText: 'Name *',
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

  Widget formLocation() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: 'Name of the party',
        labelText: 'Name *',
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

  Widget formTime() {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith(
                (state) => Color.fromARGB(255, 252, 85, 19))),
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
        child: Text(
          'Choose a date and time',
          style: TextStyle(color: Color.fromARGB(255, 248, 248, 248)),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Create a new party'),
          backgroundColor: Color.fromARGB(255, 252, 85, 19),
        ),
        backgroundColor: Color.fromARGB(228, 249, 245, 227),
        body: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                formName(),
                formTime(),
                FloatingActionButton(
                    child: const Icon(Icons.add),
                    backgroundColor: Color.fromARGB(255, 252, 85, 19),
                    onPressed: () => {
                          if (_formKey.currentState!.validate())
                            {_formKey.currentState!.save(), print(nameParty)}
                        }),
              ],
            ),
          ),
        ));
  }
}
