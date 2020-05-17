import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:student/models/placesM.dart';
import 'package:student/screens/placesSearchS.dart';

import '../models/outpassM.dart';
import '../providers/outpassP.dart';

class RequestOutpassFormWidget extends StatefulWidget {
  static const routeName = '/request-outpass-form';

  @override
  _RequestOutpassFormWidgetState createState() =>
      _RequestOutpassFormWidgetState();
}

class _RequestOutpassFormWidgetState extends State<RequestOutpassFormWidget> {
  Map<String, Object> newOutpassValues = {
    'outpassID': '',
    'regID': '',
    'location': '',
    'reqDateTime': DateTime.now(),
    'arrDateTime': DateTime.now(),
    'depDateTime': DateTime.now(),
    'outpassStatus': OutpassStatus.Pending,
  };

  var address = 'PVP Square Mall, Vijayawada';
  var placeName = 'Vijayawada';
  double count = 0;

  @override
  Widget build(BuildContext context) {
    final outpassDataProvider = Provider.of<OutpassProvider>(context);
    final outpassData = outpassDataProvider.outpassData;

    newOutpassValues['outpassID'] = 'o' + outpassData.length.toString();

    void returnPlace(String pT, String pS) {
      Places update = Places(
        placeName: pT,
        address: pS,
      );

      setState(() {
        placeName = update.placeName;
        address = update.address;
      });
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 7,
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                child: Icon(Icons.location_on),
              ),
              title: Text(
                placeName,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Container(
                width: double.infinity,
                child: Text(
                  address,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigator.of(context)
                    .pushNamed(SearchPlacesScreen.routeName, arguments: {
                  'function': returnPlace,
                }),
                color: Theme.of(context).errorColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
