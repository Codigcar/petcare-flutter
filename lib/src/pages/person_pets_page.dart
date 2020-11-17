import 'package:flutter/material.dart';
import 'package:petcare/src/services/pet_service.dart';
import 'package:petcare/src/models/pet_model.dart';

class PetsPage extends StatelessWidget {
  final petService = new PetService();
  final colorPetCare = Color.fromRGBO(46, 177, 185, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Mascotas')),
      body: Column(
        children: [_createList()],
      ),
    );
  }

  Widget _createList() {
    return FutureBuilder(
        future: petService.getAllPetsByPersonId(1),
        builder:
            (BuildContext context, AsyncSnapshot<List<PetModel>> snapshot) {
          if (snapshot.hasData) {
            final getPets = snapshot.data;
            print(getPets.length);
            return Expanded(
                child: GridView.builder(
              /*  padding: EdgeInsets.only(left: 20.0, top: 30.0), */
              itemCount: getPets.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.90),
              itemBuilder: (context, index) =>
                  _createItem(context, getPets[index]),
            ));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _createItem(BuildContext context, PetModel pet) {
    /* return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(  
                padding: EdgeInsets.all(kDefaultPaddin),
                height: 180,
                width: 160, 
                decoration: BoxDecoration(
                  color: colorPetCare,
                  borderRadius: BorderRadius.circular(25.0)
                ),   
                child: FadeInImage(
                  placeholder: AssetImage('assets/jar-loading.gif'), 
                  image: NetworkImage(pet.photo),
                  /* fit: BoxFit.cover,  */
                )
        ),
        Container(
          child: Text(
           pet.name, style: TextStyle(color: Colors.black)
        ),
        )
      ],
    ); */

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
