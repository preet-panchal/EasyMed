import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reminder/model/reminder.dart';

import '../model/reminder_model.dart';

class ReminderForm extends StatefulWidget {
  ReminderForm({Key? key}) : super(key: key);

  @override
  _ReminderFormState createState() {
    return _ReminderFormState();
  }
}

class _ReminderFormState extends State<ReminderForm> {
  var formKey = GlobalKey<FormState>();

  var _reminderName;
  var _reminderIntructions;
  var _lastInsertedId = 0;
  var _model = ReminderModel();
  var _replaceId;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Medication Reminder"),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: "Medication Name:",
              ),
              onChanged: (value) {
                _reminderName = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Instructions:",
              ),
              onChanged: (value) {
                _reminderIntructions = value;
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addReminder();
        },
        tooltip: 'Save',
        child: const Icon(Icons.save),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future _addReminder() async {
    Random random = new Random();
    int randomNumber = random.nextInt(10000);
    Reminder reminder = Reminder(
        id: randomNumber,
        name: _reminderName,
        instructions: _reminderIntructions);
    _lastInsertedId = await _model.insertReminder(reminder);
    print("Grade Inserted: $_lastInsertedId, ${reminder.toString()}");
  }
}
