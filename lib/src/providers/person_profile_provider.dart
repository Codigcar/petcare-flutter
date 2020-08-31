import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petcare/src/models/person_profile_model.dart';

class PersonProfileProvider {
  final String _url = 'http://10.0.2.2:8081/api';

  Future<bool> registerPersonProfile(PersonProfileModel user) async {
    final url = '$_url/people';
    final resp = await http.post(
    url,
    headers: <String, String>{
     'Content-Type': 'application/json; charset=UTF-8',
    },
    body: personProfileModelToJson(user));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    if( resp.statusCode == 200 ){
      return true;
    } else {
      return false;
    }
  }
}