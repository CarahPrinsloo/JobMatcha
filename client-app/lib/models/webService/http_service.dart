import 'dart:convert';

import 'package:client_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpService {
  var client;

  HttpService();

  void createConnection() {
    client = http.Client();
  }

  void closeConnection() {
    client.close();
  }

  Future<bool> createUser(User user) async {
    createConnection();

    try {
      Response response = await client.post(
        Uri.parse('http://localhost:8080/user'),
        body: jsonEncode(user.toJson()),
      );

      return response.statusCode == 201;
    } catch (e) {
      print(e.toString());
      return false;
    } finally {
      closeConnection();
    }
  }
}
