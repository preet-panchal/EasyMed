import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reminder/view/reminder_list.dart';

import 'login.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return ReminderList();
          } else if (snapshot.hasError) {
            return Center(child: Text("Something Went Wrong!"));
          } else {
            return LoginPage();
          }
        },
      )
  );
}
