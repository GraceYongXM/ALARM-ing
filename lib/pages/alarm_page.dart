import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  // record wake up time
  final timePickerController = TextEditingController();
  TimeOfDay wakeUpTime = TimeOfDay.now();
  bool isRinging = false;

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(context: context, initialTime: wakeUpTime);

    if (time != null) {
      setState(() {
        timePickerController.text = "${time.hour}:${time.minute}";
        wakeUpTime = time;
      });
    }

    //createTimer(wakeUpTime);

    final now = DateTime.now();
    DateTime dt = DateTime(
      now.year,
      now.month,
      now.day,
      wakeUpTime!.hour,
      wakeUpTime!.minute,
    );

    setAlarm(dt);
  }

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
          //wakeUpTime = null;
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
