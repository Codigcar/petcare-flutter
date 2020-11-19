import 'package:flutter/material.dart';
import 'package:petcare/src/models/person_profile_model.dart';

import '../../constants.dart';
import '../services/person_profile_service.dart';

class PerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*  String personPhoto =
        'https://res.cloudinary.com/dggqauzyy/image/upload/v1605648854/wzj97uwg4o5cl81rz9an.jpg';
 */
    final personProfileService = PersonProfileService();

    /*   personProfileService
        .getPersonProfileById(1)
        .then((value) => personPhoto = value.photo);
 */
    return Scaffold(
      appBar: AppBar(
        title: Text('Mi Perfil'),
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Column(
                children: [
                  FutureBuilder(
                    future: personProfileService.getPersonProfileById(1),
                    builder: (BuildContext context,
                        AsyncSnapshot<PersonProfileModel> snapshot) {
                      if (snapshot.hasData) {
                        final personProfile = snapshot.data;
                        print(personProfile);
                        return Column(
                          children: [
                            SizedBox(height: 20.0),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorPetCare,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      NetworkImage(personProfile.photo),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Text(personProfile.name +
                                " " +
                                personProfile.lastName)
                          ],
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            FutureBuilder(
                              future:
                                  personProfileService.getPersonProfileById(1),
                              builder: (BuildContext context,
                                  AsyncSnapshot<PersonProfileModel> snapshot) {
                                if (snapshot.hasData) {
                                  final personProfile = snapshot.data;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Información Personal',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 25),
                                      _info('correo:', personProfile.email),
                                      _info('telefono:', personProfile.phone),
                                      _info('edad:', personProfile.age),
                                      _info(
                                          'documento:', personProfile.document),
                                      _info('contraseña:',
                                          personProfile.password),
                                    ],
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: RaisedButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: colorPetCare,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Guardar Cambios',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            /* Expanded(
              child: _photo(personPhoto),
            ), */
          ],
        ),
      ),
    );
  }

  _photo(String personPhoto) {
    /*  personProfileService.getPersonProfileById(1).then((value) {
      this.personPhoto = value.photo;
    }); */
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

  _info(String section, String information) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          section,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(information),
        Icon(Icons.edit)
      ],
    );
  }
}
