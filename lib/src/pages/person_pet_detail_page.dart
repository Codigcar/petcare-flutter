import 'package:flutter/material.dart';
import 'package:petcare/constants.dart';
import 'package:petcare/src/models/pet_model.dart';
import 'package:petcare/src/models/request_model.dart';
import 'package:petcare/src/services/person_request_service.dart';

class DetailPetPage extends StatefulWidget {
  const DetailPetPage({Key key}) : super(key: key);

  @override
  _DetailPetPageState createState() => _DetailPetPageState();
}

class _DetailPetPageState extends State<DetailPetPage> {
  final colorPetCare = Color.fromRGBO(46, 177, 185, 1.0);
  final requestService = new RequestService();

  @override
  Widget build(BuildContext context) {
    final PetModel pet = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      /* appBar: AppBar(
        title: Text('Perfil Medico'),
      ), */
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 20,
              child: Container(
                child: Image.asset('assets/img3.png'),
              ),
            ),
            Column(
              children: [
                Container(
                  height: 150,
                  child: Center(
                    child: Text(
                      pet.name,
                      style: TextStyle(
                        color: colorPetCare,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 40),
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
                                pet.age.toString() + ' meses',
                                style: TextStyle(
                                    color: colorPetCare,
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: pet.gender == "M"
                                  ? Text(
                                      "Macho",
                                      style: TextStyle(
                                          color: colorPetCare,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      "Hembra",
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
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(40),
                              ),
                              color: colorPetCare),
                          height: 200,
                          width: 200,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(40.0),
                              child: FadeInImage(
                                placeholder:
                                    AssetImage('assets/jar-loading.gif'),
                                image: NetworkImage(pet.photo),
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Fecha',
                          style: TextStyle(
                            color: colorPetCare,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Veterinaria',
                          style: TextStyle(
                            color: colorPetCare,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Servicio',
                          style: TextStyle(
                            color: colorPetCare,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: _requestList(pet),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _requestList(PetModel pet) {
    return FutureBuilder(
      future: requestService.getAllRequestByPersonId(1),
      builder:
          (BuildContext context, AsyncSnapshot<List<RequestModel>> snapshot) {
        if (snapshot.hasData) {
          final requests = snapshot.data;
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) =>
                _requestItem(context, requests[index], pet),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _requestItem(BuildContext context, RequestModel request, PetModel pet) {
    return (request.status == 1 &&
            (request.petName.toString() == pet.name.toString()))
        ? Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(request.dateReservation),
                    Text(request.veterinaryName),
                    Text(request.productName),
                  ],
                ),
              ),
            ),
          )
        : Container();
  }
}
