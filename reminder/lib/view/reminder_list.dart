import 'dart:async';
import 'package:flutter/material.dart';
import '../model/reminder_model.dart';
import 'NavBar.dart';

class ReminderList extends StatefulWidget {
  ReminderList({Key? key}) : super(key: key);

  @override
  _ReminderListState createState() {
    return _ReminderListState();
  }
}

class _ReminderListState extends State<ReminderList> {
  final _model = ReminderModel();
  List _reminderList = [];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    Timer timer =
        Timer.periodic(const Duration(milliseconds: 500), (Timer timer) async {
      setState(() {
        readReminders();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: navBar(context, "EasyMed", "Medications list pulled from Firebase."),
      body: ListView.builder(
          itemCount: _reminderList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                child: Container(
                    child: ListTile(
              title: Text(_reminderList[index].time +
                  " - " +
                  _reminderList[index].name),
              subtitle: Text(_reminderList[index].instructions),
              selected: index == selectedIndex,
              selectedTileColor: Colors.redAccent,
              selectedColor: Colors.white,
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
            )));
          }),
    );
  }

  Future readReminders() async {
    _reminderList = await _model.getAllReminders();
  }
}
