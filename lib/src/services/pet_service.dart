import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:petcare/src/models/pet_model.dart';
import 'package:http_parser/http_parser.dart';


class PetService {
  final String _url = 'http://10.0.2.2:8081/api';

  Future<bool> registerPet(PetModel pet, int personProfileId) async {
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
}