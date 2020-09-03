import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();
    
    Recuerden que el main() debe de ser async {...

*/

class Storage {

  static final Storage _instancia = new Storage._internal();

  factory Storage() {
    return _instancia;
  }

  Storage._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  /* get nombre {
    return _prefs.getString('nombre') ?? '';
  }

  set nombre( String value ) {
    _prefs.setString('nombre', value);
  } */

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token( String value ) {
    _prefs.setString('token', value);
  }
  
  get userId {
    return _prefs.getInt('userId') ?? 0;
  }
  set userId( int value ) {
    _prefs.setInt('userId', value );
  }

   get businessProfileId {
    return _prefs.getInt('businessProfileId') ?? 0;
  }
  set businessProfileId( int value ) {
    _prefs.setInt('businessProfileId', value );
  }

}

