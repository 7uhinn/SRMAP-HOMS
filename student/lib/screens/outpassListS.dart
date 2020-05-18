import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/providers/outpassP.dart';

import './requestOutpassS.dart';
import '../widgets/outpassListItemW.dart';

class OutpassListScreen extends StatefulWidget {
  @override
  _OutpassListScreenState createState() => _OutpassListScreenState();
}

class _OutpassListScreenState extends State<OutpassListScreen> {
  bool _isInit = true;
  bool _progress = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<OutpassProvider>(context)
          .fetchOutpassDataFunction()
          .then((_) {
        _progress = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

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
        child: _progress
            ? Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.center,
                child: Container(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    backgroundColor: Colors.white,
                  ),
                ),
              )
            : OutpassListItemWidget(),
      ),
    );
  }
}
