import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import './screens/outpassListS.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'HOMS',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.teal[100],
        fontFamily: 'Monteserrat',
        textTheme: ThemeData.light().textTheme.copyWith(
              subtitle: TextStyle(
                color: Colors.grey,
              ),
              title: TextStyle(
                fontSize: 24,
                fontFamily: 'Raleway',
              ),
            ),
      ),
      home: OutpassListScreen(),
    );
  }
}
