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

  Future fetchData() async {
    var response = await http.get(
        Uri.parse('https://api.apify.com/v2/datasets/GN5szDInfK8hOgCna/items'));
    List si =
        json.decode(response.body); //Converts Complex JSON Body to List also
    var map = si[0]; //gets the firstmap inside the biggest list of the JSON
    List regionData = map[
        'regionData']; //gets the region datas inside the first map in list form

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          actions: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Covid Tracker',
                ),
                Text(
                  'Created by \nChittadeep Biswas',
                )
              ],
            )
          ],
        ),
        body: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(data[index].region),
                  subtitle: Text(data[index].activeCases.toString()),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(state: data[index]),
                        ));
                  });
            }),
      ),
    );
  }
}
