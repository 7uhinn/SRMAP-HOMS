import 'package:flutter/material.dart';
import 'package:student/screens/requestOutpassS.dart';
import '../widgets/outpassListItemW.dart';

class OutpassListScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Outpass List'),
        actions: <Widget>[
          IconButton(
            iconSize: 32,
            icon: Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(RequestOutPassScreen.routeName),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: OutpassListItemWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () => Navigator.of(context).pushNamed(RequestOutPassScreen.routeName),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
