import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../controller/add_reminder.dart';
import '../model/reminder.dart';
import 'NavBar.dart';

class SearchTable extends StatefulWidget {
  SearchTable({Key? key}) : super(key: key);

  @override
  _SearchTableState createState() {
    return _SearchTableState();
  }
}

class _SearchTableState extends State<SearchTable> {

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
      appBar: navBar(context, "Find Medications", ""),
      body: StreamBuilder(
          stream: getAllMedicine(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong!");
            } else if (snapshot.hasData) {
              final reminder = snapshot.data!;
              return DataTable(
                columns: const [
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
                                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                                                        )));
                                          });
                                        },
                                        icon: const Icon(Icons.add))
                                  ],
                                )),
                          ),
                        ]))
                    .toList(),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
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
