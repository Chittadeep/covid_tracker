class place {
  String region;
  int activeCases;
  int newInfected;
  int recovered;
  int newRecovered;
  int deceased;
  int newDeceased;
  int totalInfected;

  place(this.region, this.activeCases, this.newInfected, this.recovered,
      this.newRecovered, this.deceased, this.newDeceased, this.totalInfected);

  factory place.fromMap(Map<String, dynamic> json) {
    return place(
        json['region'] as String,
        json['activeCases'] as int,
        json['newInfected'] as int,
        json['recovered'] as int,
        json['newRecovered'] as int,
        json['deceased'] as int,
        json['newDeceased'] as int,
        json['totalInfected'] as int);
  }
}