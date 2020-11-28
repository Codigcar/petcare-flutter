import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:petcare/src/pages/business_home_page.dart';

import '../../constants.dart';
import 'business_customers_page.dart';
import 'business_home_page.dart';
import 'business_request_page.dart';

class MenuBusinessNavbarPage extends StatefulWidget {
  @override
  _MenuBusinessNavbarPageState createState() => _MenuBusinessNavbarPageState();
}

class _MenuBusinessNavbarPageState extends State<MenuBusinessNavbarPage> {
  int _pageIndex = 0;
  /*  Widget _showPages = new HomePersonProfilePage();
  final HomePersonProfilePage _homePersonProfilePage = new HomePersonProfilePage();
  final RegisterPersonProfilePage _registerPersonProfilePage = new RegisterPersonProfilePage();
  final PetsPage _petsPage = new PetsPage();
  final RegisterPetPage _registerPetPage = new RegisterPetPage();
  final RegisterBusinessProfile _registerBusinessProfile = new RegisterBusinessProfile();
  final PersonRequestPage _personRequestPage = new PersonRequestPage();
 */
  Widget _showPages = new HomeBusinessPage();
  final HomeBusinessPage _homeBusinessPage = new HomeBusinessPage();
  final BusinessRequestAccepted _businessRequestAccepted =
      new BusinessRequestAccepted();
  final BusinessCustomersPage _businessCustomersPage =
      new BusinessCustomersPage();

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return _homeBusinessPage;
        break;
      case 1:
        return _businessCustomersPage;
        break;
      case 2:
        return _businessRequestAccepted;
        break;
      /*  case 1:
      return _personRequestPage;
      break;
    case 3:
      return _registerPetPage;
      break;
    case 4:
      return _registerBusinessProfile;
      break; */
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
            Icon(Icons.home, size: 30, color: Colors.white),
            Icon(Icons.person, size: 30, color: Colors.white),
            Icon(Icons.perm_contact_calendar, size: 30, color: Colors.white),
            /* Icon(Icons.comment, size: 30, color: Colors.white), */
            Icon(Icons.build, size: 30, color: Colors.white),
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
