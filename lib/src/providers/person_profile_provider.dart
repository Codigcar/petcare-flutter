import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petcare/src/models/person_profile_model.dart';
import 'package:petcare/src/storage/storage.dart';

class PersonProfileProvider {
  final String _url = 'http://10.0.2.2:8081/api';
  final _storage = new Storage();


  Future<bool> registerPersonProfile(PersonProfileModel personProfile) async {
    final url = '$_url/people';
    Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8'};
    final resp = await http.post( url, headers: headers, body: personProfileModelToJson(personProfile));
    final decodedData = json.decode(resp.body);
    print("id: "+decodedData['id'].toString());
    print(decodedData);

    _storage.userId = decodedData['id'];
    
    print(_storage.userId);

    if( resp.statusCode == 200 ){
      return true;
    } else {
      return false;
    }
  }
}