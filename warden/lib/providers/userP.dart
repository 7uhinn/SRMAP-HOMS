import 'package:flutter/material.dart';
import '../models/userM.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class UserProvider with ChangeNotifier {
  List<User> _signedInUser = [];
  final authToken;
  final wRegID;

  UserProvider({this.wRegID, this.authToken});

  List<User> get user {
    return [..._signedInUser];
  }

  Future<void> fetchUserDataFunction() async {
    final baseURL =
        'https://srmap-homs.firebaseio.com/warden/$wRegID.json?auth=$authToken';
    print(baseURL);
    try {
      final response = await http.get(baseURL);
      final data = json.decode(response.body) as Map<String, dynamic>;
      print(data['name']);
      final List<User> dl = [];
      data.forEach((id, value) {
        dl.add(User(
          regID: wRegID,
          joinYear: data['joinYear'],
          name: data['name'],
          hostelNum: data['hostelNum'],
          roomNum: data['roomNum'],
          phoneNum: data['phoneNum'][0],
        ));
      });
      _signedInUser = dl;
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
