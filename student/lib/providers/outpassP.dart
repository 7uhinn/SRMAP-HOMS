import 'package:flutter/material.dart';

import '../models/outpassM.dart';

class OutpassProvider with ChangeNotifier {
  List<Outpass> _outpassData = [
    Outpass(
      outpassID: 'o1',
      regID: 'AP17110010068',
      location: 'Vijayawada',
      reqDateTime: DateTime.now(),
      depDateTime: DateTime.parse('2020-05-13 08:18:04Z'),
      arrDateTime: DateTime.parse('2020-05-13 19:18:04Z'),
      outpassStatus: OutpassStatus.Pending,
    ),
    Outpass(
      outpassID: 'o2',
      regID: 'AP17110010068',
      location: 'Jabalpur',
      reqDateTime: DateTime.now(),
      depDateTime: DateTime.parse('2020-05-10 11:18:04Z'),
      arrDateTime: DateTime.parse('2020-05-15 13:18:04Z'),
      outpassStatus: OutpassStatus.Disapproved,
    ),
    Outpass(
      outpassID: 'o3',
      regID: 'AP17110010068',
      location: 'Guntur',
      reqDateTime: DateTime.now(),
      depDateTime: DateTime.parse('2020-05-12 10:18:04Z'),
      arrDateTime: DateTime.parse('2020-05-12 18:18:04Z'),
      outpassStatus: OutpassStatus.Approved,
    ),
  ];

  List<Outpass> get outpassData {
    return [..._outpassData];
  }

  Map<String, Object> iconToggler(outpassStatus) {
    if (outpassStatus == OutpassStatus.Pending) {
      return {
        'icon': Icons.error_outline,
        'color': Colors.yellow[700],
      };
    } else if (outpassStatus == OutpassStatus.Approved) {
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

  void reqOutpassFunction() {
    notifyListeners();
  }
}
