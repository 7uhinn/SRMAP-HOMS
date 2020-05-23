import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/userP.dart';

class UserProfileCardWidget extends StatefulWidget {
  @override
  _UserProfileCardWidgetState createState() => _UserProfileCardWidgetState();
}

class _UserProfileCardWidgetState extends State<UserProfileCardWidget> {
  Widget buildNameTiles(String tag, String value) {
    return ListTile(
      title: Text(
        tag,
        style: TextStyle(
          fontFamily: 'Montserrat',
          fontSize: 16,
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        value,
        style: TextStyle(
          fontFamily: 'Raleway',
          fontSize: 22,
        ),
      ),
    );
  }

  String hostelName(value) {
    switch (value) {
      case 1:
        {
          return "Krishna";
        }
        break;

      case 2:
        {
          return "Godavari";
        }
        break;

      case 3:
        {
          return "Tower 3";
        }
        break;

      case 4:
        {
          return "Narmada";
        }
        break;

      case 5:
        {
          return "Godavari";
        }
        break;

      case 6:
        {
          return "Ganga";
        }
        break;

      default:
        {
          return value.toString();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userp = Provider.of<UserProvider>(context);
    final user = userp.user;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          buildNameTiles('Name:', user[0].name),
          buildNameTiles('Registration Number:', user[0].regID),
          buildNameTiles('Joining Year:', user[0].joinYear.toString()),
          buildNameTiles('Hostel:', hostelName(user[0].hostelNum.toInt())),
          buildNameTiles('Room Number:', user[0].roomNum.toString()),
          buildNameTiles('Phone Numbers:', user[0].phoneNum.toString()),
        ],
      ),
    );
  }
}
