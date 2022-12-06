import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder/view/profile.dart';
import 'package:reminder/view/reminder_list.dart';
import 'package:reminder/view/search_table.dart';

AppBar navBar(BuildContext context, String title, String? snackText) {
  return AppBar(
    title: Text(title),
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
              MaterialPageRoute(builder: (context) => SearchTable()));
          final snackBar = SnackBar(
            duration: const Duration(days: 365),
            content: Text(snackText!),
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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ReminderList()));
        },
        icon: const Icon(Icons.home),
      ),
      IconButton(
        onPressed: () {
          if (FirebaseAuth.instance.currentUser != null) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Profile()));
          }
        },
        icon: const Icon(Icons.person),
      )
    ],
    automaticallyImplyLeading: false,
  );
}