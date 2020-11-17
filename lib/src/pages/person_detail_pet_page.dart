import 'package:flutter/material.dart';
import 'package:petcare/src/models/pet_model.dart';

class DetailPetPage extends StatefulWidget {
  const DetailPetPage({Key key}) : super(key: key);

  @override
  _DetailPetPageState createState() => _DetailPetPageState();
}

class _DetailPetPageState extends State<DetailPetPage> {
  final colorPetCare = Color.fromRGBO(46, 177, 185, 1.0);

  @override
  Widget build(BuildContext context) {
    final PetModel pet = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Registro Medico'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          pet.name,
                          style: TextStyle(
                              color: colorPetCare,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          pet.breed,
                          style: TextStyle(
                              color: colorPetCare,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          pet.age.toString() + ' años',
                          style: TextStyle(
                              color: colorPetCare,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          pet.gender,
                          style: TextStyle(
                              color: colorPetCare,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    /*  padding: EdgeInsets.all(20), */
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: FadeInImage(
                        placeholder: AssetImage('assets/jar-loading.gif'),
                        image: NetworkImage(pet.photo),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: Column(
                      children: [Text('data1')],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.blue,
                    child: Column(
                      children: [Text('data1')],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _dataPet(PetModel pet) {}
}
