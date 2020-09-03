

import 'package:flutter/material.dart';

bool isNumeric(String value) {
  if (value.isEmpty) return false;
  final number = num.tryParse(value);
  return (number == null) ? false : true;
}


void showAlert( BuildContext context, String message )  {
  showDialog(
    context: context,
    builder: (context)  {
      return AlertDialog(
        title: Text('Usuario o contraseña Incorrectos'),
        content: Text(message),
        actions: <Widget>[
          FlatButton(onPressed: () => Navigator.of(context).pop(), child: Text('Ok'))
        ],
      );
    }
  );
}
