import 'package:flutter/material.dart';
import 'package:petcare/src/models/provider_model.dart';
import 'package:petcare/src/services/provider_service.dart';
import 'package:petcare/src/storage/storage.dart';


class RegisterProviderPage extends StatefulWidget {
  @override
  _RegisterProviderState createState() => _RegisterProviderState();
}

class _RegisterProviderState extends State<RegisterProviderPage> {

  ProviderModel providerModel = new ProviderModel();
  final providerService = new ProviderService();
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _storage = new Storage();
  int businessProfileId = 0;

  @override
  void initState() {
    super.initState();
    this.businessProfileId = _storage.businessProfileId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Veterinaria ' + businessProfileId.toString() ),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: <Widget>[
            _inputName(),
            Divider(),
            _inputRegion(),
            Divider(),
            _inputAddress(),
            Divider(),
            _inputPhoto(),
            Divider(),
            _inputField(),
            Divider(),
            _inputEmail(),
            Divider(),
            _inputDescription(),
            Divider(),
            _createButton(),
          ],
        ),
      ),
    );
  }

  
  Widget _inputName() {
    return TextFormField(
      initialValue: providerModel.businessName,
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
      onSaved: (newValue) => providerModel.businessName = newValue,
    );
  }

  Widget _inputRegion() {
    return TextFormField(
      initialValue: providerModel.region,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Region',
        hintText: 'Region',
        icon: Icon(Icons.account_circle),
        suffixIcon: Icon(Icons.accessibility)
      ),
      onSaved: (newValue) => providerModel.region = newValue,
    );
  }

  Widget _inputAddress() {
    return TextFormField(
      initialValue: providerModel.address,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Dirección',
        hintText: 'Dirección',
        icon: Icon(Icons.account_circle),
        suffixIcon: Icon(Icons.accessibility)
      ),
      onSaved: (newValue) => providerModel.address = newValue,
    );
  }

  Widget _inputPhoto() {
    return TextFormField(
      initialValue: providerModel.photo,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Foto',
        hintText: 'Foto',
        icon: Icon(Icons.account_circle),
        suffixIcon: Icon(Icons.accessibility)
      ),
      onSaved: (newValue) => providerModel.photo = newValue,
    );
  }

  Widget _inputField() {
    return TextFormField(
      initialValue: providerModel.field,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Campo',
        hintText: 'Campo',
        icon: Icon(Icons.account_circle),
        suffixIcon: Icon(Icons.accessibility)
      ),
      onSaved: (newValue) => providerModel.field  = newValue,
    );
  }

  Widget _inputEmail() {
      return TextFormField(
        initialValue: providerModel.email,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: 'Email',
          hintText: 'example@mail.com',
          icon: Icon(Icons.alternate_email),
          suffixIcon: Icon(Icons.email)
        ),
        onSaved: (newValue) => providerModel.email = newValue,

      );
    }

  Widget _inputDescription() {
    return TextFormField(
      initialValue: providerModel.description,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        labelText: 'Descripción',
        hintText: 'Descripción',
        icon: Icon(Icons.account_circle),
        suffixIcon: Icon(Icons.accessibility)
      ),
      onSaved: (newValue) => providerModel.description  = newValue,
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
    providerService.registerProvider(providerModel, businessProfileId );

  }

}