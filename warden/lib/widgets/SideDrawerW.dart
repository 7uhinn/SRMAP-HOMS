import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/authP.dart';

import '../screens/aboutS.dart';
import '../screens/userProfileS.dart';

class SideDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget buildListTile(String title, IconData icon, double el, double ra, Function tapHandler) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ra),
          ),
          elevation: el,
          child: ListTile(
            leading: Icon(
              icon,
              size: 26,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontFamily: 'Raleway',
                fontSize: 18,
              ),
            ),
            onTap: tapHandler,
          ),
        ),
      );
    }

    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
              height: 140,
              width: double.infinity,
              padding: EdgeInsets.all(00),
              alignment: Alignment.bottomLeft,
              //color: Theme.of(context).accentColor,
              child: buildListTile('Profile', Icons.account_circle, 7, 20, () {
                Navigator.of(context).pushReplacementNamed(UserProfileScreen.routeName);  
              }),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orangeAccent,
                    Theme.of(context).primaryColor,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              )),
          SizedBox(
            height: 10,
          ),
          buildListTile(
            'Outpass List',
            Icons.list,
            5,
            20,
            () {
              Navigator.of(context).pushReplacementNamed('/'); 
            }
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 1,
          ),
          buildListTile(
            'About Us',
            Icons.code,
            5,
            20,
            () {
              Navigator.of(context).pushReplacementNamed(AboutScreen.routeName); 
            }
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 1,
          ),
          buildListTile(
            'Log Out',
            Icons.exit_to_app,
            5,
            20,
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<AuthProvider>(context, listen:false).logout(); 
            }
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
