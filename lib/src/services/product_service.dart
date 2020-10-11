import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petcare/src/models/product_model.dart';


class ProductService {
  final String _url = 'http://10.0.2.2:8081/api';

  Future<List<ProductModel>> getAllProductsByProviderIdAndProductTypeId(int providerId, int productTypeId) async {
    final url = '$_url/business/0/providers/'+providerId.toString()+'/products-type/'+productTypeId.toString()+'/products';
    final resp = await http.get(url);
     List<ProductModel> decodedData = (json.decode(resp.body) as List)
    .map((data) => ProductModel.fromJson(data)).toList();
    return decodedData;
  }
}