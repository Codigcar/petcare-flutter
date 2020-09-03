import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petcare/src/models/business_profile_model.dart';
import 'package:petcare/src/storage/storage.dart';

class BusinessProfileProvider {
  final String _url = 'http://10.0.2.2:8081/api';
  final _storage = new Storage();


  Future<bool> registerBusinessProfile(BusinessProfileModel businessProfile) async {
    final url = '$_url/business';
    Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8'};
    final resp = await http.post( url, headers: headers, body: businessProfileModelToJson(businessProfile));
    final decodedData = json.decode(resp.body);
    print("id: "+decodedData['id'].toString());
    print(decodedData);
    _storage.businessProfileId = decodedData['id'];
    if( resp.statusCode == 200 ){
      return true;
    } else {
      return false;
    }
  }
}