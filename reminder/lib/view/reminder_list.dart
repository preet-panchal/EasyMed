import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/controller/add_reminder.dart';
import 'package:reminder/view/google_sign_in.dart';
import 'package:reminder/view/login.dart';
import 'package:reminder/view/profile.dart';
import 'package:reminder/view/search.dart';
import 'package:reminder/view/search_table.dart';

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
    //final user = FirebaseAuth.instance.currentUser!;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("EasyMed"),
        actions: <Widget>[
          // IconButton(
          //   icon: const Icon(Icons.logout),
          //   tooltip: 'Edit',
          //   onPressed: () {
          //     final provider =
          //         Provider.of<GoogleSignInProvider>(context, listen: false);
          //     provider.logout();
          //   },
          // ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchTable()))
                  .then((value) => setState(() {
                        readReminders();
                      }));
              const snackText = 'Medications list pulled from Firebase.';
              final snackBar = SnackBar(
                duration: const Duration(days: 365),
                content: const Text(snackText),
                action: SnackBarAction(
                  label: 'Dismiss',
                  onPressed: () {},
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            icon: const Icon(Icons.search),
          ),

          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home),
          ),

          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            icon: const Icon(Icons.person),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => ReminderForm())
      //     ).then((value) => {
      //       setState(() {
      //         readReminders();
      //       })
      //     });
      //   },
      //   tooltip: 'Add',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future readReminders() async {
    _reminderList = await _model.getAllReminders();
  }
}
