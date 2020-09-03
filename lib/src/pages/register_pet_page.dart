
import 'package:flutter/material.dart';
import 'package:petcare/src/models/pet_model.dart';
import 'package:petcare/src/services/pet_service.dart';
import 'package:petcare/src/storage/storage.dart';
import 'package:petcare/src/utils/utils.dart' as utils;


class RegisterPetPage extends StatefulWidget {

  @override
  _RegisterPetPageState createState() => _RegisterPetPageState();
}

class _RegisterPetPageState extends State<RegisterPetPage> {
  PetModel petModel = new PetModel();

  final petservice = new PetService();

  final formKey = GlobalKey<FormState>();

  final scaffoldKey = GlobalKey<FormState>();

  final _storage = new Storage();

  int userId = 0;

  @override
  void initState() {
    super.initState();
    this.userId = _storage.userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Registrar Mascota'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric( horizontal: 10.0, vertical:  20.0),
          children: <Widget>[
            _inputName(),
            Divider(),
             _inputAge(),
            Divider(),
            _inputBreed(),
            Divider(),
            _inputPhoto(),
            Divider(),
            _inputSex(),
            Divider(),
            _createButton()
          ],
        )),
    );
  }

  Widget _inputName() {
    return TextFormField(
      initialValue: petModel.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Nombre',
        hintText: 'Nombre',
        icon: Icon(Icons.account_circle),
        suffixIcon: Icon(Icons.accessibility)
      ),
      validator: (value) {
        if (value.length < 3 ){
          return 'Nombre minimo a 3 caracteres';
        } else {
          return null;
        }
      },
      onSaved: (newValue) => petModel.name = newValue,
    );
  }

  Widget _inputAge() {
    return TextFormField(
      initialValue: petModel.age.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Edad',
        hintText: 'Edad',
        icon: Icon(Icons.data_usage),
        suffixIcon: Icon(Icons.info)
      ),
      validator: (value) {
          if (utils.isNumeric(value)) {
            return null;
          } else {
            return 'Solo números';
          }
        },
        onSaved: (newValue) => petModel.age = int.parse(newValue)
    );
  }

  Widget _inputBreed() {
    return TextFormField(
      initialValue: petModel.breed,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Raza',
        hintText: 'Raza',
        icon: Icon(Icons.account_circle),
        suffixIcon: Icon(Icons.accessibility)
      ),
      onSaved: (newValue) => petModel.breed = newValue,
    );
  }

  Widget _inputPhoto() {
    return TextFormField(
      initialValue: petModel.photo,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Foto',
        hintText: 'Foto',
        icon: Icon(Icons.account_circle),
        suffixIcon: Icon(Icons.accessibility)
      ),
      onSaved: (newValue) => petModel.photo = newValue,
    );
  }

  Widget _inputSex() {
    return TextFormField(
      initialValue: petModel.gender,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Sexo',
        hintText: 'Sexo',
        icon: Icon(Icons.account_circle),
        suffixIcon: Icon(Icons.accessibility)
      ),
      onSaved: (newValue) => petModel.gender  = newValue,
    );
  }

  Widget _createButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Color.fromRGBO(46, 177, 185, 1.0),
      textColor: Colors.white,
      label: Text('Save'),
      icon: Icon(Icons.save),
      onPressed: () => _submit(),
      // _submit();
    );
  }

  void _submit() async {
    if( !formKey.currentState.validate() ) return;
    formKey.currentState.save();

    print('Todo ok!');
    petservice.registerPet(petModel, userId );

  }


}