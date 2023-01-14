import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alarming/models/ouralarms.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';

// List of items in our dropdown menu
List<OurAlarm> alarmFromJson(String str) =>
    List<OurAlarm>.from(json.decode(str).map((x) => OurAlarm.fromJson(x)));
String jsonStr = '''
  [
    {"name":"Annoying Ring", "location":"assets/Very_Annoying_Ring-281832.mp3"},
    {"name":"Baby Devil Laugh", "location":"assets/Baby Devil Laugh.mp3"},
    {"name":"Baby Laugh", "location":"assets/Baby laugh.mp3"},
    {"name":"Fire Remix", "location":"assets/fireremix.mp3"},
    {"name":"Irritating Fly", "location":"assets/Irritating Fly.mp3"},
    {"name":"Irritating Laugh", "location":"assets/Irritating Laugh.mp3"},
    {"name":"Irritating Tone", "location":"assets/Irritating Tone.mp3"},
    {"name":"Mosquito", "location":"assets/Mosquito.mp3"}
  ]
  ''';
List<OurAlarm> alarms = alarmFromJson(jsonStr);

class ChooseAlarmPage extends StatefulWidget {
  const ChooseAlarmPage({super.key, required this.name});
  final String name;

  @override
  State<ChooseAlarmPage> createState() => _ChooseAlarmPageState();
}

class _ChooseAlarmPageState extends State<ChooseAlarmPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String nextAlarmUser = "";
  List<Map<String, dynamic>> userAndTime = [];
  bool isRinging = false;

  @override
  initState() {
    super.initState();
    getNextAlarmUser().then((result) {
      print("result: $result");
      setState(() {nextAlarmUser = result;});
    });
  }

  Future<void> sortUsersByAlarm() async {
    return db
        .collection("users")
        .orderBy("alarm_time")
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic> row = {
          'username': doc['name'],
          'alarmTime': doc['alarm_time'],
        };
        userAndTime.add(row);
      });
    });
  }

  Future<String> getNextAlarmUser() async {
    await sortUsersByAlarm();
    String nextUser = "NO ONE";
    for (int i = 0; i < userAndTime.length - 1; i++) {
      if (widget.name == userAndTime[i]["username"]) {
        nextUser = userAndTime[i + 1]["username"];
        break;
      }
    }
    return nextUser;
  }

  OurAlarm dropdownvalue = alarms[0];

  Future<void> setAlarm(OurAlarm alarm) async {
    await Alarm.set(
      alarmDateTime: DateTime.now(),
      assetAudio: alarm.location,
      //loopAudio: true,
      onRing: () {
        setState(() {
          isRinging = true;
        });
      },
      notifTitle: 'Alarm notification',
      notifBody: 'Your alarm is ringing',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Alarm"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Choose alarm for $nextAlarmUser"),
            DropdownButton(
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: alarms.map((OurAlarm alarm) {
                return DropdownMenuItem(
                  value: alarm,
                  child: Text(alarm.name),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (OurAlarm? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                  setAlarm(newValue);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
