import 'package:flutter/material.dart';
import 'package:petcare/src/bloc/provider.dart';

import 'package:petcare/src/pages/home_page.dart';
import 'package:petcare/src/pages/login_page.dart';
import 'package:petcare/src/pages/register_business_profile_page.dart';
import 'package:petcare/src/pages/register_page.dart';
import 'package:petcare/src/pages/register_pet_page.dart';
import 'package:petcare/src/pages/register_person_profile_page.dart';
import 'package:petcare/src/pages/register_provider_page.dart';
import 'package:petcare/src/storage/storage.dart';
 
void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = new Storage();
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
    /* final prefs = new UserPreferences();
    print( prefs.token ); */

    return Provider(
      child: MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      initialRoute: 'register_provider',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'register': (BuildContext context) => RegisterPage(),
        'register_user' : (BuildContext context ) => RegisterUserPage(),
        'register_pet' : (BuildContext context ) => RegisterPetPage(),
        'register_business_profile' : (BuildContext context ) => RegisterBusinessProfile(),
        'register_provider' : (BuildContext context ) => RegisterProviderPage()
      },
      theme: ThemeData(
        primaryColor: Color.fromRGBO(46, 177, 185, 1.0)
      ),
    )
    );
  }
}