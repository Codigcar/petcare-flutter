

import 'package:flutter/material.dart';

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
