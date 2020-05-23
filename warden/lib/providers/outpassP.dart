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
  final hostelNum;

  OutpassProvider({this.authToken, this.hostelNum});

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
    final baseURL =
        'https://srmap-homs.firebaseio.com/users.json?auth=$authToken&orderBy="hostelNum"&equalTo=$hostelNum';
    try {
      final response = await http.get(baseURL);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Outpass> dataList = [];
      data.forEach((id, value) {
        data[id]['outpass'].forEach((idx, val) {
          dataList.insert(
              0,
              Outpass(
                regID: id,
                name: value['name'],
                roomNum: value['roomNum'],
                phoneNum: value['phoneNum'][0],
                outpassID: idx.toString(),
                location: val['location'],
                reqDateTime: val['reqDateTime'],
                arrDateTime: val['arrDateTime'],
                depDateTime: val['depDateTime'],
                outpassStatus: val['outpassStatus'],
              ));
        });
      });
      _outpassData = dataList;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> decisionOutpass(String regID, String outpassID, bool d) async {
    final idx =
        _outpassData.indexWhere((outpass) => outpass.outpassID == outpassID);
    final baseURL =
        'https://srmap-homs.firebaseio.com/users/$regID/outpass/$outpassID.json?auth=$authToken';
    try {
      if (d) {
        await http.patch(baseURL,
            body: json.encode({
              'outpassStatus': 'Approved',
            }));
        _outpassData[idx].outpassStatus = 'Approved';
        notifyListeners();
      } else {
        await http.patch(baseURL,
            body: json.encode({
              'outpassStatus': 'Disapproved',
            }));
        _outpassData[idx].outpassStatus = 'Disapproved';
        notifyListeners();
      }
    } catch (error) {
      _outpassData[idx].outpassStatus = 'Pending';
      throw error;
    }
  }
}
