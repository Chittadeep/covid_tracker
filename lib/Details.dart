import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
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
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ListTile(title: Text('region: '), subtitle: Text(state.region)),
              ListTile(
                  title: Text('active Cases: '),
                  subtitle: Text(state.activeCases.toString())),
              ListTile(
                  title: Text('new Infected: '),
                  subtitle: Text(state.newInfected.toString())),
              ListTile(
                  title: Text('recovered: '),
                  subtitle: Text(state.recovered.toString())),
              ListTile(
                  title: Text('new Recovered: '),
                  subtitle: Text(state.newRecovered.toString())),
              ListTile(
                  title: Text('deceased: '),
                  subtitle: Text(state.deceased.toString())),
              ListTile(
                  title: Text('new Deceased: '),
                  subtitle: Text(state.newDeceased.toString())),
              ListTile(
                  title: Text('total Infected: '),
                  subtitle: Text(state.totalInfected.toString())),
              PieChart(dataMap: state.getPie())
            ],
          )),
        ),
      ),
    );
  }
}
