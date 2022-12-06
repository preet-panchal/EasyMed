import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/view/home_page.dart';
import 'package:reminder/view/reminder_list.dart';
import 'package:reminder/view/search.dart';
import 'package:reminder/view/search_table.dart';
import 'package:reminder/view/users.dart';
import 'package:reminder/view/users_info.dart';
import 'package:reminder/view/profile_widget.dart';

import 'package:reminder/main.dart';

import 'google_sign_in.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    //final user = UserInfo.myUser;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('My Profile'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchTable()));
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReminderList()));
              },
              icon: const Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
              icon: const Icon(Icons.person),
            ),
          ],
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: [
            const SizedBox(height: 24),
            user.photoURL == null
                ? Text("")
                : ProfileWidget(
                    imagePath: user.photoURL!,
                    onClicked: () async {},
                  ),
            const SizedBox(height: 24),
            user.displayName == null
                ? Text("Guest")
                : Text(
                    user.displayName!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
            const SizedBox(height: 16),
            user.displayName == null
                ? Text("")
                : Text(
                    "2000-01-23",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
            const SizedBox(height: 16),
            user.email == null
                ? Text("")
                : Text(
                    user.email!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
            const SizedBox(height: 16),
            user.phoneNumber == null
                ? Text("")
                : Text(
                    user.phoneNumber!,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 24),
                  ),
            const SizedBox(height: 16),
            user.uid == null
                ? Text("")
                : Text(
                    user.uid!,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
          ],
        ));
  }
}
