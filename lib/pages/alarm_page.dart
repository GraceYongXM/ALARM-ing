import 'dart:async';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/services.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  AudioPlayer player = AudioPlayer();

  late AssetsAudioPlayer _assetsAudioPlayer;
  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    openPlayer();
  }

  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Audio.file("assets/audios/fireremix.mp3"),
      autoStart: true,
      showNotification: true,
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    print('dispose');
    super.dispose();
  }

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
  void createTimer(TimeOfDay wakeUpTime) {
    int hours = wakeUpTime.hour + 24 - TimeOfDay.now().hour;
    int mins = wakeUpTime.minute + 60 - TimeOfDay.now().minute;
    final duration = Duration(hours: hours, minutes: mins);
    Timer(Duration(seconds: 1), alarm);
  }

  // create alarm
  // void alarm() {
  //   _assetsAudioPlayer.playOrPause();
  //   print("playing alarm");
  // }

  void alarm() async {
    ByteData bytes =
        await rootBundle.load("audios/fireremix.mp3"); //load sound from assets
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    int result = await player.playBytes(soundbytes);
    if (result == 1) {
      //play success
      print("Sound playing successful.");
    } else {
      print("Error while playing sound.");
    }
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
