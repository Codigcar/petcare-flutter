import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petcare/src/models/account_model.dart';

class AccountService {
  final String _url = 'http://10.0.2.2:8081/api';

  Future<List<AccountModel>> getAllAccounts() async {
    final url = '$_url/accounts';
    final resp = await http.get(url);
     List<AccountModel> decodedData = (json.decode(resp.body) as List)
    .map((data) => AccountModel.fromJson(data)).toList();
    return decodedData;
  }
}