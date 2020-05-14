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
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    return ChangeNotifierProvider.value(
      value: OutpassProvider(),
      child: MaterialApp(
        title: 'HOMS',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Montserrat',
          textTheme: ThemeData.light().textTheme.copyWith(
                subtitle2: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
                headline6: TextStyle(
                  fontSize: 16,
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
