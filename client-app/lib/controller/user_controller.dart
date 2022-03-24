import 'package:client_app/models/webService/http_service.dart';
import 'package:client_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserController extends ChangeNotifier {
  final HttpService _httpService = HttpService();
  bool? _isSuccessfulResponse;

  List<User> users = [];

  Future<void> addUser(User user) async {
    _isSuccessfulResponse = await _httpService.createUser(user);

    notifyListeners();
  }

  Future<User?> getUser(String email) async {
    User? user = await _httpService.getUser(email);
    if (user != null) {
      _isSuccessfulResponse = true;
    }

    notifyListeners();
    return user;
  }

  Future<void> populateUsers() async {
    List<User>? users = await _httpService.getAllUsers();
    if (users != null) {
      _isSuccessfulResponse = true;
      this.users = users;
    }

    notifyListeners();
  }

  void resetIsSuccessfulResponse() {
    _isSuccessfulResponse = false;
  }

  bool? getIsSuccessfulResponse() {
    return _isSuccessfulResponse;
  }
}