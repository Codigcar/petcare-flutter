import 'package:flutter/material.dart';
import 'package:petcare/src/models/person_profile_model.dart';
import 'package:petcare/src/models/pet_model.dart';
import 'package:petcare/src/models/request_model.dart';
import 'package:petcare/src/services/business_request_service.dart';
import 'package:petcare/src/services/pet_service.dart';

import '../../constants.dart';

class BusinessCustomersPetPage extends StatefulWidget {
  @override
  _BusinessCustomersPetPageState createState() =>
      _BusinessCustomersPetPageState();
}

class _BusinessCustomersPetPageState extends State<BusinessCustomersPetPage> {
  final petService = new PetService();

  @override
  Widget build(BuildContext context) {
    final PersonProfileModel personProfileModel =
        ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mascotas'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                _createList(personProfileModel),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _createList(PersonProfileModel personProfileModel) {
    return FutureBuilder(
      future: petService.getAllPetsByPersonId(personProfileModel.id),
      builder: (BuildContext context, AsyncSnapshot<List<PetModel>> snapshot) {
        if (snapshot.hasData) {
          final pets = snapshot.data;
          return Expanded(
            child: GridView.builder(
              itemCount: pets.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.90),
              itemBuilder: (context, index) =>
                  _createItem(context, pets[index]),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createItem(BuildContext context, PetModel pet) {
    return Material(
      child: InkWell(
        onTap: () => Navigator.pushNamed(
            context, 'business_customer_pet_detail',
            arguments: pet),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    child: CircleAvatar(
                      backgroundColor: colorPetCare,
                      radius: 110,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(pet.photo),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    pet.name,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
