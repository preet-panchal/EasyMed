import 'dart:math';
import 'package:intl/intl.dart';
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
  TextEditingController dateInput = TextEditingController();

  var _reminderName;
  var _reminderIntructions;
  var _lastInsertedId = 0;
  var _model = ReminderModel();
  var _replaceId;

  @override
  void initState() {
    dateInput.text = "";
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
            TextField(
              controller: dateInput,
              //editing controller of this TextField
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Enter Date" //label text of field
              ),
              readOnly: true,
              //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(
                      formattedDate); //formatted date output using intl package =>  2021-03-16
                  setState(() {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
            )
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
