import 'package:charts_flutter/flutter.dart' as charts;

class Place {
  String region;
  double activeCases;
  double newInfected;
  double recovered;
  double newRecovered;
  double deceased;
  double newDeceased;
  double totalInfected;

  Place(this.region, this.activeCases, this.newInfected, this.recovered,
      this.newRecovered, this.deceased, this.newDeceased, this.totalInfected);

  factory Place.fromMap(Map<String, dynamic> json) {
    return Place(
        json['region'] as String,
        json['activeCases'] as double,
        json['newInfected'] as double,
        json['recovered'] as double,
        json['newRecovered'] as double,
        json['deceased'] as double,
        json['newDeceased'] as double,
        json['totalInfected'] as double);
  }

  Map<String, double> getPie() {
    return {
      "activeCases": activeCases,
      "newInfected": newInfected,
      "recovered": recovered,
      "newRecovered": newRecovered,
      "deceased": deceased,
      "newDeceased": newDeceased,
      "toralInfected": totalInfected
    };
  }
}

class BarChartModel {
  String cause;
  double figure;
  final charts.Color color;

  BarChartModel({this.cause, this.figure, this.color});
}
