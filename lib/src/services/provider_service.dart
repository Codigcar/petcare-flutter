import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petcare/src/models/provider_model.dart';

class ProviderService {
  final String _url = 'http://10.0.2.2:8081/api';

  Future<bool> registerProvider(
      ProviderModel provider, int businessProfileId) async {
    final url = '$_url/business/' + businessProfileId.toString() + '/providers';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final resp = await http.post(url,
        headers: headers, body: providerModelToJson(provider));
    final decodedData = json.decode(resp.body);
    print(decodedData);
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<ProviderModel>> getAllProviders() async {
    final url = '$_url/providers';
    final resp = await http.get(url);
    List<ProviderModel> decodedData = (json.decode(resp.body) as List)
        .map((data) => ProviderModel.fromJson(data))
        .toList();
    return decodedData;
  }

  Future<ProviderModel> getAllProviderByProviderId(
      int personId, int providerId) async {
    final url = '$_url/business/' +
        personId.toString() +
        '/providers/' +
        providerId.toString();
    final resp = await http.get(url);
    ProviderModel decodedData = ProviderModel.fromJson(json.decode(resp.body));
    return decodedData;
  }
}
