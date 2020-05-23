import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import '../models/http_exception.dart';

import '../API_KEY.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _wRegID;
  int _hostelNum;

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

  String get wRegID {
    return _wRegID;
  }

  int get hostelNum {
    return _hostelNum;
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
      print(responseData['error']['message']);
      throw HttpException(responseData['error']['message']);
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      final checkURL =
          'https://srmap-homs.firebaseio.com/auth.json?orderBy="email"&equalTo="$email"';
      final checkResponse = await http.get(checkURL);
      final checkData = json.decode(checkResponse.body) as Map<String, dynamic>;
      print(checkData);
      if (checkData.isEmpty) {
        throw HttpException("SRMAP");
      }
      checkData.forEach((key, value) {
        _wRegID = key;
        _hostelNum = value['hostelNum'];
      });
      print(_wRegID);
      print(_hostelNum);
      return _authenticate(email, password, 'signupNewUser');
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final checkURL =
          'https://srmap-homs.firebaseio.com/auth.json?orderBy="email"&equalTo="$email"';
      final checkResponse = await http.get(checkURL);
      final checkData = json.decode(checkResponse.body) as Map<String, dynamic>;
      checkData.forEach((key, value) {
        _wRegID = key;
        _hostelNum = value['hostelNum'];
      });
      return _authenticate(email, password, 'verifyPassword');
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void logout() {
    _token = null;
    _wRegID = null;
    _expiryDate = null;
    notifyListeners();
  }
}
