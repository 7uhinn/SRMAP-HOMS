import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:provider/provider.dart';

import '../models/outpassM.dart';
import '../providers/outpassP.dart';
import '../apiKey.dart';

const kGoogleApiKey = apiKey;

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class RequestOutpassFormWidget extends StatefulWidget {
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

  String temp = '';
  String placeName = '';

  @override
  Widget build(BuildContext context) {
    final outpassDataProvider = Provider.of<OutpassProvider>(context);
    final outpassData = outpassDataProvider.outpassData;

    newOutpassValues['outpassID'] = 'o' + outpassData.length.toString();

    Future<Null> displayPrediction(Prediction p) async {
      if (p != null) {
        PlacesDetailsResponse detail =
            await _places.getDetailsByPlaceId(p.placeId);

        var placeId = p.placeId;
        double lat = detail.result.geometry.location.lat;
        double lng = detail.result.geometry.location.lng;
        List<AddressComponent> placeAddress = detail.result.addressComponents;
        AddressComponent temp2 = detail.result.addressComponents[0];


        var address = await Geocoder.local
            .findAddressesFromCoordinates(Coordinates(lat, lng));

        setState(() {
          placeName = placeAddress[0].toString();
          temp = 'Tuhin';
        });

        print(lat);
        print(lng);
        //print();
        print(placeAddress);
        
      }
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
            Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.location_on),
                  ),
                  title: Text(
                    placeName,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    temp,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () async {
                      Prediction p = await PlacesAutocomplete.show(
                        context: context,
                        apiKey: kGoogleApiKey,
                        mode: Mode.overlay,
                      );
                      displayPrediction(p);
                    },
                    color: Theme.of(context).errorColor,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
