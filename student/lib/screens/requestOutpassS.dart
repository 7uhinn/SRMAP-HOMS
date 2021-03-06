import 'package:flutter/material.dart';
import 'package:student/widgets/requestOutpassFormW.dart';

class RequestOutPassScreen extends StatelessWidget {
  static const routeName = '/request-outpass-screen';

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Request Outpass',
      ),
      elevation: 0,
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue[800],
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: appBar,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue[800],
              Theme.of(context).primaryColor,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(35),
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.20,
              width: double.infinity,
              child: Image.asset(
                'assets/images/srmap.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.02,
            ),
            Flexible(
              child: Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.70,
                child: RequestOutpassFormWidget(),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.08,
            ),
          ],
        ),
      ),
    );
  }
}
