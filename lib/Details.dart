import 'package:flutter/material.dart';
import 'place.dart';

class Details extends StatelessWidget {
  final place state;

  Details({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Covid Tracker"),
          automaticallyImplyLeading: true,
          actions: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Created by \nChittadeep Biswas',
                )
              ],
            )
          ],
        ),
        body: Center(
            child: Column(
          children: [
            ListTile(title: Text('region: '), subtitle: Text(state.region)),
            ListTile(
                title: Text('activeCases: '),
                subtitle: Text(state.activeCases.toString())),
            ListTile(
                title: Text('newInfected: '),
                subtitle: Text(state.newInfected.toString())),
            ListTile(
                title: Text('recovered: '),
                subtitle: Text(state.recovered.toString())),
            ListTile(
                title: Text('newRecovered: '),
                subtitle: Text(state.newRecovered.toString())),
            ListTile(
                title: Text('deceased: '),
                subtitle: Text(state.deceased.toString())),
            ListTile(
                title: Text('newDeceased: '),
                subtitle: Text(state.newDeceased.toString())),
            ListTile(
                title: Text('totalInfected: '),
                subtitle: Text(state.totalInfected.toString()))
          ],
        )),
      ),
    );
  }
}
