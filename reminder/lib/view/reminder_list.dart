import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/view/google_sign_in.dart';
import 'package:reminder/view/login.dart';

class ReminderList extends StatefulWidget {
  ReminderList({Key? key}) : super(key: key);

  @override
  _ReminderListState createState() {
    return _ReminderListState();
  }
}

class _ReminderListState extends State<ReminderList> {
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(user.email!),
            ],
          ),
        )// This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
