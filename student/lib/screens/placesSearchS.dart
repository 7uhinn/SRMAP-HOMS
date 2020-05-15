import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';

import '../models/placesM.dart';

class SearchPlacesScreen extends StatefulWidget {
  static const routeName = '/place-search';

  @override
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {
  TextEditingController _searchController = new TextEditingController();
  Timer _throttle;

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
    _placesList = _initList;
    _searchController.addListener(_onSearchChanged);
  }

  _onSearchChanged() {
    if (_throttle?.isActive ?? false) _throttle.cancel();
    _throttle = Timer(const Duration(milliseconds: 500), () {
      getLocationResults(_searchController.text);
    });
  }

  void getLocationResults(String input) async {
    if (input.isEmpty) {
      return;
    }
    String baseURL = 'http://pelias.io/v1/autocomplete';
    String layerTitle = 'regions';
    String layerAddress = 'address';

    String requestTitle = '$baseURL?input=$input&layer=$layerTitle';
    Response responseTitle = await Dio().get(requestTitle);

    String requestAddress = '$baseURL?input=$input&layer=$layerAddress';
    Response responseAddress = await Dio().get(requestAddress);

    final predictionsTitle = responseTitle.data;
    print(predictionsTitle);
    //final predictionsAddress = responseAddress.data['predictions'];

    // List<Places> _displayResults = [];

    // for (var i = 0; i < predictionsTitle.length; i++) {
    //   String name = predictionsTitle[i]['description'];
    //   String address = predictionsAddress[i]['description'];
    //   _displayResults.add(Places(
    //     placeName: name,
    //     address: address,
    //   ));
    //}

    // setState(() {
    //   _placesList = _displayResults;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
