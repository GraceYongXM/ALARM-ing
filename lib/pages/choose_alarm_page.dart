import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChooseAlarmPage extends StatefulWidget {
  const ChooseAlarmPage({super.key, required this.name});
  final String name;

  @override
  State<ChooseAlarmPage> createState() => _ChooseAlarmPageState();
}

class _ChooseAlarmPageState extends State<ChooseAlarmPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  String nextAlarmUser = "NO ONE";
  List<Map<String, dynamic>> userAndTime = [];

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

  void getNextAlarmUser() {
    sortUsersByAlarm();
    for (int i = 0; i < userAndTime.length - 1; i++) {
      if (widget.name == userAndTime[i]["username"]) {
        nextAlarmUser = userAndTime[i + 1]["username"];
        break;
      }
    }
  }

  String dropdownvalue = 'Alarm 1';

  // List of items in our dropdown menu
  var alarms = [
    'Alarm 1',
    'Alarm 2',
    'Alarm 3',
    'Alarm 4',
    'Alarm 5',
  ];

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
              items: alarms.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
