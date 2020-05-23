import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import './helpers/custom_route.dart';
import './screens/aboutS.dart';
import './screens/outpassDetailsS.dart';
import './screens/userProfileS.dart';
import './providers/userP.dart';
import './providers/outpassP.dart';
import './screens/outpassListS.dart';
import './screens/authS.dart';
import './providers/authP.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProxyProvider<AuthProvider, UserProvider>(
          create: (context) => UserProvider(),
          update: (context, auth, prev) => UserProvider(
            authToken: auth.token,
            wRegID: auth.wRegID,
          ),
        ),
        ChangeNotifierProxyProvider<AuthProvider, OutpassProvider>(
          create: (context) => OutpassProvider(),
          update: (context, auth, prev) => OutpassProvider(
            authToken: auth.token,
            hostelNum: auth.hostelNum,
          ),
        )
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'HOMS',
          theme: ThemeData(
            primarySwatch: Colors.red,
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
            pageTransitionsTheme: PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CustomPageTransitionBuilder(),
                TargetPlatform.iOS: CustomPageTransitionBuilder(),
              },
            ),
          ),
          routes: {
            '/': (context) => auth.isAuth ? OutpassListScreen() : AuthScreen(),
            OutpassDetailsScreen.routeName: (context) => OutpassDetailsScreen(),
            AboutScreen.routeName: (context) => AboutScreen(),
            UserProfileScreen.routeName: (context) => UserProfileScreen(),
          },
        ),
      ),
    );
  }
}
