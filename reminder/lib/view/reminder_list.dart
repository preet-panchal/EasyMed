import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/controller/add_reminder.dart';
import 'package:reminder/view/google_sign_in.dart';
import 'package:reminder/view/login.dart';

import '../model/reminder_model.dart';

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

    Timer timer = new Timer.periodic(new Duration(milliseconds: 500),
            (Timer timer) async {
          this.setState(() {
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
    final user = FirebaseAuth.instance.currentUser!;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Medical Reminder"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Edit',
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _reminderList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                child: Container(
                    child: ListTile(
              title: Text(_reminderList[index].name),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ReminderForm()));
          setState(() {
            readReminders();
          });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future readReminders() async {
    _reminderList = await _model.getAllReminders();
  }
}
