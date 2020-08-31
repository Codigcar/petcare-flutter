

import 'package:flutter/material.dart';
import 'package:petcare/src/models/person_profile_model.dart';
import 'package:petcare/src/providers/person_profile_provider.dart';

class RegisterUserPage extends StatefulWidget {
  @override
  _RegisterUserPageState createState() => _RegisterUserPageState();
}

class _RegisterUserPageState extends State<RegisterUserPage> {

  PersonProfileModel personProfileModel = new PersonProfileModel();
  final personProfileProvider = new PersonProfileProvider();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar usuario'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: <Widget>[
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
            _createButton()
          ],
        ),
      ),
    );
  }

  Widget _inputName() {
    return TextFormField(
      initialValue: personProfileModel.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Nombres y Apellidos',
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
      onSaved: (newValue) => personProfileModel.name = newValue,
    );
  }

   Widget _inputLastName() {
    return TextFormField(
      initialValue: personProfileModel.lastName,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Apellidos',
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
        suffixIcon: Icon(Icons.lock)
      ),
      validator: (value) {
        if (value.length < 4) {
          return 'Contraseña mínimo 4 caracteres';
        } else { null; }
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
        suffixIcon: Icon(Icons.card_travel)
      ),
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
        suffixIcon: Icon(Icons.email)
      ),
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
        suffixIcon: Icon(Icons.phone)
      ),
      onSaved: (newValue) => personProfileModel.phone = newValue,
    );
  }

  Widget _inputAge() {
    return TextFormField(
      initialValue: personProfileModel.age,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Fecha de nacimiento',
        hintText: 'Fecha de nacimiento',
        icon: Icon(Icons.perm_contact_calendar),
        suffixIcon: Icon(Icons.calendar_today)
      ),
      onSaved: (newValue) => personProfileModel.age = newValue,
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
    print(personProfileModel.name);
    print(personProfileModel.password);
    print(personProfileModel.lastName);
    print(personProfileModel.document);
    print(personProfileModel.email);
    print(personProfileModel.phone);
    print(personProfileModel.age);

    
    personProfileProvider.registerPersonProfile(personProfileModel);
    /* showSnackbar('Registro guardado'); */

  }

  void showSnackbar(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }

}