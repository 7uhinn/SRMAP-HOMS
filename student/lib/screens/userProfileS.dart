import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student/widgets/userProfileCardW.dart';

import '../widgets/SideDrawerW.dart';
import '../providers/userP.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user-profile';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _isInit = true;
  bool _progress = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      print(1);
      Provider.of<UserProvider>(context)
          .fetchUserDataFunction()
          .catchError((error) {
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
      }).then((_) {
        setState(() {
          _progress = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(2);
    final appBar = AppBar(
      title: Text('Profile'),
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
      drawer: SideDrawerWidget(),
      appBar: appBar,
      body: Container(
        height: (MediaQuery.of(context).size.height -
            appBar.preferredSize.height -
            MediaQuery.of(context).padding.top),
        width: MediaQuery.of(context).size.width,
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(
                bottom: 50,
                left: 15,
                right: 15,
                top: 50,
              ),
              height: 500,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
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
                          ),
                        ),
                      )
                    : UserProfileCardWidget(),
              ),
            ),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {},
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 20,
                  ),
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontFamily: 'Raleway',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
