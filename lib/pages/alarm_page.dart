import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  // record wake up time
  final timePickerController = TextEditingController();
  TimeOfDay wakeUpTime = TimeOfDay.now();

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(context: context, initialTime: wakeUpTime);

    if (time != null) {
      setState(() {
        timePickerController.text = "${time.hour}:${time.minute}";
        wakeUpTime = time;
      });
    }

    createTimer(wakeUpTime);
  }

  // create timer

  //final duration = Duration(hours: hours, );
  //final timer = Timer(duration, alarm);
  //const Duration

  void createTimer(TimeOfDay wakeUpTime) {
    int hours = wakeUpTime.hour + 24 - TimeOfDay.now().hour;
    int mins = wakeUpTime.minute + 60 - TimeOfDay.now().minute;
    final duration = Duration(hours: hours, minutes: mins);
    Timer(duration, alarm);
  }

  // create alarm
  void alarm() {}

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
