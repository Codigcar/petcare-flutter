import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:petcare/src/models/person_profile_model.dart';
import 'package:petcare/src/storage/storage.dart';
import 'package:http_parser/http_parser.dart';

class PersonProfileService {
  final String _url = 'http://10.0.2.2:8081/api';
  final _storage = new Storage();

  Future<bool> registerPersonProfile(PersonProfileModel personProfile) async {
    final url = '$_url/people';
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8'
    };
    final resp = await http.post(url,
        headers: headers, body: personProfileModelToJson(personProfile));
    final decodedData = json.decode(resp.body);
    print("id: " + decodedData['id'].toString());
    print(decodedData);
    _storage.userId = decodedData['id'];
    print(_storage.userId);
    if (resp.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> uploadImage(File image) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dggqauzyy/image/upload?upload_preset=sukusvqv');
    final mimeType = mime(image.path).split('/'); // image/jpg o png
    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', image.path,
        contentType: MediaType(mimeType[0], mimeType[1]));

    imageUploadRequest.files.add(file);
    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salió mal');
      print(resp.body); // imprimi el error
      return null;
    }
    final respData = json.decode(resp.body);
    return respData['secure_url'];
  }

  Future<PersonProfileModel> getPersonProfileByEmail(String email) async {
    final url = '$_url/people/email/' + email;
    final resp = await http.get(url);
    PersonProfileModel decodedData =
        PersonProfileModel.fromJson(json.decode(resp.body));
    return decodedData;
  }

  /* Future<List<ProductModel>> getAllProductsByProviderIdAndProductTypeId(int providerId, int productTypeId) async {
    final url = '$_url/business/0/providers/'+providerId.toString()+'/products-type/'+productTypeId.toString()+'/products';
    final resp = await http.get(url);
     List<ProductModel> decodedData = (json.decode(resp.body) as List)
    .map((data) => ProductModel.fromJson(data)).toList();
    return decodedData;
  }*/
}
