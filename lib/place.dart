class place {
  String region;
  double activeCases;
  double newInfected;
  double recovered;
  double newRecovered;
  double deceased;
  double newDeceased;
  double totalInfected;

  place(this.region, this.activeCases, this.newInfected, this.recovered,
      this.newRecovered, this.deceased, this.newDeceased, this.totalInfected);

  factory place.fromMap(Map<String, dynamic> json) {
    return place(
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
