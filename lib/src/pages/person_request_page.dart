import 'package:flutter/material.dart';

class PersonRequestPage extends StatefulWidget {
  @override
  _PersonRequestPageState createState() => _PersonRequestPageState();
}

class _PersonRequestPageState extends State<PersonRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( title: Text('Request'),),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          _requestCard()
        ],
      ),
    );
  }
}

 Widget _requestCard() {
   return Card(
     elevation: 10.0,
     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
     child: Column(
       children: <Widget>[
         ListTile(
           leading: Icon(Icons.photo, color: Colors.blue),
           title: Text('Titulo'),
           subtitle: Text('Titulo'),
         )
       ],
     ),
   );
}