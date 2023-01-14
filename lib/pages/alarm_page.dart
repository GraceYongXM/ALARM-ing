import 'dart:async';

import 'package:alarming/pages/choose_alarm_page.dart';
import 'package:flutter/material.dart';
import 'package:alarm/alarm.dart';

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

  Future displayTimePicker(BuildContext context) async {
    var time = await showTimePicker(context: context, initialTime: wakeUpTime);

    if (time != null) {
      setState(() {
        timePickerController.text = "${time.hour}:${time.minute}";
        wakeUpTime = time;
      });
    }

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

  Future<void> setAlarm(DateTime dateTime) async {
    await Alarm.set(
      alarmDateTime: dateTime,
      assetAudio: widget.default_alarm,
      loopAudio: true,
      onRing: () {
        setState(() {
          isRinging = true;
        });

        stopAlarm();
      },
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
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChooseAlarmPage(name: widget.name)));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alarm notification"),
      content: const Text("Your alarm is ringing"),
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
