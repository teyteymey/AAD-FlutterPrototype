library my_prj.globals;

import 'package:contacts_service/contacts_service.dart';

// Has all the parties.
// When restarting the app, it loses all the session data and stays with this
// default information.
List<List<List<String>>> partyInfo = [
  [
    [
      'Party rock',
      'Deventer',
      '12/2, 20:15h',
      '1.jpg',
      'In the house toniiight everybody just have a good time'
    ],
    ['Ariadna Meyer', '+34 644 36 55 61', 'ariadnameyer@gmail.com'],
    ['Paula Cruzado', '+34 635 84 46 78', 'There are no emails registered'],
    ['Dani Gonzalez', '+34 640 61 59 86', 'There are no emails registered']
  ]
];
