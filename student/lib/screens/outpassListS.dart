import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/providers/outpassP.dart';
import 'package:student/widgets/SideDrawerW.dart';

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
          .catchError((error) {
        if (error.toString().contains('NoSuchMethod')) {
          setState(() {
            _progress = false;
          });
        } else {
          return showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(
                'Oops!',
                style: TextStyle(
                  color: Theme.of(ctx).primaryColor,
                  fontFamily: 'Raleway',
                ),
              ),
              content: Text(
                'Something went wrong! Check your internet connection.',
                style: TextStyle(
                  fontFamily: 'Montserrat',
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    'Okay',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                )
              ],
            ),
          );
        }
      }).then((_) {
        setState(() {
          _progress = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshScreen(BuildContext context) async {
    await Provider.of<OutpassProvider>(context, listen: false)
        .fetchOutpassDataFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawerWidget(),
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
            : RefreshIndicator(
                onRefresh: () => _refreshScreen(context),
                child: OutpassListItemWidget(),
              ),
      ),
    );
  }
}
