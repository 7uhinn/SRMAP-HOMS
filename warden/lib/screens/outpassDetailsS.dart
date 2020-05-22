import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../widgets/topContainerW.dart';
import '../providers/outpassP.dart';

class OutpassDetailsScreen extends StatelessWidget {
  static const routeName = '/outpass-details';

  @override
  Widget build(BuildContext context) {
    final outpassData =
        ModalRoute.of(context).settings.arguments as Map<String, Object>;

    final outpassDataProvider = Provider.of<OutpassProvider>(context);
    final iconToggler = outpassDataProvider.iconToggler;
    final regID = outpassDataProvider.regID;

    double width = MediaQuery.of(context).size.width;
    Color baseColor = iconToggler(outpassData['status'])['color'];
    IconData icon = iconToggler(outpassData['status'])['icon'];

    Widget buildListTile(IconData icon, String text, String date, Color col) {
      return Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 30,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
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
          Divider(
            color: Theme.of(context).primaryColor,
            endIndent: 10,
            indent: 10,
          )
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
                          tag: outpassData['id'],
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
                                regID,
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
                  SizedBox(
                    height: 20,
                  ),
                  buildListTile(Icons.alarm_add, 'Requested Date/Time:',
                      outpassData['reqDateTime'], Colors.white),
                  SizedBox(
                    height: 20,
                  ),
                  buildListTile(Icons.arrow_upward, 'Departure Date/Time:',
                      outpassData['depDateTime'], Colors.white),
                  SizedBox(
                    height: 20,
                  ),
                  buildListTile(Icons.arrow_downward, 'Arrival Date/Time:',
                      outpassData['arrDateTime'], Colors.white),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
