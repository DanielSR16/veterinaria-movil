import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String jwt = "";

  void saveData({required String datos}) {
    jwt = datos;
    print(jwt);
    notifyListeners();
  }
}
