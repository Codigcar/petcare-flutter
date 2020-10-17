import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petcare/src/models/request_model.dart';


class BusinessRequestService {
  final String _url = 'http://10.0.2.2:8081/api';

// http://localhost:8081/api/provider/1/requests


  Future<List<RequestModel>> getAllRequestByProviderId(int providerId) async {
    final url = '$_url/provider/'+providerId.toString()+'/requests';
    final resp = await http.get(url);
    List<RequestModel> requests = (json.decode(resp.body) as List).map((data) => RequestModel.fromJson(data)).toList();
    return requests;
  }
}