import 'package:flutter/material.dart';
import 'package:petcare/src/pages/person_config_perfil_page.dart';
import 'package:petcare/src/pages/person_home_page.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:petcare/src/pages/person_pets_page.dart';
import 'package:petcare/src/pages/person_request_page.dart';
import 'package:petcare/src/pages/business_register_profile_page.dart';
import 'package:petcare/src/pages/person_register_profile_page.dart';
import 'package:petcare/src/pages/person_register_pet_page.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _pageIndex = 0;
  final colorPetCare = Color.fromRGBO(46, 177, 185, 1.0);
  Widget _showPages = new HomePersonProfilePage();
  final HomePersonProfilePage _homePersonProfilePage =
      new HomePersonProfilePage();
  final RegisterPersonProfilePage _registerPersonProfilePage =
      new RegisterPersonProfilePage();
  final PetsPage _petsPage = new PetsPage();
  final RegisterPetPage _registerPetPage = new RegisterPetPage();
  final PerfilPage _personPerfilPage = new PerfilPage();
  final PersonRequestPage _personRequestPage = new PersonRequestPage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _homePersonProfilePage;
        break;
      case 1:
        return _personRequestPage;
        break;
      case 2:
        return _petsPage;
        break;
      /* case 3:
        return _registerPetPage;
        break; */
      case 3:
        return _personPerfilPage;
        break;
    }
  }

  GlobalKey _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _pageIndex,
          height: 50.0,
          items: <Widget>[
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.assignment,
              size: 30,
              color: Colors.white,
            ),
            Icon(Icons.pets, size: 30, color: Colors.white),
            /* Icon(Icons.add_comment, size: 30, color: Colors.white), */
            Icon(Icons.account_circle, size: 30, color: Colors.white),
          ],
          color: colorPetCare,
          buttonBackgroundColor: colorPetCare,
          backgroundColor: Colors.white,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (int index) {
            setState(() {
              _showPages = _pageChooser(index);
            });
          },
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(
            child: _showPages,
          ),
        ));
  }
}
