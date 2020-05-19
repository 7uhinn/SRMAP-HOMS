import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

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
    'location': '',
    'reqDateTime': DateTime.now().toString(),
    'arrDateTime': DateTime.now(),
    'depDateTime': DateTime.now(),
    'outpassStatus': 'Pending',
  };

  Outpass dummy;

  String address;
  String placeName;
  String depDate;
  String depTime;
  String arrDate;
  String arrTime;
  String dec;
  bool cbBool;
  bool _progress = false;

  DateTime saveDepDT;
  DateTime saveArrDT;

  @override
  void initState() {
    super.initState();
    address = 'PVP Square Mall, Vijayawada';
    placeName = 'Vijayawada';
    _progress = false;
    saveDepDT = DateTime.now();
    depDate = DateFormat.yMMMd().format(saveDepDT);
    depTime = DateFormat.jm().format(saveDepDT);

    if (DateTime.now().day.toInt() < 10 && DateTime.now().month.toInt() < 10) {
      String text =
          '${DateTime.now().year}-0${DateTime.now().month}-0${DateTime.now().day} 19:00:00Z';

      if (DateTime.now().isAfter(DateTime.parse(text))) {
        saveArrDT = DateTime.now().add(Duration(hours: 2));
        arrTime = DateFormat.jm().format(saveArrDT);
        arrDate = DateFormat.yMMMd().format(saveArrDT);
      } else {
        saveArrDT = DateTime.parse(text);
        arrTime = DateFormat.jm().format(saveArrDT);
        arrDate = DateFormat.yMMMd().format(saveArrDT);
      }
    } else if (DateTime.now().day.toInt() > 10 &&
        DateTime.now().month.toInt() < 10) {
      String text =
          '${DateTime.now().year}-0${DateTime.now().month}-${DateTime.now().day} 19:00:00Z';
      if (DateTime.now().isAfter(DateTime.parse(text))) {
        saveArrDT = DateTime.now().add(Duration(hours: 2));
        print(saveArrDT);
        arrTime = DateFormat.jm().format(saveArrDT);
        print(arrTime);
        arrDate = DateFormat.yMMMd().format(saveArrDT);
      } else {
        saveArrDT = DateTime.parse(text);
        arrTime = DateFormat.jm().format(saveArrDT);
        arrDate = DateFormat.yMMMd().format(saveArrDT);
      }
    } else if (DateTime.now().day.toInt() < 10 &&
        DateTime.now().month.toInt() > 10) {
      String text =
          '${DateTime.now().year}-${DateTime.now().month}-0${DateTime.now().day} 19:00:00Z';
      if (DateTime.now().isAfter(DateTime.parse(text))) {
        saveArrDT = DateTime.now().add(Duration(hours: 2));
        arrTime = DateFormat.jm().format(saveArrDT);
        arrDate = DateFormat.yMMMd().format(saveArrDT);
      } else {
        saveArrDT = DateTime.parse(text);
        arrTime = DateFormat.jm().format(saveArrDT);
        arrDate = DateFormat.yMMMd().format(saveArrDT);
      }
    } else {
      String text =
          '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day} 19:00:00Z';
      if (DateTime.now().isAfter(DateTime.parse(text))) {
        saveArrDT = DateTime.now().add(Duration(hours: 2));
        arrTime = DateFormat.jm().format(saveArrDT);
        arrDate = DateFormat.yMMMd().format(saveArrDT);
      } else {
        saveArrDT = DateTime.parse(text);
        arrTime = DateFormat.jm().format(saveArrDT);
        arrDate = DateFormat.yMMMd().format(saveArrDT);
      }
    }

    dec =
        'I have read the SRM University AP Hostel timing and conduct regulations and will abide by them to the best of my knowledge and ability.';
    cbBool = false;
  }

  Widget buildDateTimeSelectors(
      BuildContext context, String text, String date, String time) {
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
              fontSize: 14,
              color: Theme.of(context).primaryColor,
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
                        color: Theme.of(context).primaryColor,
                      ),
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      date,
                      style: Theme.of(context).textTheme.headline6,
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
                        color: Theme.of(context).primaryColor,
                      ),
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      time,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                right: 28,
              ),
              padding: const EdgeInsets.only(
                bottom: 12,
              ),
              child: IconButton(
                enableFeedback: true,
                icon: Icon(Icons.calendar_today),
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime.now().add(Duration(days: 3)),
                      onConfirm: (newdate) {
                    setState(() {
                      if (text == 'Departure:') {
                        depDate = DateFormat.yMMMd().format(newdate);
                        depTime = DateFormat.jm().format(newdate);
                        saveDepDT = newdate;
                      } else {
                        arrDate = DateFormat.yMMMd().format(newdate);
                        arrTime = DateFormat.jm().format(newdate);
                        saveArrDT = newdate;
                      }
                    });
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                color: Theme.of(context).primaryColor,
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

  @override
  Widget build(BuildContext context) {
    final outpassDataProvider =
        Provider.of<OutpassProvider>(context, listen: false);
    final outpassData = outpassDataProvider.outpassData;

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

    Future<void> _submitForm() async {
      setState(() {
        _progress = true;
      });

      newOutpassValues['outpassID'] = 'o' + outpassData.length.toString();

      dummy = Outpass(
        outpassID: newOutpassValues['outpassID'],
        location: placeName,
        reqDateTime: newOutpassValues['reqDateTime'],
        arrDateTime: saveArrDT.toString(),
        depDateTime: saveDepDT.toString(),
        outpassStatus: newOutpassValues['outpassStatus'],
      );

      outpassDataProvider.reqOutpassFunction(dummy).catchError((error) {
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
          _progress = false;
        });
        Navigator.of(context).pop();
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
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
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
                  onPressed: () => Navigator.of(context).pushNamed(
                    SearchPlacesScreen.routeName,
                    arguments: {
                      'function': returnPlace,
                    },
                  ),
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Divider(
              color: Theme.of(context).primaryColor,
            ),
            buildDateTimeSelectors(
              context,
              'Departure:',
              depDate,
              depTime,
            ),
            buildDateTimeSelectors(
              context,
              'Arrival:',
              arrDate,
              arrTime,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Checkbox(
                    onChanged: (bool value) {
                      setState(() {
                        cbBool = value;
                      });
                    },
                    value: cbBool,
                  ),
                ),
                title: Text(
                  'Declaration',
                  style: Theme.of(context).textTheme.headline6,
                ),
                subtitle: Container(
                  width: double.infinity,
                  child: Text(
                    dec,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 40,
                ),
                alignment: Alignment.centerRight,
                child: cbBool
                    ? Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [
                              Colors.lightBlue[700],
                              Theme.of(context).primaryColor,
                            ],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                          ),
                        ),
                        child: RaisedButton(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.transparent,
                          onPressed: _submitForm,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: _progress
                                ? Container(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      backgroundColor: Colors.white,
                                    ),
                                  )
                                : Text(
                                    'Submit',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Raleway',
                                      fontSize: 17,
                                    ),
                                  ),
                          ),
                        ),
                      )
                    : Container(
                        height: 40,
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.transparent,
                          onPressed: null,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Raleway',
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
