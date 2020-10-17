import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petcare/src/models/request_model.dart';


class RequestService {
  final String _url = 'http://10.0.2.2:8081/api';

 /*  Future<bool> registerPet(PetModel pet, int personProfileId) async {
    final url = '$_url/people/'+personProfileId.toString()+'/pets';
    Map<String, String> headers = {'Content-Type': 'application/json; charset=UTF-8'};
    final resp = await http.post( url, headers: headers, body: petModelToJson(pet));
    final decodedData = json.decode(resp.body);
    /* decodedData.runtimeType.hashCode.id */
    print(decodedData);
    print('Despues de decodedData');
    if( resp.statusCode == 200 ){
      return true;
    } else {
      return false;
    }
  } */

  Future<List<RequestModel>> getAllRequestByPersonId(int personId) async {
    final url = '$_url/people/'+personId.toString()+'/request';
    final resp = await http.get(url);
    List<RequestModel> requests = (json.decode(resp.body) as List).map((data) => RequestModel.fromJson(data)).toList();
    print('-------REQUEST');
    print(requests);
    return requests;

  }
}