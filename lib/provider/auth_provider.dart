import 'package:flutter/material.dart';
import 'package:ninja_express_client/net/beckend.dart';

class AuthProvider with ChangeNotifier {
  Future<int> signUp(
      {required String name,
      required String email,
      required String password}) async {
    return Beckend()
        .signUp(name: name, email: email, password: password, type: "client");
  }

  Future<List> login({required String email, required String password}) {
    return Beckend().signIn(email: email, password: password);
  }
}
