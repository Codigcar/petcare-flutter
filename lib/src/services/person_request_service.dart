import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petcare/src/models/person_request_model.dart';
import 'package:petcare/src/models/request_model.dart';

class RequestService {
  final String _url = 'http://10.0.2.2:8081/api';

  Future<bool> registerRequest(PersonRequestModel personRequest, int peopleId,
      int petId, int providerId, int productTypeId, int productId) async {
    final url = '$_url/people/' +
        peopleId.toString() +
        '/pets/' +
        petId.toString() +
        '/providers/' +
        providerId.toString() +
        '/productType/' +
        productTypeId.toString() +
        '/products/' +
        productId.toString() +
        '/requests';

    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final resp = await http.post(url,
        headers: headers, body: personRequestModelToJson(personRequest));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    print('Despues de decodedData');
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<RequestModel>> getAllRequestByPersonId(int personId) async {
    final url = '$_url/people/' + personId.toString() + '/request';
    final resp = await http.get(url);
    List<RequestModel> requests = (json.decode(resp.body) as List)
        .map((data) => RequestModel.fromJson(data))
        .toList();
    print('-------REQUEST');
    print(requests);
    return requests;
  }
}
