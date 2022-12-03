import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:reminder/model/reminder.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import '../model/reminder_model.dart';
import 'notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class ReminderForm extends StatefulWidget {
  ReminderForm({super.key, required this.reminder});

  Reminder reminder;

  @override
  _ReminderFormState createState() {
    return _ReminderFormState();
  }
}

class _ReminderFormState extends State<ReminderForm> {
  var formKey = GlobalKey<FormState>();
  TextEditingController dateInput = TextEditingController();
  final _notifications = Notifications();

  var _reminderName;
  var _reminderIntructions;
  var _reminderUsage;
  var _lastInsertedId = 0;
  var _model = ReminderModel();
  var _replaceId;
  String title = "Add Medication Reminder";

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
    _notifications.init();
    final format = DateFormat('yyyy-MM-dd HH:mm');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue:
                  widget.reminder.name == null ? "" : widget.reminder.name,
              decoration: const InputDecoration(
                labelText: "Medication Name:",
              ),
              onChanged: (value) {
                _reminderName = value;
              },
            ),
            TextFormField(
              initialValue: widget.reminder.instructions == null
                  ? ""
                  : widget.reminder.instructions,
              decoration: const InputDecoration(
                labelText: "Instructions:",
              ),
              onChanged: (value) {
                _reminderIntructions = value;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 10,
              initialValue:
                  widget.reminder.usage == null ? "" : widget.reminder.usage,
              decoration: const InputDecoration(
                labelText: "Usage:",
              ),
              onChanged: (value) {
                _reminderUsage = value;
              },
            ),
            // TextField(
            //   controller: dateInput,
            //   //editing controller of this TextField
            //   decoration: const InputDecoration(
            //       icon: Icon(Icons.calendar_today), //icon of text field
            //       labelText: "Enter Date" //label text of field
            //       ),
            //   readOnly: true,
            //   //set it true, so that user will not able to edit text
            //   onTap: () async {
            //     DateTime? pickedDate = await showDatePicker(
            //         context: context,
            //         initialDate: DateTime.now(),
            //         firstDate: DateTime.now(),
            //         lastDate: DateTime(2100));
            //
            //     if (pickedDate != null) {
            //       print(
            //           pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
            //       String formattedDate =
            //           DateFormat('yyyy-MM-dd').format(pickedDate);
            //       print(
            //           formattedDate); //formatted date output using intl package =>  2021-03-16
            //       setState(() {
            //         dateInput.text =
            //             formattedDate; //set output date to TextField value.
            //       });
            //     } else {}
            //   },
            // ),
            DateTimeField(
              format: format,
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today), //icon of text field
                  labelText: "Enter Date & Time" //label text of field
                  ),
              onShowPicker: (context, currentValue) async {
                final date = await showDatePicker(
                    context: context,
                    initialDate: currentValue ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100));
                if (date != null) {
                  final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()));
                  widget.reminder.date = "${date.year}-${date.month}-${date.day}";
                  widget.reminder.time = "${time?.hour}:${time?.minute}";
                  return DateTimeField.combine(date, time);
                } else {
                  return currentValue;
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addReminder();
          openDialog();
          _notificationNow();
        },
        tooltip: 'Save',
        child: const Icon(Icons.save),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future _addReminder() async {
    Reminder reminder = Reminder(
        id: widget.reminder.id,
        name: widget.reminder.name,
        instructions: widget.reminder.instructions,
        usage: widget.reminder.usage,
        date: widget.reminder.date,
        time: widget.reminder.time);
    _lastInsertedId = await _model.insertReminder(reminder);
    print("Grade Inserted: $_lastInsertedId, ${reminder.toString()}");
  }

  Future openDialog() => showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Medication successfully saved to profile.'),
        ),
      );

  void _notificationNow() async {
    _notifications.sendNotificationNow(
        title, _reminderName.toString(), _reminderIntructions.toString());
  }

/**
    Future _notificationLater() async{
    var when = tz.TZDateTime.now(tz.local)
    .add(Duration(seconds: 3));

    await _notifications.sendNotificationLater("hello", "hello", "hello", when);

    var snackBar = const SnackBar(
    content: Text("Notification in 3 seconds",
    style: TextStyle(fontSize: 30),
    ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    }

    Future _showPendingNotifications() async{
    var pendingNotificationRequests
    = await _notifications.getPendingNotificationRequests();

    print("Pending Notifications:");
    for (var pendNot in pendingNotificationRequests){
    print("${pendNot.id} / ${pendNot.title} / ${pendNot.body}");
    }
    }
 **/

}
