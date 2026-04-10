import 'dart:convert';

import 'package:arq_app/app/interfaces/client_http_interface.dart';
import 'package:http/http.dart' as http;

class ResilientClientAdapter implements ClientHttpInterface {
  final http.Client httpClient = http.Client();

  @override
  void addHeader(String token) {}
  @override
  Future<dynamic> get(String url) async {
    try {
      var uri = Uri.parse(url);
      var response = await httpClient.get(uri);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Erro HTTP : ${response.body}');
      }
    } catch (e) {
      throw Exception('Erro na requisição $e');
    }
  }
}
