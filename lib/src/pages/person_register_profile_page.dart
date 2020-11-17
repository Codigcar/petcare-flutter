import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petcare/constants.dart';
import 'package:petcare/src/models/person_profile_model.dart';
import 'package:petcare/src/services/person_profile_service.dart';

class RegisterPersonProfilePage extends StatefulWidget {
  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterPersonProfilePage> {
  PersonProfileModel personProfileModel = new PersonProfileModel();
  final personProfileService = new PersonProfileService();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  /* final _storage = new Storage(); */
/*   int userId = 0; */
  File foto;

  @override
  void initState() {
    super.initState();

    if (personProfileModel.photo == null) {
      print("está null personProfileModel.phtoo");
    }
    /* this.userId = _storage.userId; */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos Personales'),
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
            Divider(),
            _inputName(),
            Divider(),
            _inputLastName(),
            Divider(),
            _inputPassword(),
            Divider(),
            _inputDocument(),
            Divider(),
            _inputEmail(),
            Divider(),
            _inputPhone(),
            Divider(),
            _inputAge(),
            Divider(),
            _createButton(),
            Divider(),
            /*  _buttonNextPet(context) */
          ],
        ),
      ),
    );
  }

  Widget _inputName() {
    return Container(
      child: TextFormField(
        initialValue: personProfileModel.name,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            labelText: 'Nombres',
            icon: Icon(Icons.account_circle),
            suffixIcon: Icon(Icons.accessibility)),
        validator: (value) {
          if (value.length < 3) {
            return 'Nombre minimo a 3 caracteres';
          } else {
            return null;
          }
        },
        onSaved: (newValue) => personProfileModel.name = newValue,
      ),
      width: 280,
    );
  }

  Widget _inputLastName() {
    return TextFormField(
      initialValue: personProfileModel.lastName,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: 'Apellidos',
          icon: Icon(Icons.account_circle),
          suffixIcon: Icon(Icons.accessibility)),
      validator: (value) {
        if (value.length < 3) {
          return 'Nombre minimo a 3 caracteres';
        } else {
          return null;
        }
      },
      onSaved: (newValue) => personProfileModel.lastName = newValue,
    );
  }

  Widget _inputPassword() {
    return TextFormField(
      initialValue: personProfileModel.password,
      obscureText: true,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: 'Contraseña',
          hintText: 'Contraseña',
          icon: Icon(Icons.lock_open),
          suffixIcon: Icon(Icons.lock)),
      validator: (value) {
        if (value.length < 4) {
          return 'Contraseña mínimo 4 caracteres';
        } else {
          null;
        }
      },
      onSaved: (newValue) => personProfileModel.password = newValue,
    );
  }

  Widget _inputDocument() {
    return TextFormField(
      initialValue: personProfileModel.document,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: 'DNI',
          icon: Icon(Icons.chrome_reader_mode),
          suffixIcon: Icon(Icons.card_travel)),
      onSaved: (newValue) => personProfileModel.document = newValue,
    );
  }

  Widget _inputEmail() {
    return TextFormField(
      initialValue: personProfileModel.email,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: 'Email',
          hintText: 'example@mail.com',
          icon: Icon(Icons.alternate_email),
          suffixIcon: Icon(Icons.email)),
      onSaved: (newValue) => personProfileModel.email = newValue,
    );
  }

  Widget _inputPhone() {
    return TextFormField(
      initialValue: personProfileModel.phone,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: 'Telefono',
          hintText: 'número telefonico',
          icon: Icon(Icons.phone_android),
          suffixIcon: Icon(Icons.phone)),
      onSaved: (newValue) => personProfileModel.phone = newValue,
    );
  }

  Widget _inputAge() {
    return TextFormField(
      initialValue: personProfileModel.age,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: 'Edad',
          hintText: 'Edad',
          icon: Icon(Icons.perm_contact_calendar),
          suffixIcon: Icon(Icons.calendar_today)),
      onSaved: (newValue) => personProfileModel.age = newValue,
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

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();
    if (foto != null) {
      personProfileModel.photo = await personProfileService.uploadImage(foto);
      print(personProfileModel.photo);
    }
    personProfileService.registerPersonProfile(personProfileModel);
    Navigator.pushReplacementNamed(context, 'register_pet');
  }

  void showSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _buttonNextPet(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        Navigator.pushNamed(context, 'register_pet');
      },
    );
  }

  Widget _showPhoto() {
    if (personProfileModel.photo != null) {
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
                    /* child: ClipOval(
                      child: Image.asset('assets/no-image.png'),
                    ), */
                  ),
                ),
              )

            /*CircleAvatar(
                radius: 50,

                 child: ClipOval(
                  child: Container(
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Image.asset('assets/no-image.png'),
                    ),
                  ),
                ), 
              )*/
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
      /* Image(

        image: AssetImage( foto == null ? 'assets/no-image.png' : foto.path),
        height: 300.0,
        fit: BoxFit.cover,

      ); */
    }
  }

  _processImage(ImageSource origin) async {
    final fotonew = await ImagePicker.pickImage(source: origin);
    if (foto != null) {
      personProfileModel.photo = null;
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
}
