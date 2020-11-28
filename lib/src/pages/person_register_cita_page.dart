import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcare/src/models/person_request_model.dart';
import 'package:petcare/src/models/pet_model.dart';
import 'package:petcare/src/models/product_model.dart';
import 'package:petcare/src/models/provider_model.dart';
import 'package:petcare/src/services/person_request_service.dart';
import 'package:petcare/src/services/pet_service.dart';
import 'package:petcare/src/storage/storage.dart';
import 'package:petcare/src/utils/utils.dart' as utils;

import '../../constants.dart';

class RegisterCitaPage extends StatefulWidget {
  @override
  _RegisterCitaPageState createState() => _RegisterCitaPageState();
}

class _RegisterCitaPageState extends State<RegisterCitaPage> {
  final colorPetCare = Color.fromRGBO(46, 177, 185, 1.0);
  TextEditingController _inputFieldDateController = new TextEditingController();
  String _date = '';
  final petServide = new PetService();
  List<PetModel> petList = new List<PetModel>();
  final _storage = new Storage();
  String _selectedOption = 'negrote';

  PersonRequestModel personRequestModel = new PersonRequestModel();
  final requestService = new RequestService();
  int _selectedPet = 1;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadPetSelectedOption();
  }

  @override
  Widget build(BuildContext context) {
    final List<Object> objectList = ModalRoute.of(context).settings.arguments;
    final ProviderModel getProvider = objectList[0];
    final ProductModel getProduct = objectList[1];

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(color: colorPetCare),
                ),
              ],
            ),
          ),
          // formulario
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: 0.9,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(150.0),
                            bottomRight: Radius.circular(150.0),
                          ),
                          color: colorPetCare,
                        ),
                        child: Center(
                          child: Text(
                            '¡REGISTRA TU CITA!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 40,
                      left: 0,
                      right: 0,
                      child: Form(
                        key: formKey,
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 60.0),
                              _categoryName(getProvider),
                              SizedBox(height: 30.0),
                              _serviceName(getProduct),
                              SizedBox(height: 30.0),
                              _createDate(context),
                              SizedBox(height: 30.0),
                              _startTime(),
                              SizedBox(height: 30.0),
                              _dropDown(),
                              SizedBox(height: 80.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 40,
            right: 220,
            child: _buttonCancel(),
          ),
          Positioned(
            bottom: 50,
            right: 40,
            left: 220,
            child: _buttonRequest(getProvider, getProduct),
          ),
        ],
      ),
    );
  }

  _loadPetSelectedOption() async {
    final resp = await petServide
        .getAllPetsByPersonId(_storage.personProfileId)
        .then((value) => _selectedOption = value[0].name);
  }

  List<DropdownMenuItem<String>> getOptionsDropdown(
      List<PetModel> listproductsType) {
    List<DropdownMenuItem<String>> list = new List();
    listproductsType.forEach((element) {
      list.add(DropdownMenuItem(
        child: Text(element.name),
        value: element.name,
      ));
    });
    return list;
  }

  Widget _dropDown() {
    return FutureBuilder(
      future: petServide.getAllPetsByPersonId(_storage.personProfileId),
      builder: (BuildContext context, AsyncSnapshot<List<PetModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          petList = snapshot.data;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 35.0, vertical: 0.0),
            child: Row(
              children: <Widget>[
                Icon(Icons.pets),
                Text('  '),
                DropdownButton(
                  style: TextStyle(color: colorPetCare, fontSize: 18.0),
                  elevation: 20,
                  icon: Icon(Icons.arrow_downward),
                  underline: Container(
                    height: 2,
                    color: colorPetCare2,
                  ),
                  value: _selectedOption,
                  items: getOptionsDropdown(petList),
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                      for (var i = 0; i < snapshot.data.length; i++) {
                        if (snapshot.data[i].name == _selectedOption) {
                          _selectedPet = snapshot.data[i].id;
                        }
                      }
                    });
                  },
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget _buttonCancel() {
    return Container(
      width: 50,
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: RaisedButton(
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: Colors.white,
        textColor: colorPetCare,
        child: Text('Cancelar'),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _categoryName(ProviderModel provider) {
    return TextFormField(
      initialValue: provider.businessName,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: 'Veterinaria',
          hintText: 'Veterinaria',
          icon: Icon(Icons.account_circle),
          suffixIcon: Icon(Icons.accessibility)),
      validator: (value) {
        if (value.length < 3) {
          return 'Nombre minimo a 3 caracteres';
        } else {
          return null;
        }
      },
      onSaved: (newValue) => /* petModel.name = newValue */ {},
    );
  }

  Widget _serviceName(ProductModel product) {
    return TextFormField(
      initialValue: product.name,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: 'Servicio',
          hintText: 'Servicio',
          icon: Icon(Icons.account_circle),
          suffixIcon: Icon(Icons.accessibility)),
      validator: (value) {
        if (value.length < 3) {
          return 'Nombre minimo a 3 caracteres';
        } else {
          return null;
        }
      },
      onSaved: (newValue) => {},
    );
  }

  Widget _createDate(BuildContext context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
        hintText: 'Fecha',
        labelText: 'Fecha',
        suffixIcon: Icon(Icons.perm_contact_calendar),
        icon: Icon(Icons.calendar_today),
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  String convertDateTimeDisplay(String date) {
    final DateFormat displayFormater = DateFormat('yyyy-MM-dd HH:mm:ss.SSS');
    final DateFormat serverFormater = DateFormat('dd-MM-yyyy');
    final DateTime displayDate = displayFormater.parse(date);
    final String formatted = serverFormater.format(displayDate);
    return formatted;
  }

  void _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime.now(),
      lastDate: new DateTime(2024),
      locale: Locale('es', 'ES'),
    );

    if (picked != null) {
      setState(() {
        _date = picked.toString();
        _date = convertDateTimeDisplay(_date);
        _inputFieldDateController.text = _date;
        personRequestModel.dateReservation = _date;
      });
    }
  }

  Widget _startTime() {
    return TextFormField(
      initialValue: personRequestModel.startTime,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          labelText: 'Hora',
          hintText: 'Hora',
          icon: Icon(Icons.data_usage),
          suffixIcon: Icon(Icons.info)),
      /* validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo números';
        }
      }, */
      onSaved: (newValue) => personRequestModel.startTime = newValue,
    );
  }

  _buttonRequest(ProviderModel getProvider, ProductModel getProduct) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: RaisedButton(
        elevation: 10.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: colorPetCare,
        textColor: Colors.white,
        child: Text('Aceptar'),
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                /* title: Text('Registrar cita'),
                content: Text('Quieres continuar con el registro de la cita?'), */
                /* actions: [
              FlatButton(
                onPressed: () {},
                child: Text('Cancelar'),
              ),
              FlatButton(
                onPressed: () {},
                child: Text('Aceptar'),
              ),
            ], */
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                title: Text('Registrar cita'),
                content: Text('¿Quieres continuar con el registro de la cita?'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cancelar')),
                  FlatButton(
                    onPressed: () {
                      personRequestModel.status = 0;
                      personRequestModel.startTime = "2:00";

                      if (!formKey.currentState.validate()) return;
                      formKey.currentState.save();
                      requestService.registerRequest(personRequestModel, 1,
                          _selectedPet, getProvider.id, 1, getProduct.id);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text('Ok'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
