import 'package:flutter/material.dart';
import 'package:petcare/src/models/business_profile_model.dart';
import 'package:petcare/src/services/business_profile_service.dart';

class RegisterBusinessProfile extends StatefulWidget {
  @override
  _RegisterBusinessProfileState createState() => _RegisterBusinessProfileState();
}

class _RegisterBusinessProfileState extends State<RegisterBusinessProfile> {
  
  BusinessProfileModel businessProfileModel = new BusinessProfileModel();
  final businessProfileService = new BusinessProfileService();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar usuario del Negocio' ),
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
            _createButton(),
          ],
        ),
      ),
    );
  }

   Widget _inputName() {
    return TextFormField(
      initialValue: businessProfileModel.name,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Nombres',
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
      onSaved: (newValue) => businessProfileModel.name = newValue,
    );
  }

   Widget _inputLastName() {
    return TextFormField(
      initialValue: businessProfileModel.lastName,
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
      onSaved: (newValue) => businessProfileModel.lastName = newValue,
    );
  }

  Widget _inputPassword() {
    return TextFormField(
      initialValue: businessProfileModel.password,
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
      onSaved: (newValue) => businessProfileModel.password = newValue,
    );
  }

  Widget _inputDocument() {
    return TextFormField(
      initialValue: businessProfileModel.document,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'DNI',
        icon: Icon(Icons.chrome_reader_mode),
        suffixIcon: Icon(Icons.card_travel)
      ),
      onSaved: (newValue) => businessProfileModel.document = newValue,
    );
  }

  Widget _inputEmail() {
    return TextFormField(
      initialValue: businessProfileModel.email,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Email',
        hintText: 'example@mail.com',
        icon: Icon(Icons.alternate_email),
        suffixIcon: Icon(Icons.email)
      ),
      onSaved: (newValue) => businessProfileModel.email = newValue,

    );
  }

  Widget _inputPhone() {
    return TextFormField(
      initialValue: businessProfileModel.phone,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Telefono',
        hintText: 'número telefonico',
        icon: Icon(Icons.phone_android),
        suffixIcon: Icon(Icons.phone)
      ),
      onSaved: (newValue) => businessProfileModel.phone = newValue,
    );
  }

  Widget _inputAge() {
    return TextFormField(
      initialValue: businessProfileModel.age,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Fecha de nacimiento',
        hintText: 'Fecha de nacimiento',
        icon: Icon(Icons.perm_contact_calendar),
        suffixIcon: Icon(Icons.calendar_today)
      ),
      onSaved: (newValue) => businessProfileModel.age = newValue,
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
    );
  }

  void _submit() async {
    if( !formKey.currentState.validate() ) return;
    formKey.currentState.save();
    businessProfileService.registerBusinessProfile(businessProfileModel);    
  }
}