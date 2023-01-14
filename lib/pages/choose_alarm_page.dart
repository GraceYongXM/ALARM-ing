import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ChooseAlarmPage extends StatefulWidget {
  const ChooseAlarmPage({super.key});

  @override
  State<ChooseAlarmPage> createState() => _ChooseAlarmPageState();
}

class _ChooseAlarmPageState extends State<ChooseAlarmPage> {
  var friend;

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
            Text("Choose alarm for $friend"),
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
