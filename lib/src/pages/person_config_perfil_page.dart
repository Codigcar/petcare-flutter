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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/huellas.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      SizedBox(height: 50),
                      FutureBuilder(
                        future: personProfileService.getPersonProfileById(1),
                        builder: (BuildContext context,
                            AsyncSnapshot<PersonProfileModel> snapshot) {
                          if (snapshot.hasData) {
                            final personProfile = snapshot.data;
                            print(personProfile);
                            return Column(
                              children: [
                                SizedBox(height: 70.0),
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
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
                                Text(
                                  personProfile.name +
                                      " " +
                                      personProfile.lastName,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
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
                  flex: 3,
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
                                  future: personProfileService
                                      .getPersonProfileById(1),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<PersonProfileModel>
                                          snapshot) {
                                    if (snapshot.hasData) {
                                      final personProfile = snapshot.data;
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'Información Personal',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: colorPetCare),
                                            textAlign: TextAlign.center,
                                          ),
                                          const SizedBox(height: 25),
                                          _info('correo:', personProfile.email),
                                          _info(
                                              'telefono:', personProfile.phone),
                                          _info('edad:', personProfile.age),
                                          _info('documento:',
                                              personProfile.document),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
              ],
            ),
            _exitButton(context)
          ],
        ),
      ),
    );
  }

  _photo(String personPhoto) {
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

  _exitButton(BuildContext context) {
    return Positioned(
      top: 30,
      right: 15,
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, 'login'),
        child: Container(
          child: Icon(
            Icons.cancel,
            color: Colors.red,
            size: 40,
          ),
        ),
      ),
    );
  }
}
