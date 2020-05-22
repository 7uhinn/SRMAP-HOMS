import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/SideDrawerW.dart';
import '../widgets/topContainerW.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = '/about';

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('About Us'),
      elevation: 0,
      centerTitle: true,
    );

    Widget buildAuthorTile(String name, String url1, String url2) {
      return Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 5,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 26,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Divider(
                thickness: 3,
                color: Theme.of(context).primaryColor,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      height: 80,
                      width: 80,
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: IconButton(
                        onPressed: () => _launchURL(url1),
                        icon: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80.0,
                          child: Image.asset(
                            'assets/images/githubd.png',
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: IconButton(
                        onPressed: () => _launchURL(url2),
                        icon: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 80.0,
                          child: Image.asset(
                            'assets/images/linkedin.png',
                            height: 80,
                            width: 80,
                          ),
                        ),
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

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.7),
      drawer: SideDrawerWidget(),
      appBar: appBar,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              height: 150,
              color: Theme.of(context).primaryColor,
              width: MediaQuery.of(context).size.width,
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
                        Container(
                          height: 120,
                          width: 120,
                          padding: const EdgeInsets.only(
                            right: 10,
                          ),
                          child: IconButton(
                            onPressed: () => _launchURL(
                                'https://7uhinn.github.io/SRMAP-HOMS/'),
                            icon: CircleAvatar(
                              radius: 80.0,
                              child: Image.asset(
                                'assets/images/github.png',
                                height: 90,
                                width: 90,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 230,
                              child: Text(
                                'SRM AP',
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
                              width: 230,
                              child: Text(
                                'Hostel Outpass Management System',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Montserrat',
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.clip,
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
                  buildAuthorTile(
                    'Tuhin Sarkar',
                    'https://github.com/7uhinn',
                    'https://www.linkedin.com/in/7uhin/',
                  ),
                  buildAuthorTile(
                    'Aayusi Biswas',
                    'https://github.com/aayusi',
                    'https://www.linkedin.com/in/aayusibiswas/',
                  ),
                  buildAuthorTile(
                    'Khushboo Maheshwari',
                    'https://github.com/khushboomah8',
                    'https://www.linkedin.com/in/khushboomah8/',
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
