import 'package:flutter/material.dart';
import '../models/userM.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  User _signedInUser;
  String authToken;
  String regID;

  UserProvider({this.regID,this.authToken});

  User get user {
    return _signedInUser;
  }

  Future<void> fetchUserDataFunction() async {
    final baseURL = 'https://srmap-homs.firebaseio.com/users/$regID.json?auth=$authToken';
    try {
      final response = await http.get(baseURL);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final User newuser = User(
          regID: regID,
          name: data['name'],
          gradYear: data['gradYear'],
          hostelNum: data['hostelNum'],
          roomNum: data['roomNum'],
          phoneNum: data['phoneNum']);
      _signedInUser = newuser;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
