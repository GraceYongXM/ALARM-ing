class OurAlarm {
  late String name, location;

  OurAlarm(
    this.name,
    this.location,
  );

  OurAlarm.fromJson(dynamic obj) {
    name = obj['name'];
    location = obj['location'];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "location": location,
    };
  }
}
