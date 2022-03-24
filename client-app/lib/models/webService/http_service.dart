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

  Future<User?> getUser(String email) async {
    createConnection();

    try {
      Response response = await client.get(
        Uri.parse('http://localhost:8080/user/$email'),
      );

      return User.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e.toString());
      return null;
    } finally {
      closeConnection();
    }
  }

  Future<List<User>?> getAllUsers() async {
    createConnection();

    try {
      Response response = await client.get(
        Uri.parse('http://localhost:8080/users'),
      );

      return _convertResponseToUserCollection(response);
    } catch (e) {
      print(e.toString());
      return null;
    } finally {
      closeConnection();
    }
  }

  List<User>? _convertResponseToUserCollection(Response response) {
    List<User> users = [];

    try {
      return List<User>.from(
          (json.decode(response.body)).map((model) => User.fromJson(model)));
    } catch (e) {
      print(e.toString());
      return null;
    }
    return users;
  }
}
