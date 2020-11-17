import 'package:flutter/material.dart';

import '../../constants.dart';
import '../services/person_profile_service.dart';

class PerfilPage extends StatelessWidget {
  final personProfileService = PersonProfileService();
  String personPhoto = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: _photo(),
            ),
            Expanded(
              child: _photo(),
            ),
          ],
        ),
      ),
    );
  }

  _photo() {
    personProfileService
        .getPersonProfileById(1)
        .then((value) => this.personPhoto = value.photo);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorPetCare,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(personPhoto),
        ),
      ),
    );
  }
}
