import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petcare/src/models/product_type_model.dart';


class ProviderJoinProductTypeService {
  final String _url = 'http://10.0.2.2:8081/api';

  Future<List<ProductTypeModel>> getProductTypeByProviderId(int providerId) async {
    final url = '$_url/provider/'+providerId.toString()+'/products-types';
    final resp = await http.get(url);
     List<ProductTypeModel> decodedData = (json.decode(resp.body) as List)
    .map((data) => ProductTypeModel.fromJson(data)).toList();
    return decodedData;
  }
}