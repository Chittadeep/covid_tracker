import 'package:flutter/material.dart';
import 'package:covid_tracker/Details.dart';
import 'package:http/http.dart' as http;
import 'package:pie_chart/pie_chart.dart';
import 'dart:convert';
import 'Place.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List data = [];

  double activeCases;
  double activeCasesNew;
  double recovered;
  double recoveredNew;
  double deaths;
  double deathsNew;
  double previousDayTests;
  double totalCases;
  String sourceUrl;
  String lastUpdatedAtApify;
  String readMe;

  Map<String, double> nation;

  Future fetchData() async {
    var response = await http.get(
        Uri.parse('https://api.apify.com/v2/datasets/GN5szDInfK8hOgCna/items'));
    List si =
        json.decode(response.body); //Converts Complex JSON Body to List also
    var map = si[0]; //gets the firstmap inside the biggest list of the JSON
    List regionData = map[
        'regionData']; //gets the region datas inside the first map in list form

    activeCases = map['activeCases'];
    activeCasesNew = map['activeCasesNew'];
    recovered = map['recovered'];
    recoveredNew = map['recoveredNew'];
    deaths = map['deaths'];
    deathsNew = map['deathsNew'];
    previousDayTests = map['previousDayTests'];
    totalCases = map['totalCases'];

    sourceUrl = map['sourceUrl'];
    lastUpdatedAtApify = map['lastUpdatedAtApify'];
    readMe = map['readMe'];

    nation = {
      'activeCases': activeCases,
      'activeCasesNew': activeCasesNew,
      'recovered': recovered,
      'recovered new': recoveredNew,
      'deaths': deaths,
      'deaths New': deathsNew,
      'previousDayTests': previousDayTests
    };

    regionData.forEach((element) {
      var state = Place.fromMap(element);
      data.add(state);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              home: Scaffold(
            body: Center(child: SingleChildScrollView(child: stateCr(context))),
          ));
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget stateCr(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBar(
              title: Text("Covid Tracker"),
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(child: SingleChildScrollView(child: PieChart(dataMap: nation))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('data source $sourceUrl'),
                      Text('data updated $lastUpdatedAtApify')
                    ],
                  ),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              Text('Active Cases'),
                              Text(activeCases.toString())
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              Text('Active Cases New'),
                              Text(activeCasesNew.toString())
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              Text('recovered'),
                              Text(recovered.toString())
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              Text('recovered new'),
                              Text(recoveredNew.toString())
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [Text('deaths'), Text(deaths.toString())],
                          ),
                        ),
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              Text('deaths new'),
                              Text(deathsNew.toString())
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              Text('previous day tests'),
                              Text(previousDayTests.toString())
                            ],
                          ),
                        ),
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              Text('total cases'),
                              Text(totalCases.toString())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  /*ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(data[index].region),
                            subtitle:
                                Text(data[index].activeCases.toString()),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        Details(state: data[index]),
                                  ));
                            });
                      }),*/

                  Expanded(
                    child: Container(color: Colors.grey,
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          controller: ScrollController(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              margin: EdgeInsets.all(40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: BorderSide(color: Colors.blue, width: 2)),
                              borderOnForeground: true,
                              child: InkWell(
                                splashColor: Colors.blue.withAlpha(30),
                                child: Center(child: Text(data[index].region)),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            Details(state: data[index]),
                                      ));
                                },
                              ),
                            );
                          }),
                    ),
                  )

                  /*onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Details(state: data[index]),
                                    ));
                          );
                        }),
                  )*/
                ],
              ),
            ),
          )),
    );
  }
}
