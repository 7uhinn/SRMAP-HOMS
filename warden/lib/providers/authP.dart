import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import '../providers/userP.dart';
import '../models/http_exception.dart';

import '../API_KEY.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _regID;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get regID{
    return _regID;
  }

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

    _token = responseData['idToken'];
    _expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(
          responseData['expiresIn'],
        ),
      ),
    );
    notifyListeners();

    if (responseData['error'] != null) {
      throw HttpException(responseData['error']['message']);
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      final checkURL =
          'https://srmap-homs.firebaseio.com/auth.json?orderBy="email"&equalTo="$email"';
      final checkResponse = await http.get(checkURL);
      final checkData = json.decode(checkResponse.body) as Map<String, dynamic>;
      if (checkData.isEmpty) {
        throw HttpException("SRMAP");
      }
      _regID = checkData.toString().substring(1,14);
      return _authenticate(email, password, 'signupNewUser');
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final checkURL =
          'https://srmap-homs.firebaseio.com/auth.json?orderBy="email"&equalTo="$email"';
      final checkResponse = await http.get(checkURL);
      final checkData = json.decode(checkResponse.body) as Map<String, dynamic>;
      _regID = checkData.toString().substring(1,14);
      return _authenticate(email, password, 'verifyPassword');
    } catch (error) {
      throw error;
    }
  }

  void logout(){
    _token = null;
    _regID = null;
    _expiryDate = null;
    notifyListeners();
  }
}
