import 'package:flutter/material.dart';
import 'package:student/screens/requestOutpassS.dart';
import '../widgets/outpassListItemW.dart';

class OutpassListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outpass List'),
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
        actions: <Widget>[
          IconButton(
            iconSize: 32,
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(RequestOutPassScreen.routeName),
          )
        ],
      ),
      body: Container(
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
        padding: EdgeInsets.only(
          top: 5,
          right: 10,
          left: 10,
          bottom: 3,
        ),
        child: OutpassListItemWidget(),
      ),
    );
  }
}
