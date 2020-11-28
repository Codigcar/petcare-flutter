import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petcare/src/models/business_profile_model.dart';
import 'package:petcare/src/models/business_request_model.dart';
import 'package:petcare/src/models/person_request_model.dart';
import 'package:petcare/src/models/request_model.dart';

class BusinessRequestService {
  final String _url = 'http://10.0.2.2:8081/api';

// http://localhost:8081/api/provider/1/requests

  Future<List<RequestModel>> getAllRequestByProviderId(int providerId) async {
    final url = '$_url/provider/' + providerId.toString() + '/requests';
    final resp = await http.get(url);
    List<RequestModel> requests = (json.decode(resp.body) as List)
        .map((data) => RequestModel.fromJson(data))
        .toList();
    return requests;
  }

  Future<List<BusinessRequestModel>> getPersonByPetId(
      int providerId, int petId) async {
    final url = '$_url/provider/' +
        providerId.toString() +
        '/customers/pets/' +
        petId.toString();
    final resp = await http.get(url);
    List<BusinessRequestModel> businessRequestModel =
        (json.decode(resp.body) as List)
            .map((data) => BusinessRequestModel.fromJson(data))
            .toList();
    return businessRequestModel;
  }

  Future<bool> updateRequest(int personId, int requestId, int statusUp) async {
    final url = '$_url/people/' +
        personId.toString() +
        '/request/' +
        requestId.toString() +
        '/status/' +
        statusUp.toString();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };

    PersonRequestModel request = new PersonRequestModel();
    request.dateReservation = "";
    request.startTime = "";
    request.status = 0;
    final resp = await http.put(url,
        headers: headers, body: personRequestModelToJson(request));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
