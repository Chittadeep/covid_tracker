import 'package:flutter/material.dart';
import 'package:covid_tracker/Details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'place.dart';

void main() async {
  //await MyApp().fetchData();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List data = [];

  int activeCases;
  int activeCasesNew;
  int recovered;
  int recoveredNew;
  int deaths;
  int deathsNew;
  int previousDayTests;
  int totalCases;
  String sourceUrl;
  String lastUpdatedAtApify;
  String readMe;

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

    print(readMe);

    regionData.forEach((element) {
      var state = place.fromMap(element);
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
            body: Center(child: stateCr(context)),
          ));
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }

  Widget stateCr(BuildContext context) {
    return WillPopScope(onWillPop:() async => true,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
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
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [Text('Active Cases'), Text(activeCases.toString())],
                          ),
                        ),
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [Text('Active Cases New'), Text(activeCasesNew.toString())],
                          ),
                        ),
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [Text('recovered'), Text(recovered.toString())],
                          ),
                        ),
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [Text('recovered new'), Text(recoveredNew.toString())],
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
                            children: [Text('deaths new'), Text(deathsNew.toString())],
                          ),
                        ),
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [Text('previous day tests'), Text(previousDayTests.toString())],
                          ),
                        ),
                        Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [Text('total cases'), Text(totalCases.toString())],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(data[index].region),
                              subtitle: Text(data[index].activeCases.toString()),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          Details(state: data[index]),
                                    ));
                              });
                        }),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
