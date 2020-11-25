import 'package:flutter/material.dart';
import 'package:petcare/src/services/pet_service.dart';
import 'package:petcare/src/models/pet_model.dart';

class PetsPage extends StatelessWidget {
  final petService = new PetService();
  final colorPetCare = Color.fromRGBO(46, 177, 185, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Mis Mascotas')),
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Opacity(
              opacity: 0.6,
              child: Container(
                child: Image.asset('assets/img4.png'),
              ),
            ),
          ),
          Column(
            children: [
              _createList(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _createList() {
    return FutureBuilder(
      future: petService.getAllPetsByPersonId(1),
      builder: (BuildContext context, AsyncSnapshot<List<PetModel>> snapshot) {
        if (snapshot.hasData) {
          final getPets = snapshot.data;
          print(getPets.length);
          return Expanded(
            child: GridView.builder(
              itemCount: getPets.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.90),
              itemBuilder: (context, index) =>
                  _createItem(context, getPets[index]),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createItem(BuildContext context, PetModel pet) {
    final card = Container(
      child: FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(pet.photo),
        fadeInDuration: Duration(milliseconds: 200),
        fit: BoxFit.cover,
      ),
    );

    return Material(
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, 'detail_pet', arguments: pet),
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: colorPetCare,
              borderRadius: BorderRadius.circular(30.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    spreadRadius: 2.0,
                    offset: Offset(2.0, 10.0))
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: card,
          ),
        ),
      ),
    );
  }
}
