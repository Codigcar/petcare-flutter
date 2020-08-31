import 'package:flutter/material.dart';
import 'package:petcare/src/bloc/provider.dart';

import 'package:petcare/src/pages/home_page.dart';
import 'package:petcare/src/pages/login_page.dart';
import 'package:petcare/src/pages/register_page.dart';
import 'package:petcare/src/pages/register_user_page.dart';
import 'package:petcare/src/user_preferences/user_preferences.dart';
 
void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = new UserPreferences();
  await prefs.initPrefs();
  
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    // Mostrar token guardado
    final prefs = new UserPreferences();
    print( prefs.token );

    return Provider(
      child: MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'register_user',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'register': (BuildContext context) => RegisterPage(),
        'register_user' : (BuildContext context ) => RegisterUserPage()
      },
      theme: ThemeData(
        primaryColor: Color.fromRGBO(46, 177, 185, 1.0)
      ),
    )
    );
  }
}