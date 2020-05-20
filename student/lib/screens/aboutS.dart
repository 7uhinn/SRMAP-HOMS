import 'package:flutter/material.dart';

import '../widgets/SideDrawerW.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawerWidget(),
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Center(
        child: Text('Stuff'),
      ),
    );
  }
}
