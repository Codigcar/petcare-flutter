import 'package:flutter/material.dart';
import 'package:petcare/src/bloc/provider.dart';
import 'package:petcare/src/pages/person_detail_pet_page.dart';
import 'package:petcare/src/pages/person_detail_provider_page.dart';
import 'package:petcare/src/pages/business_home_page.dart';

import 'package:petcare/src/pages/home_page.dart';
import 'package:petcare/src/pages/login_page.dart';
import 'package:petcare/src/pages/person_home_page.dart';
import 'package:petcare/src/pages/business_menu_navbar.dart';
import 'package:petcare/src/pages/person_menu_navbar.dart';
import 'package:petcare/src/pages/person_request_page.dart';
import 'package:petcare/src/pages/business_register_profile_page.dart';
import 'package:petcare/src/pages/person_register_cita_page.dart';
import 'package:petcare/src/pages/login_register_page.dart';
import 'package:petcare/src/pages/person_register_pet_page.dart';
import 'package:petcare/src/pages/person_register_profile_page.dart';
import 'package:petcare/src/pages/business_register_provider_page.dart';
import 'package:petcare/src/storage/storage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

 
void main() async{ 
  WidgetsFlutterBinding.ensureInitialized();
  
  final _storage = new Storage();
  await _storage.initPrefs();

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
      localizationsDelegates: [
        // ... app-specific localization delegate[s] here
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('es', 'ES'), // Hebrew, no country code
        const Locale.fromSubtags(
            languageCode: 'zh'), // Chinese *See Advanced Locales below*
        // ... other locales the app supports
      ],

      initialRoute: 'home_business_nabvar',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'home': (BuildContext context) => HomePage(),
        'register': (BuildContext context) => RegisterPage(),
        'register_person_profile' : (BuildContext context ) => RegisterPersonProfilePage(),
        'register_pet' : (BuildContext context ) => RegisterPetPage(),
        'register_business_profile' : (BuildContext context ) => RegisterBusinessProfile(),
        'register_provider' : (BuildContext context ) => RegisterProviderPage(),
        'home_person_profile' : (BuildContext context ) => HomePersonProfilePage(),
        'detail_provider' : (BuildContext context ) => DetailProviderPage(),
        'menu_navbar':(BuildContext context ) => BottomNavBar(),
        'register_cita': (BuildContext context ) => RegisterCitaPage(),
        'person_request_list': (BuildContext context ) => PersonRequestPage(),
        'detail_pet': (BuildContext context ) => DetailPetPage(),
        'home_business' :(BuildContext context ) => HomeBusinessPage(),
        'home_business_nabvar' :(BuildContext context ) => MenuBusinessNavbarPage(),


      },
      theme: ThemeData(
        primaryColor: Color.fromRGBO(46, 177, 185, 1.0)
      ),
    )
    );
  }
}


/* void main() => runApp(MaterialApp(home: BottomNavBar()));



class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}


class _BottomNavBarState extends State<BottomNavBar> {

  final MainPersonProfilePage mainPersonProfilePage = new MainPersonProfilePage();
  Widget _login = new MainPersonProfilePage();

  Widget _pageChooser(int page){
  switch (page) {
    case 1:
      return mainPersonProfilePage;
      break;
  }
}
  
  int _page = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.call_split, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.blueAccent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int index) {
            setState(() {
              /* _page = index; */
              _login = _pageChooser(index);
            });
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            /* child: Column(
              children: <Widget>[
                Text(_page.toString(), textScaleFactor: 10.0),
                RaisedButton(
                  child: Text('Go To Page of index 1'),
                  onPressed: () {
                    final CurvedNavigationBarState navBarState =
                        _bottomNavigationKey.currentState;
                    navBarState.setPage(0);
                  },
                )
              ],
            ), */

            child: _login,
          ),
        ));
  }
} */
