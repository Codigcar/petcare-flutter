
import 'dart:convert';

import 'package:http/http.dart' as http;

class UserProvider {
  
  final String _firebaseToken = 'AIzaSyD1eKlsC0497JR4rmkj7n0MoLyMYEKCV4I';

  Future registerUser ( String email, String password ) async {
    final authData = {
      'email'     : email,
      'password'  : password,
      'returnSecureToken': true
    };

    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseToken',
      body: json.encode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print( decodedResp );

    if ( decodedResp.containsKey('idToken') ) {
      //TODO: Salvar el token en el storage
      return { 'ok':true, 'token': decodedResp['idToken'] };
    } else {
      return { 'ok':false, 'mensaje': decodedResp['error']['message'] };
    }
  }
}