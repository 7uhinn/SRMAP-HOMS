import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/topContainerW.dart';
import '../providers/outpassP.dart';

class OutpassDetailsScreen extends StatefulWidget {
  static const routeName = '/outpass-details';

  @override
  _OutpassDetailsScreenState createState() => _OutpassDetailsScreenState();
}

class _OutpassDetailsScreenState extends State<OutpassDetailsScreen> {
  bool _progress1 = false;
  bool _progress2 = false;

  @override
  Widget build(BuildContext context) {
    final outpassData =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    final outpassDataProvider = Provider.of<OutpassProvider>(context);
    final iconToggler = outpassDataProvider.iconToggler;

    double width = MediaQuery.of(context).size.width;
    Color baseColor = iconToggler(outpassData['outpassStatus'])['color'];
    IconData icon = iconToggler(outpassData['outpassStatus'])['icon'];

    Widget buildNameTiles(String tag, String value) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: ListTile(
          title: Text(
            tag,
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            value,
            style: TextStyle(
              fontFamily: 'Raleway',
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      );
    }

    Widget buildListTile(IconData icon, String text, String date, Color col) {
      return Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 30,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Flexible(
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(
                        top: 5,
                        bottom: 18,
                        left: 28,
                        right: 8,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.white,
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        DateFormat.yMMMd().format(DateTime.parse(date)),
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 5,
                        bottom: 18,
                        left: 10,
                        right: 8,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 0.5,
                          color: Colors.white,
                        ),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        DateFormat.jm().format(DateTime.parse(date)),
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  right: 50,
                ),
                padding: const EdgeInsets.only(
                  bottom: 12,
                ),
                child: Icon(
                  icon,
                  color: col,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      );
    }

    final appBar = AppBar(
      title: Text(
        'Outpass Details',
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Raleway',
        ),
      ),
      centerTitle: true,
      backgroundColor: baseColor,
      elevation: 0,
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: baseColor.withOpacity(0.8),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 150,
              color: baseColor,
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 0, vertical: 0.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Hero(
                          tag: outpassData['outpassID'],
                          child: CircleAvatar(
                            backgroundColor: baseColor,
                            radius: 35.0,
                            child: Icon(
                              icon,
                              size: 80,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200,
                              child: Text(
                                outpassData['location'],
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'Raleway',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            Container(
                              child: Text(
                                outpassData['regID'],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top -
                  150),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  buildNameTiles(
                    'Name:',
                    outpassData['name'],
                  ),
                  buildNameTiles(
                    'Room Number:',
                    outpassData['roomNum'].toString(),
                  ),
                  buildNameTiles(
                    'Phone Number:',
                    outpassData['phoneNum'].toString(),
                  ),
                  buildListTile(Icons.alarm_add, 'Requested Date/Time:',
                      outpassData['reqDateTime'], Colors.white),
                  buildListTile(Icons.arrow_upward, 'Departure Date/Time:',
                      outpassData['depDateTime'], Colors.white),
                  buildListTile(Icons.arrow_downward, 'Arrival Date/Time:',
                      outpassData['arrDateTime'], Colors.white),
                  if (outpassData['outpassStatus'] == 'Pending')
                    Container(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            width: width / 2,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: RaisedButton(
                              child: _progress1
                                  ? Container(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        backgroundColor: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'Approve',
                                      style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                              onPressed: () {
                                setState(() {
                                  _progress1 = true;
                                });

                                outpassDataProvider
                                    .decisionOutpass(
                                  outpassData['regID'],
                                  outpassData['outpassID'],
                                  true,
                                )
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
                                    _progress1 = false;
                                  });
                                  Navigator.of(context).pop();
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 8.0),
                              color: Colors.green,
                            ),
                          ),
                          Container(
                            width: width / 2,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                            ),
                            child: RaisedButton(
                              child: _progress2
                                  ? Container(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3,
                                        backgroundColor: Colors.white,
                                      ),
                                    )
                                  : Text(
                                      'Disapprove',
                                      style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                              onPressed: () {
                                setState(() {
                                  _progress2 = true;
                                });

                                outpassDataProvider
                                    .decisionOutpass(
                                  outpassData['regID'],
                                  outpassData['outpassID'],
                                  false,
                                )
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
                                    _progress2 = false;
                                  });
                                  Navigator.of(context).pop();
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 8.0),
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
