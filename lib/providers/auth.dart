import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;

  Future<void> signup(String email, String pass) async {
    const apiUrl = 'AIzaSyBC_p5x_GOfYs3R8yx1aiagvUINDKQZzl4';

    final url = Uri.https(
        'identitytoolkit.googleapis.com/v1/accounts:signUp?key=[$apiUrl]', '');
    final res = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': pass,
          'returnSecureToken': true,
        },
      ),
    );
    print(json.decode(res.body));
  }
}
