import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _createBackground(context),
        ],
      ),
    );
  }

  Widget _createBackground(BuildContext context) {
    final totalSize = MediaQuery.of(context).size;

    final backgroundPetCare = Container(
      height: totalSize.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(7, 103, 125, 1.0),
        Color.fromRGBO(46, 177, 185, 1.0),
      ])),
    );

    final circle = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          color: Color.fromRGBO(255, 255, 255, 0.1)),
    );

    return Stack(
      children: <Widget>[
        backgroundPetCare,
        Positioned(child: circle,top: 90.0,left: 30.0,),
        Positioned(child: circle,top: -40.0,right: -30.0,),
        Positioned(child: circle,bottom: -50.0,right: -10.0,),
        Positioned(child: circle,bottom: 120.0,right: 20.0,),
        Positioned(child: circle,bottom: -20.0,left: -20.0,),
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Icon(FontAwesomeIcons.paw,color: Colors.white,size: 70.0,),
              SizedBox(height: 10.0, width: double.infinity, ),
              Text('Bienvenido', style: TextStyle( color: Colors.white, fontSize:  25.0),)
            ],
          ),
        )
      ],
    );
  }
}
