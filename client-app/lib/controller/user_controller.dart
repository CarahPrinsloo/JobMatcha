import 'package:client_app/models/webService/http_service.dart';
import 'package:client_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserController extends ChangeNotifier {
  final HttpService _httpService = HttpService();
  bool? _isSuccessfulResponse;

  Future<void> addUser(User user) async {
    _isSuccessfulResponse = await _httpService.createUser(user);

    notifyListeners();
  }

  Future<User?> loginUser(String email) async {
    User? user = await _httpService.getUser(email);
    if (user != null) {
      _isSuccessfulResponse = true;
    }

    notifyListeners();
    return user;
  }

  void resetIsSuccessfulResponse() {
    _isSuccessfulResponse = false;
  }

  bool? getIsSuccessfulResponse() {
    return _isSuccessfulResponse;
  }
}