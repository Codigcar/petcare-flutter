import 'package:flutter/material.dart';
import 'package:petcare/src/bloc/provider.dart';

import 'package:petcare/src/pages/home_page.dart';
import 'package:petcare/src/pages/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
      },
      theme: ThemeData(
        primaryColor: Color.fromRGBO(46, 177, 185, 1.0)
      ),
    )
    );
  }
}