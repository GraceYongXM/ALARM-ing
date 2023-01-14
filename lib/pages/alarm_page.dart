import 'dart:async';
import 'dart:developer';

import 'package:alarming/pages/choose_alarm_page.dart';
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key, required this.name, required this.default_alarm});
  final String name;
  final String default_alarm;

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  // record wake up time
  final timePickerController = TextEditingController();
  TimeOfDay wakeUpTime = TimeOfDay.now();
  bool isRinging = false;
  FirebaseFirestore db = FirebaseFirestore.instance;

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(context: context, initialTime: wakeUpTime);

    if (time != null) {
      setState(() {
        timePickerController.text = "${time.hour}:${time.minute}";
        wakeUpTime = time;
      });
    }
    db.collection("users").doc(widget.name).update({"alarm_time": time}).then(
        (value) => print("Alarm successfully set!"),
        onError: (e) => print("Error setting alarm"));
    //createTimer(wakeUpTime);

    final now = DateTime.now();
    DateTime dt = DateTime(
      now.year,
      now.month,
      now.day,
      wakeUpTime.hour,
      wakeUpTime.minute,
    );

    setAlarm(dt);
  }

  /*final user = db.collection("users").doc(name);
  user.update({"alarm_time" : time}).then(
    (value) => print("Alarm successfully set!"),
    onError: (e) => print("Error setting alarm")
  );*/

  // void createTimer(TimeOfDay wakeUpTime) {
  //   int hours = wakeUpTime.hour + 24 - TimeOfDay.now().hour;
  //   int mins = wakeUpTime.minute + 60 - TimeOfDay.now().minute;
  //   final duration = Duration(hours: hours, minutes: mins);
  //   Timer(duration, alarm);
  // }

  // // create alarm
  // void alarm() {}

  Future<void> setAlarm(DateTime dateTime) async {
    await Alarm.set(
      alarmDateTime: dateTime,
      assetAudio: 'assets/fireremix.mp3',
      loopAudio: true,
      onRing: () {
        setState(() {
          isRinging = true;
        });

        stopAlarm();
      },
      notifTitle: 'Alarm notification',
      notifBody: 'Your alarm is ringing',
    );
  }

  stopAlarm() {
    // set up the button
    Widget stopButton = TextButton(
      child: Text("Stop"),
      onPressed: () {
        Alarm.stop();
        setState(() {
          isRinging = false;
        });
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ChooseAlarmPage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alarm notification"),
      content: Text("Your alarm is ringing"),
      actions: [
        stopButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Alarm Page"),
      ),
      body: Center(
        child: Column(
          children: [
            TextFormField(
              controller: timePickerController,
              decoration: const InputDecoration(
                  labelText: 'Time picker', border: OutlineInputBorder()),
            ),
            ElevatedButton(
                onPressed: () => displayTimePicker(context),
                child: const Text("Pick Time"))
          ],
        ),
      ),
    );
  }
}
