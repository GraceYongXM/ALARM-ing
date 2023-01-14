import 'dart:convert';

import 'package:alarming/models/alarm.dart';
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';

// List of items in our dropdown menu
List<Alarm> alarmFromJson(String str) =>
    List<Alarm>.from(json.decode(str).map((x) => Alarm.fromJson(x)));
String jsonStr = '''
  [
    {"name":"Baby Devil Laugh", "location":"assets/Baby Devil Laugh.mp"},
    {"name":"Baby Laugh", "location":"assets/Baby laugh.mp3"},
    {"name":"Fire Remix", "location":"assets/fireremix.mp3"},
    {"name":"Irritating Fly", "location":"assets/Irritating Fly.mp3"},
    {"name":"Irritating Laugh", "location":"assets/Irritating Laugh.mp3"},
    {"name":"Irritating Tone", "location":"assets/Irritating Tone.mp3"},
    {"name":"Mosquito", "location":"assets/Mosquito_-_Annoying-36877.mp3"},
    {"name":"Annoying Ring", "location":"assets/Very_Annoying_Ring-281832.mp3"}
    ]
  ''';
List<Alarm> alarms = alarmFromJson(jsonStr);

class ChooseAlarmPage extends StatefulWidget {
  const ChooseAlarmPage({super.key});

  @override
  State<ChooseAlarmPage> createState() => _ChooseAlarmPageState();
}

class _ChooseAlarmPageState extends State<ChooseAlarmPage> {
  var friend;

  Alarm dropdownvalue = alarms[0];

  Future<void> setAlarm(Alarm alarm) async {
    await Alarm.set(
      alarmDateTime: 0,
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
            Text("Choose alarm for $friend"),
            DropdownButton(
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: alarms.map((Alarm alarm) {
                return DropdownMenuItem(
                  value: alarm,
                  child: Text(alarm.name),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (Alarm? newValue) {
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
