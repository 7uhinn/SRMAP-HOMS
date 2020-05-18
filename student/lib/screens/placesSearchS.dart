import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';

import '../apiKey.dart';
import '../models/placesM.dart';

class SearchPlacesScreen extends StatefulWidget {
  static const routeName = '/search-places';

  @override
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  TextEditingController _searchController = new TextEditingController();
  Timer _throttle;
  bool _progress;

  List<Places> _placesList;
  final List<Places> _initList = [
    Places(placeName: 'Mangalagiri', address: 'Mangalagiri, Andhra Pradesh'),
    Places(placeName: 'Guntur', address: 'Guntur, Andhra Pradesh'),
    Places(placeName: 'Hyderabad', address: 'Hyderabad, Telangana'),
    Places(placeName: 'Chennai', address: 'Chennai, Tamil Nadu'),
  ];

  @override
  void initState() {
    super.initState();
    _progress = false;
    _placesList = _initList;
    _searchController.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    if (_throttle?.isActive ?? false) _throttle.cancel();
    _throttle = Timer(const Duration(milliseconds: 300), () {
      getLocationResults(_searchController.text);
    });
  }

  void getLocationResults(String input) async {
    if (input.isEmpty) {
      return;
    }
    setState(() {
      _progress = true;
    });

    String baseURL = 'https://api.tomtom.com/search/2/search';

    String request =
        '$baseURL/$input.json?key=$apiKey&language=en-GB&limit=7&lat=16.437600&lon=80.564600';
    Response response = await Dio().get(request);

    dynamic data = (response.data);

    List<Places> _displayResults = [];

    for (var i = 0; i < data['results'].length; i++) {
      print(data['results'][i]['type']);
      print(data['results'][i]['address']);
      if (data['results'][i]['type'] == 'POI') {
        String name = data['results'][i]['poi']['name'];
        String addr = data['results'][i]['address']['municipality'] +
            ', ' +
            data['results'][i]['address']['countrySubdivision'];

        _displayResults.add(Places(
          placeName: name,
          address: addr,
        ));
      } else if (data['results'][i]['type'] == 'Street') {
        String name = data['results'][i]['address']['streetName'];
        String addr = data['results'][i]['address']['municipalitySubdivision'] +
            ', ' +
            data['results'][i]['address']['municipality'];

        _displayResults.add(Places(
          placeName: name,
          address: addr,
        ));
      } else {
        if (data['results'][i]['address']['municipality'] != null) {
          String name = data['results'][i]['address']['municipality'];
          String addr = data['results'][i]['address']['countrySubdivision'] +
              ', ' +
              data['results'][i]['address']['country'];

          _displayResults.add(Places(
            placeName: name,
            address: addr,
          ));
        } else {
          if (data['results'][i]['address']['countrySubdivision'] != null) {
            String name = data['results'][i]['address']['countrySubdivision'];
            String addr = data['results'][i]['address']['country'];

            _displayResults.add(Places(
              placeName: name,
              address: addr,
            ));
          } else {
            String name = data['results'][i]['address']['country'];
            String addr = '';

            _displayResults.add(Places(
              placeName: name,
              address: addr,
            ));
          }
        }
      }
    }

    setState(() {
      _placesList = _displayResults;
      _progress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, Function>;
    final returnPlace = routeArgs['function'];

    FocusScopeNode currentFocus = FocusScope.of(context);

    _selectPlace(String pT, String pS) {
      if (!currentFocus.hasPrimaryFocus) {
        setState( () {
          currentFocus.unfocus();
        });
      }
      returnPlace(pT, pS);
      Navigator.of(context).pop();
    }

    final appBar = AppBar(
      title: Text('Change Location'),
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
      appBar: appBar,
      body: Container(
        height: double.infinity,
        width: double.infinity,
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
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top) *
                    0.12,
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.only(
                    top: 2.5,
                    left: 25,
                    right: 25,
                    bottom: 5,
                  ),
                  child: TextField(
                    controller: _searchController,
                    style: Theme.of(context).textTheme.headline6,
                    decoration: InputDecoration(
                      prefixIcon: _progress
                          ? Container(
                              height: 2,
                              width: 2,
                              padding: EdgeInsets.all(15),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : Icon(Icons.search),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: ListView.builder(
                  itemBuilder: (context, idx) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 1,
                        horizontal: 15,
                      ),
                      child: InkWell(
                        onTap: () => _selectPlace(_placesList[idx].placeName,
                            _placesList[idx].address),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 0.5,
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 25,
                                child: Icon(
                                  Icons.location_on,
                                  color: Theme.of(context).primaryColor,
                                  size: 40,
                                ),
                              ),
                              title: Text(
                                '${_placesList[idx].placeName}',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              subtitle: Text(
                                '${_placesList[idx].address}',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: _placesList.length,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
