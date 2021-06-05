import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'State.dart' as State;

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
      print(element);
      var state = State.State.fromMap(element);
      print(state.region);
    });

    //var act = json.encode(regionData[0]);
    //print(act);
    //data = regionData;
    //print(regionData);
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
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
              // leading: Image.asset(
              //   l[index].photoPath,
              //   height: 200.0,
              //   width: 200.0,
              //   errorBuilder: (BuildContext context, Object exception,
              //       StackTrace stackTrace) {
              //     return Text("error occured");
              //   },
              // ),
              //title: Text(data[index]),
              //subtitle: Text(data[index]),
              );
        });
  }
}
