import 'dart:convert';
import 'dart:io';

import 'package:client_app/models/user.dart';
import 'package:http/http.dart' as http;

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
      HttpClientResponse response = await client.post(
        Uri.parse('http://localhost:8080/user'),
        body: jsonEncode(user),
      );

      return response.statusCode == 201;
    } catch (e) {
      return false;
    } finally {
      closeConnection();
    }
  }
}
