import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reminder/model/reminder.dart';
import 'package:reminder/view/profile.dart';
import 'package:reminder/view/reminder_list.dart';

import '../controller/add_reminder.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  int selectedIndex = 0;
  Reminder? reminder;

  @override
  Widget build(BuildContext context) {
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
              final medicine = snapshot.data!;
              return ListView.builder(
                  itemCount: medicine.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                        child: Container(
                            child: ListTile(
                      title: Text(medicine[index].name.toString()),
                      subtitle: Text(medicine[index].instructions!),
                      selected: index == selectedIndex,
                      selectedTileColor: Colors.redAccent,
                      selectedColor: Colors.white,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                          reminder = Reminder(
                              id: medicine[index].id,
                              name: medicine[index].name.toString(),
                              instructions:
                                  medicine[index].instructions.toString());
                        });
                      },
                    )));
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ReminderForm(reminder: reminder!,))
            ).then((value) => {
              setState(() {
                //readReminders();
              })
            });
          });
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }

  Stream<List<Reminder>> getAllMedicine() => FirebaseFirestore.instance
      .collection("medicines")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Reminder.fromMap(doc.data())).toList());
}
