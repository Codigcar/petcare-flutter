import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcare/constants.dart';
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

  int userId = 1;

  File foto;

  @override
  void initState() {
    super.initState();
    //this.userId = _storage.userId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Registrar Mascota'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.photo_size_select_actual),
              onPressed: _selectPhoto),
          IconButton(icon: Icon(Icons.camera_alt), onPressed: _takePhoto),
        ],
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: <Widget>[
            _showPhoto(),
            Divider(),
            _inputName(),
            Divider(),
            _inputAge(),
            Divider(),
            _inputBreed(),
            Divider(),
            /* _inputPhoto(), */
            Divider(),
            _inputSex(),
            Divider(),
            _createButton()
          ],
        ),
      ),
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
          suffixIcon: Icon(Icons.accessibility)),
      validator: (value) {
        if (value.length < 3) {
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
            suffixIcon: Icon(Icons.info)),
        validator: (value) {
          if (utils.isNumeric(value)) {
            return null;
          } else {
            return 'Solo números';
          }
        },
        onSaved: (newValue) => petModel.age = int.parse(newValue));
  }

  Widget _inputBreed() {
    return TextFormField(
      initialValue: petModel.breed,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: 'Raza',
          hintText: 'Raza',
          icon: Icon(Icons.account_circle),
          suffixIcon: Icon(Icons.accessibility)),
      onSaved: (newValue) => petModel.breed = newValue,
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
          suffixIcon: Icon(Icons.accessibility)),
      onSaved: (newValue) => petModel.gender = newValue,
    );
  }

  Widget _createButton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Color.fromRGBO(46, 177, 185, 1.0),
      textColor: Colors.white,
      label: Text('Guardar Datos'),
      icon: Icon(Icons.save),
      onPressed: () => _submit(),
    );
  }

  /* void _submit() async {
    if( !formKey.currentState.validate() ) return;
    formKey.currentState.save();

    print('Todo ok!');
    petservice.registerPet(petModel, userId );

  } */

  Widget _showPhoto() {
    if (petModel.photo != null) {
      /*  return FadeInImage(
        placeholder: AssetImage('assets/jar-loading.gif'),
        image: NetworkImage(personProfileModel.photo),
        height: 300.0,
        fit: BoxFit.contain,
      ); */
      return Container();
    } else {
      return Container(
        child: foto == null
            ? Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorPetCare,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    radius: 50,
                  ),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorPetCare,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CircleAvatar(
                    child: ClipOval(
                      child: Container(
                        width: 90,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Image.file(foto),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
        /* Image.file(foto) */
        height: 100,
        width: 100,
        padding: EdgeInsets.only(left: 10.0),
      );
    }
  }

  _processImage(ImageSource origin) async {
    final fotonew = await ImagePicker.pickImage(source: origin);
    if (foto != null) {
      petModel.photo = null;
    }
    setState(() {
      foto = fotonew;
    });
  }

  _selectPhoto() async {
    _processImage(ImageSource.gallery);
  }

  _takePhoto() async {
    _processImage(ImageSource.camera);
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    if (foto != null) {
      petModel.photo = await petservice.uploadImage(foto);
      print(petModel.photo);
    }
    petservice.registerPet(petModel, this.userId);
    Navigator.pushReplacementNamed(context, 'menu_navbar');
  }
}
