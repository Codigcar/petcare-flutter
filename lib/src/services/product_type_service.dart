import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';
import 'package:petcare/src/models/product_type_model.dart';


class ProductTypeService {
  final String _url = 'http://10.0.2.2:8081/api';

  Future<List<ProductTypeModel>> getAllProducsType() async {
    final url = '$_url/admin/product-types';
    final resp = await http.get(url);
     List<ProductTypeModel> decodedData = (json.decode(resp.body) as List)
    .map((data) => ProductTypeModel.fromJson(data)).toList();
    return decodedData;
  }
}