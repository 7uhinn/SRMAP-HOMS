import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/outpassP.dart';

class OutpassListItemWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final outpassDataProvider = Provider.of<OutpassProvider>(context);
    final outpassData = outpassDataProvider.outpassData;

    final iconToggler = outpassDataProvider.iconToggler;

    return outpassData.length != 0
        ? ListView.builder(
            itemBuilder: (context, idx) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2.5,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: iconToggler(
                            outpassData[idx].outpassStatus)['color'],
                        radius: 25,
                        child: Icon(
                          iconToggler(outpassData[idx].outpassStatus)['icon'],
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      title: Text(
                        outpassData[idx].location,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMEd().format(
                            DateTime.parse(outpassData[idx].reqDateTime)),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      trailing: Text(
                        DateFormat.Hm().format(
                            DateTime.parse(outpassData[idx].reqDateTime)),
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: outpassData.length,
          )
        : Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'No outpasses requested yet!',
                  style: TextStyle(
                    fontFamily: 'Raleway',
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 70,
                  child: Image.asset('assets/images/waiting.png',
                      fit: BoxFit.cover),
                ),
              ],
            ),
          );
  }
}
