import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reminder/view/profile.dart';
import 'package:reminder/view/reminder_list.dart';

import '../controller/add_reminder.dart';
import '../model/reminder.dart';

class SearchTable extends StatefulWidget {
  SearchTable({Key? key}) : super(key: key);

  @override
  _SearchTableState createState() {
    return _SearchTableState();
  }
}

class _SearchTableState extends State<SearchTable> {
  List<Reminder> _reminders = [];

  @override
  void initState() {
    super.initState();

    getAllMedicine();
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
        backgroundColor: Colors.red,
        title: Text('Find Medications'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReminderList()));
            },
            icon: Icon(Icons.home),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            icon: Icon(Icons.person),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: getAllMedicine(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong!");
            } else if (snapshot.hasData) {
              final reminder = snapshot.data!;
              return DataTable(
                columns: [
                  DataColumn(
                    label: Text("Name"),
                    tooltip: "Title",
                  ),
                  DataColumn(
                    label: Text(""),
                    tooltip: "Add",
                  ),
                ],
                rows: reminder!
                    .map((Reminder reminder) => DataRow(cells: [
                          DataCell(Text(reminder.name!)),
                          DataCell(
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          setState(() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ReminderForm(
                                                          reminder: reminder!,
                                                        ))).then((value) => {
                                                  setState(() {
                                                    //readReminders();
                                                  })
                                                });
                                          });
                                        },
                                        icon: Icon(Icons.add))
                                  ],
                                )),
                          ),
                        ]))
                    .toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }

  Stream<List<Reminder>> getAllMedicine() => FirebaseFirestore.instance
      .collection("medicines")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Reminder.fromMap(doc.data())).toList());
}
