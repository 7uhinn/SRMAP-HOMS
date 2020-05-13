import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import './providers/outpassP.dart';
import './screens/requestOutpassS.dart';

import './screens/outpassListS.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ChangeNotifierProvider.value(
      value: OutpassProvider(),
      child: MaterialApp(
        title: 'HOMS',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          accentColor: Colors.teal[100],
          fontFamily: 'Montserrat',
          textTheme: ThemeData.light().textTheme.copyWith(
                subtitle2: TextStyle(
                  color: Colors.grey,
                ),
                headline6: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Raleway',
                ),
              ),
        ),
        routes: {
          '/': (context) => OutpassListScreen(),
          RequestOutPassScreen.routeName: (context) => RequestOutPassScreen(),
        },
      ),
    );
  }
}
