import 'package:client_app/models/http_service.dart';
import 'package:client_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class UserController extends ChangeNotifier {
  final HttpService _httpService = HttpService();
  bool? _isSuccessfulResponse;

  Future<void> addUser(User user, BuildContext context) async {
    _isSuccessfulResponse = await _httpService.createUser(user);

    notifyListeners();
  }

  void resetIsSuccessfulResponse() {
    _isSuccessfulResponse = false;
  }

  bool? getIsSuccessfulResponse() {
    return _isSuccessfulResponse;
  }
}