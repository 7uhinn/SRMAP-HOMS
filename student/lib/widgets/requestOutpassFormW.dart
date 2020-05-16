import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:provider/provider.dart';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:student/models/placesM.dart';
import 'package:student/screens/placesSearchS.dart';

import '../models/outpassM.dart';
import '../providers/outpassP.dart';
import '../apiKey.dart';

const kGoogleApiKey = apiKey;

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

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

    Future<Null> displayPrediction(Prediction p) async {
      print(2);
      if (p != null) {
        print(3);
        PlacesDetailsResponse detail =
            await _places.getDetailsByPlaceId(p.placeId);
        print(4);
        //var placeId = p.placeId;
        double lat = detail.result.geometry.location.lat;
        double lng = detail.result.geometry.location.lng;
        List<AddressComponent> placeAddress = detail.result.addressComponents;
        String temp2 = detail.result.addressComponents[0].longName;
        print(5);
        var address = await Geocoder.local
            .findAddressesFromCoordinates(Coordinates(lat, lng));
        print(6);
        print(lat);
        print(lng);
        print(address.first.featureName);
        print(temp2);
        print(address.first.adminArea);
        print(address.first.countryCode);
        print(address.first.locality);
        print(address.first.subAdminArea);
        print(address.first.subLocality);
        print(address.first.thoroughfare);
        print(address.first.subThoroughfare);

        print(7);

        setState(() {
          placeName = temp2;
          // temp = address.first.addressLine;
          count++;
        });

        print(8);
      }
    }

    void getLocation() async {
      print(0);
      Prediction p = await PlacesAutocomplete.show(
        context: context,
        apiKey: kGoogleApiKey,
        mode: Mode.fullscreen,
      );
      print(1);
      displayPrediction(p);

      setState(() {});
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
