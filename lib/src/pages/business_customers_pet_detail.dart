import 'package:flutter/material.dart';
import 'package:petcare/constants.dart';
import 'package:petcare/src/models/person_profile_model.dart';
import 'package:petcare/src/models/pet_model.dart';
import 'package:petcare/src/models/request_model.dart';
import 'package:petcare/src/services/person_request_service.dart';
import 'package:petcare/src/services/pet_service.dart';

class DetailPetDetailPage extends StatefulWidget {
  const DetailPetDetailPage({Key key}) : super(key: key);

  @override
  _DetailPetDetailPageState createState() => _DetailPetDetailPageState();
}

class _DetailPetDetailPageState extends State<DetailPetDetailPage> {
  final colorPetCare = Color.fromRGBO(46, 177, 185, 1.0);
  final requestService = new RequestService();
  List<PetModel> pets = new List<PetModel>();
  final petService = new PetService();

  @override
  Widget build(BuildContext context) {
    final PersonProfileModel personProfileModel =
        ModalRoute.of(context).settings.arguments;
/* 
    petService
        .getAllPetsByPersonId(personProfileModel.id)
        .then((value) => {pets = value});
 */
    return Scaffold(
        /* appBar: AppBar(
        title: Text('Perfil Medico'),
      ), */
        /* body: Container(
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
                  child: _requestList(),
                )
              ],
            ),
          ],
        ),
      ), */
        );
  }

  Widget _requestList() {
    return FutureBuilder(
      future: requestService.getAllRequestByPersonId(1),
      builder:
          (BuildContext context, AsyncSnapshot<List<RequestModel>> snapshot) {
        if (snapshot.hasData) {
          final requests = snapshot.data;
          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) =>
                _requestItem(context, requests[index]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _requestItem(BuildContext context, RequestModel request) {
    return Expanded(
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
    );
  }
}
