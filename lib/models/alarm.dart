class Alarm {
  late String name, location;

  Alarm(
    this.name,
    this.location,
  );

  Alarm.fromJson(dynamic obj) {
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
