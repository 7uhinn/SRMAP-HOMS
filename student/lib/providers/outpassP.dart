import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/outpassM.dart';

class OutpassProvider with ChangeNotifier {
  List<Outpass> _outpassData = [
  //   Outpass(
  //     outpassID: 'o1',
  //     regID: 'AP17110010068',
  //     location: 'Vijayawada',
  //     reqDateTime: DateTime.now().toString(),
  //     depDateTime: DateTime.parse('2020-05-13 08:18:04Z').toString(),
  //     arrDateTime: DateTime.parse('2020-05-13 19:18:04Z').toString(),
  //     outpassStatus: 'Pending',
  //   ),
  //   Outpass(
  //     outpassID: 'o2',
  //     regID: 'AP17110010068',
  //     location: 'Jabalpur',
  //     reqDateTime: DateTime.now().toString(),
  //     depDateTime: DateTime.parse('2020-05-10 11:18:04Z').toString(),
  //     arrDateTime: DateTime.parse('2020-05-15 13:18:04Z').toString(),
  //     outpassStatus: 'Disapproved',
  //   ),
  //   Outpass(
  //     outpassID: 'o3',
  //     regID: 'AP17110010068',
  //     location: 'Guntur',
  //     reqDateTime: DateTime.now().toString(),
  //     depDateTime: DateTime.parse('2020-05-12 10:18:04Z').toString(),
  //     arrDateTime: DateTime.parse('2020-05-12 18:18:04Z').toString(),
  //     outpassStatus: 'Approved',
  //   ),
  ];

  final authToken;
  final regID;

  OutpassProvider({this.authToken,this.regID});

  List<Outpass> get outpassData {
    return [..._outpassData];
  }

  Map<String, Object> iconToggler(outpassStatus) {
    if (outpassStatus == 'Pending') {
      return {
        'icon': Icons.error_outline,
        'color': Colors.yellow[700],
      };
    } else if (outpassStatus == 'Approved') {
      return {
        'icon': Icons.check_circle_outline,
        'color': Colors.green[400],
      };
    } else {
      return {
        'icon': Icons.highlight_off,
        'color': Colors.red[400],
      };
    }
  }

  Future<void> fetchOutpassDataFunction() async {
    final baseURL = 'https://srmap-homs.firebaseio.com/users/$regID/outpass.json?auth=$authToken';
    try {
      final response = await http.get(baseURL);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Outpass> dataList = [];
      data.forEach((id, value) {
        dataList.insert(
            0,
            Outpass(
              outpassID: id,
              location: value['location'],
              arrDateTime: value['arrDateTime'],
              depDateTime: value['depDateTime'],
              reqDateTime: value['reqDateTime'],
              outpassStatus: value['outpassStatus'],
            ));
      });
      _outpassData = dataList;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> reqOutpassFunction(Outpass o) async {
    final baseURL = 'https://srmap-homs.firebaseio.com/users/$regID/outpass.json?auth=$authToken';
    try {
      final response = await http.post(baseURL,
          body: json.encode({
            'location': o.location,
            'reqDateTime': o.reqDateTime,
            'depDateTime': o.depDateTime,
            'arrDateTime': o.arrDateTime,
            'outpassStatus': o.outpassStatus
          }));
      final newOutpass = Outpass(
        outpassID: json.decode(response.body)['name'],
        location: o.location,
        reqDateTime: o.reqDateTime,
        depDateTime: o.depDateTime,
        arrDateTime: o.arrDateTime,
        outpassStatus: o.outpassStatus,
      );

      _outpassData.insert(0, newOutpass);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
