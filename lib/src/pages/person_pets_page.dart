import 'package:flutter/material.dart';
import 'package:petcare/constants.dart';
import 'package:petcare/src/services/pet_service.dart';
import 'package:petcare/src/models/pet_model.dart';


class PetsPage extends StatelessWidget {

  final petService = new PetService();
  final colorPetCare = Color.fromRGBO(46, 177, 185, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          _createList()
        ],
      ),
    );
  }

  Widget _createList(){
    return FutureBuilder(
        future: petService.getAllPetsByPersonId(1),
        builder: (BuildContext context,
            AsyncSnapshot<List<PetModel>> snapshot) {
          if (snapshot.hasData) {
            final getPets = snapshot.data;
            print(getPets.length);
            return Expanded(
                child: GridView.builder(
                  itemCount: getPets.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75), 
                  itemBuilder: (context, index) => _createItem(context,getPets[index]),
                ) 
              );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _createItem(BuildContext context, PetModel pet){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(  
                padding: EdgeInsets.all(kDefaultPaddin),
                height: 180,
                width: 160,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(25.0)
                ),   
                child: FadeInImage(
                  placeholder: AssetImage('assets/jar-loading.gif'), 
                  image: NetworkImage(pet.photo),
                  /* fit: BoxFit.cover, */ 
                )
          ),
          Text(pet.name, style: TextStyle(color: colorPetCare),),
          
        
      ],
    );
  }
}

