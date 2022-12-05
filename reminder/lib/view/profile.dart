import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reminder/view/home_page.dart';
import 'package:reminder/view/reminder_list.dart';
import 'package:reminder/view/search.dart';
import 'package:reminder/view/search_table.dart';
import 'package:reminder/view/user.dart';
import 'package:reminder/view/user_info.dart';
import 'package:reminder/view/profile_widget.dart';

import 'package:reminder/main.dart';

import 'google_sign_in.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = UserInfo.myUser;

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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            icon: const Icon(Icons.person),
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 24),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildProfile(user),
        ],
      ),
    );
  }

  Widget buildProfile(User user) => Column(
        children: [
          Text(
            user.fullName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 16),
          Text(
            user.dateOfBirth,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 16),
          Text(
            user.email,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 16),
          Text(
            user.phone,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 16),
          Text(
            user.healthID,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ],
      );
}
