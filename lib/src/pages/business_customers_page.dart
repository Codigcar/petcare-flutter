import 'package:flutter/material.dart';

class BusinessCustomersPage extends StatefulWidget {
  @override
  _BusinessCustomersPageState createState() => _BusinessCustomersPageState();
}

class _BusinessCustomersPageState extends State<BusinessCustomersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Container(
                color: Colors.red,
              ),
            ),
            Positioned(
              top: 20,
              left: 100, 
              height: 200*0.7,
              child: FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(
                    'https://cdn2.thecatapi.com/images/MTcxNDE1Ng.jpg'),
              ),
            ),
          ],
        ),
      )
          /* Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(
                  "https://cdn2.thecatapi.com/images/MTcxNDE1Ng.jpg"
                )
              )
          ),
        ), */
          ),
    );
  }
}
