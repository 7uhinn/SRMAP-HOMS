import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import '../models/http_exception.dart';

import '../API_KEY.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=$FIREBASE_API_KEY';
    final response = await http.post(
      url,
      body: json.encode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    final responseData = json.decode(response.body);
    if(responseData['error'] != null){
      throw HttpException(responseData['error']['message']);
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      final checkURL = 'https://srmap-homs.firebaseio.com/auth.json?orderBy="email"&equalTo="$email"';
      final checkResponse = await http.get(checkURL);
      final checkData = json.decode(checkResponse.body) as Map<String, dynamic>;
      if (checkData.isEmpty) {
        throw HttpException("SRMAP");
      }
      return _authenticate(email, password, 'signupNewUser');
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      return _authenticate(email, password, 'verifyPassword');
    } catch (error) {
      throw error;
    }
  }
}
