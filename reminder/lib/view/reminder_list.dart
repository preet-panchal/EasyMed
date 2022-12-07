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
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 118.2, // Pixel 4 sizing
            child: ListView.builder(
                itemCount: _reminderList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(children: <Widget>[
                    // The containers in the background
                    Column(children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 80.0,
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Material(
                              color: Colors.white,
                              elevation: 14.0,
                              shadowColor: Color(0x802196F3),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        _reminderList[index].name,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 20.0),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            _reminderList[index].date,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            _reminderList[index].time,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ]);
                }),
          ),
        ],
      ),
    );
  }

  Future readReminders() async {
    _reminderList = await _model.getAllReminders();
  }
}
